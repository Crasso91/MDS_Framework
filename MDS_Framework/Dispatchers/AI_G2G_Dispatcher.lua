AI_G2G_Dispatcher = {
    ClassName = "AI_G2G_Dispatcher",
    Coalition = nil,
    EnemyCoalition = nil,
    Faction = nil,
    HQ = nil,
    Detection = {},
    DefenceZonesNames = {},
    DefenceZones = {},
    MissionGroupsNames = {},
    MissionGroups = {},
    OverHead = 0.5,
    RunningMissons = {},
    ReinforceGroups = {},
    ReinforceGroupsNames = {},
    IntegratedDispatcher = {},
    Reactivity = Reactivity.High,
    SimultaneuslyMissions = 2,
    MissionScheduleTime = 30,
    _FSM = FSM:New(),
    ActiveMissions = {}
}

function AI_G2G_Dispatcher:New(_detection) 
  local self = BASE:Inherit( self, DETECTION_MANAGER:New( nil, _detection ) ) -- #AI_G2G_DISPATCHER
  self.Detection = _detection
  --Setting default defence zone on detection zones
--  for k,v in pairs(_detection:GetDetectionSet()) do
--      table.insert(self.DefenceZones, v:GetVec3())
--  end
  
  return self
end

function AI_G2G_Dispatcher:SetHQ(_hqName)  
  local _hq = GROUP:FindByName(_hqName)
  
  if _hq == nil then
    self:T("HQ group not found")
  end
  
  self.HQ = _hq
  return self
end

function AI_G2G_Dispatcher:SetCoalition(_in) 
  self.Coalition = _in
  return self
end

function AI_G2G_Dispatcher:SetFaction(_in)
  self.Faction = _in
  return self
end

function AI_G2G_Dispatcher:SetOverhead(_in)
  self.OverHead = _in
  return self
end

function AI_G2G_Dispatcher:AddDefenceZone(_zones, _isPrefix)
  if _zones ~= table then
    _zones = { _zones }
  end
  local object = { List = _zones, IsPrefix = _isPrefix}
  table.insert(self.DefenceZonesNames, object)

  return self
end

function AI_G2G_Dispatcher:AddMissionGroup(_group, _mission, _isPrefix)
  if _group ~= table then
    _group = { _group }
  end
  local object = { List = _group, Mission = _mission, IsPrefix = _isPrefix}
  table.insert(self.MissionGroupsNames, object)
  return self
end

function AI_G2G_Dispatcher:AddMissionGroupFromTemplate(_category, _mission, _unitType)
  local group = TemplateManager:InitLazyGroupsByFilters(self.Coalition, self.Faction, _category, _mission, _unitType)
    :GetLazyGroupsNames()
    
  local object = { List = group, Mission = _mission, IsPrefix = false}
  table.insert(self.MissionGroupsNames, object)
  return self
end

function AI_G2G_Dispatcher:AddReinforceGroup(_group, _mission, _isPrefix)
  if _group ~= table then
    _group = { _group }
  end
  local object = { List = _group, Mission = _mission, IsPrefix = _isPrefix}
  table.insert(self.ReinforceGroupsNames, object)
  return self
end

function AI_G2G_Dispatcher:SetReactivity(_reactivity)
  if _reactivity == nil then
    self:T("Reactiviy is nil")
    return self
  end
  self.reactivity = _reactivity
  return self
end

function AI_G2G_Dispatcher:SetSimultaneuslyMissions(_in)
  if _in == nil then
    self:T("integer input is nil")
    return self
  end
  
  self.SimultaneuslyMissions = _in
  return  self
end

function AI_G2G_Dispatcher:SetMissionScheduledTime(_in)
  if _in == nil then
    self:T("Missione schedule time is nil")
    return self
  end
  
  self.MissionScheduleTime = _in
  return self
end

function AI_G2G_Dispatcher:AddDispatcherIntegration(_dispatcherType, _dispatcher)
  if _dispatcherType == nil then
    self:T("Provided disaptcherType is nil")
    return self
  end
  if _dispatcher == nil then
    self:T("Provided disaptcher si nil")
    return self
  end
  
  table.insert(self.IntegratedDispatcher, { Type = _dispatcherType, Dispatcher = _dispatcher })
  return self
end

function AI_G2G_Dispatcher:_InitZones()
  for k,v in pairs(self.DefenceZonesNames) do
    local zones = nil
      for i,z in pairs(v.List) do
        if v.IsPrefix then
          local set_zone = SET_ZONE:New()
            :FilterPrefixes(z)
            :FilterStop()
            .Set
          table.inset(self.DefenceZones, set_zone)
        else
          table.insert(self.DefenceZones, ZONE:New(z))
        end
    end
  end
end

function AI_G2G_Dispatcher:_InitMissionGroups()
  for k,v in pairs(self.MissionGroupsNames) do
    local zones = nil
      for i,z in pairs(v.List) do
        if v.IsPrefix then
          local set_zone = SET_GROUP:New()
            :FilterPrefixes(z)
            :FilterStop()
            .Set
          table.inset(self.MissionGroups, set_zone)
        else
          table.insert(self.MissionGroups, GROUP:FindByName(z))
        end
    end
  end
end

function AI_G2G_Dispatcher:_InitReinforceGroups()
  for k,v in pairs(self.ReinforceGroupsNames) do
    local zones = nil
      for i,z in pairs(v.List) do
        if v.IsPrefix then
          local set_zone = SET_GROUP:New()
            :FilterPrefixes(z)
            :FilterStop()
            .Set
          table.inset(self.ReinforceGroups, set_zone)
        else
          table.insert(self.ReinforceGroups, GROUP:FindByName(z))
        end
    end
  end
end
 
function AI_G2G_Dispatcher:Init()

  if self.Coalition == nil and self.HQ ~= nil then
    self.Coalition = self.HQ:GetCoalition() 
  end
  
  if self.Faction == nil and self.HQ ~= nil then
    self.Faction = self.HQ:GetCountry()
  end
  
  if self.Coalition == coalition.side.BLUE then
    self.EnemyCoalition = coalition.side.RED
  else
    self.EnemyCoalition = coalition.side.BLUE
  end
  
  self:_InitZones()
  self:_InitMissionGroups()
  self:_InitReinforceGroups()
    
  --for i,zone in pairs(self.DefenceZones) do
    --zone:HandleEvent(EVENTS.MarkChange, function(EventData) self:OnMarkChange(EventData) end)
  --end
  
  local enemies = SET_GROUP:New()
    :FilterCategoryGround()
    :FilterStart()
    .Set
    
    for i,zone in pairs(self.DefenceZones) do
    self._FSM:AddTransition(zone.ZoneName.."_ZoneBlue", "Switch", zone.ZoneName.."_ZoneRed")
    self._FSM:AddTransition(zone.ZoneName.."_ZoneRed", "Switch", zone.ZoneName.."_ZoneBlue")
     for eId,enemy in pairs(enemies) do
      SCHEDULER:New(nil, function(_zone) 
        local enemiesInZone = enemy:IsPartlyOrCompletelyInZone(_zone)
        
        if enemiesInZone then
          self._FSM:__Switch(5, self, _zone)
          self:SendReinforceIfNecessary("ZoneRed",_zone)
        end
      end, { zone }, 30, 30)
--      for uId, unit in pairs(enemy:GetUnits()) do
        
--        SCHEDULER:New(nil, function(_zone, _enemy)
--          local enemiesInZone = _enemy:IsPartlyOrCompletelyInZone(_zone)
--          local friendlyGroups = SET_GROUP:New()
--            :FilterCoalition
--        
--        end, { zone, enemy })
--        Trigger:New()
--          :SetUnitName(unit.UnitName)
--          :SetTriggerName(zone.ZoneName)
--          :SetCoalition(self.EnemyCoalition)
--          :SetActivationMeter(zone.Zone.radius)
--          :SetActionPredicate(Predicate.Action.MarkCoalition)
--          :SetConditionPredicate(Predicate.Condition.UnitInZone)
--          :_Prepare()
--          :AddToMission()
      end
--    end
   end
end

function AI_G2G_Dispatcher._FSM:OnAfterSwitch(from, event, to, _self, _zone)
  self:SendReinforceIfNecessary(to,_zone)
end

function AI_G2G_Dispatcher:SendReinforceIfNecessary(to, _zone)
  if to == "ZoneRed" and not self:ExistsActiveMission(_zone) then
    local enemyGroups = SET_GROUP:New()
      :FilterCoalitions(string.lower(UtilitiesService:GetEnumKeyByValue(coalition.side, self.EnemyCoalition)))
      :FilterCategoryGround()
      :FilterStart()
    
    local friendlyGroups = SET_GROUP:New()
      :FilterCoalitions(string.lower(UtilitiesService:GetEnumKeyByValue(coalition.side, self.Coalition)))
      :FilterCategoryGround()
      :FilterStart()
    
     local aliveEnemies = 0
     local aliveFriendlies = 0
     enemyGroups:ForEachGroupCompletelyInZone(_zone, function() aliveEnemies = aliveEnemies + 1 end) 
     enemyGroups:ForEachGroupPartlyInZone(_zone, function() aliveEnemies = aliveEnemies + 1 end) 
     friendlyGroups:ForEachGroupCompletelyInZone(_zone, function() aliveFriendlies = aliveFriendlies + 1 end)
     friendlyGroups:ForEachGroupPartlyInZone(_zone, function() aliveFriendlies = aliveFriendlies + 1 end)
   
   
   
    if aliveEnemies > (aliveFriendlies * self.OverHead) then  
      local reinfGroup = UtilitiesService:GetRandomOfUnsequncialTable(self.ReinforceGroups)
      self:StartMissionAttack(reinfGroup, _zone, aliveEnemies)
--      local reinfGroup = UtilitiesService:GetRandomOfUnsequncialTable(self.ReinforceGroups)
--      SPAWN:New(reinfGroup.GroupName)
--        :InitLimit(aliveEnemies * self.OverHead)
--        :InitRandomizeRoute( 1, 1, 200 ) 
--        :InitRandomizePosition(500, 50)
--        :InitRandomizeZones( { ZONE_GROUP:New("Zone_" .. self.HQ.GroupName, self.HQ, 200) } )
--        :OnSpawnGroup( function (_spawnedGroup)
--          _spawnedGroup:TaskRouteToZone(_zone,true,150,"On Road")
--        end)
--        :SpawnScheduled(5, .5)
    end
  end
end

function AI_G2G_Dispatcher:StartMissionAttack(_group, _attackZone, aliveEnemies)
  SPAWN:New(_group.GroupName)
    :InitLimit(aliveEnemies * self.OverHead, 1)
    :InitRandomizeRoute( 1, 1, 200 ) 
    :InitRandomizePosition(500, 50)
    :InitRandomizeZones( { ZONE_GROUP:New("Zone_" .. self.HQ.GroupName, self.HQ, 200) } )
    :OnSpawnGroup( function (_spawnedGroup)
      _spawnedGroup:TaskRouteToZone(_attackZone,true,150,"On Road")
    end)
    :SpawnScheduled(5, .5)
    
  self.ActiveMissions["AttackMisson_"..timer:getAbsTime()] = {
    Group = _group,
    DestinationZone = _attackZone
  }
end

function AI_G2G_Dispatcher:ExistsActiveMission(_attackZone)
  for k,v in pairs(self.ActiveMissions) do 
    if v.DestinationZone.ZoneName == _attackZone.ZoneName then
      return true
    end
  end
  return false
end

