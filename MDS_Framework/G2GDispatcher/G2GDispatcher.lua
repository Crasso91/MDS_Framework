AI_G2G_Dispatcher = {
    ClassName = "AI_G2G_Dispatcher",
    Coalition = nil,
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
    Reactivity = Reactiviy.High,
    SimultaneuslyMissions = 1,
    MissionScheduleTime = 30
}

function AI_G2G_Dispatcher:New(_detection) 
  local self = BASE:Inherit( self, DETECTION_MANAGER:New( nil, _detection ) ) -- #AI_G2G_DISPATCHER
  self.Detection = _detection
  
  --Setting default defence zone on detection zones
  for k,v in pairs(_detection) do
      table.insert(self.DefenceZones, v:GetVec3())
  end
  
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
end

function AI_G2G_Dispatcher:SetFaction(_in)
  self.Faction = _in
end

function AI_G2G_Dispatcher:SetOverhead(_in)
  self.OverHead = _in
end

function AI_G2G_Dispatcher:AddDefenceZone(_zones, _isPrefix)
  if _group ~= table then
    _group = { _group }
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
      for i,z in pairs(v) do
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
      for i,z in pairs(v) do
        if v.IsPrefix then
          local set_zone = SET_GROUP:New()
            :FilterPrefixes(z)
            :FilterStop()
            .Set
          table.inset(self.MissionGroups, set_zone)
        else
          table.insert(self.MissionGroups, GROUP:New(z))
        end
    end
  end
end

function AI_G2G_Dispatcher:_InitReinforceGroups()
  for k,v in pairs(self.ReinforceGroupsNames) do
    local zones = nil
      for i,z in pairs(v) do
        if v.IsPrefix then
          local set_zone = SET_GROUP:New()
            :FilterPrefixes(z)
            :FilterStop()
            .Set
          table.inset(self.ReinforceGroups, set_zone)
        else
          table.insert(self.ReinforceGroups, GROUP:New(z))
        end
    end
  end
end
  
function AI_G2G_Dispatcher:Init()
  
  if self.Coalition == nil and self.HQ ~= nil then
    self.Coalition = self.HQ.CoalitionID()
  end
  
  if self.Faction == nil and self.HQ ~= nil then
    self.Faction = self.HQ.CountryID
  end
  
  if UtilitiesService:Lenght(self.DefenceZonesNames) > 0 then
    self:_InitZones()
    
    for i,zone in pairs(self.DefenceZones) do
      zone:HandleEvent(EVENTS.MarkChange, function(EventData) self:OnMarkChange(EventData) end)
    end
  end
  
  if UtilitiesService:Length(self.MissionGroupsNames) > 0 then
    self:_InitMissionGroups()
  end
  
  if UtilitiesService:Lenght(self.ReinforceGroupsNames) > 9 then
    self:_InitReinforceGroups()
  end
end

function AI_G2G_Dispatcher:OnMarkChange(_eventData)
  if _eventData.coalition ~= self.Coalition then
    local attackerGroup = GROUP:FindByName(_eventData.groupID)
    local attackerUnits = attackerGroup:GetAliveUnits()
    
    if attackerGroup.CategoryID == Group.Category.ARMOR then
      local missionGroups = nil
      for k,v in pairs(self.MissionGroups) do
        if v.Mission == Mission.Ground.ATTACK then
          table.insert(missionGroups, v.List)
        end
      end
      
      local group = UtilitiesService:GetRandomOfUnsequncialTable(missionGroups)
      local missionGroup = routines.utils.deepCopy(group)
      local attackerUnitsNumber = math.floor(attackerUnits / self.OverHead)
      
      for i = 2, attackerUnitsNumber do
        local unitToAdd = routines.utils.deepCopy(group:GetUnits()[1])
        missionGroup:GetUnits()[i] = unitToAdd
      end
      
      SPAWN:New(missionGroups)
        :InitRandomizeRoute( 1, 1, 200 ) 
        :InitRandomizePosition(500, 50)
        :InitRandomizeUnits(true,50,15)
        :InitRandomizeZones(HQ:)
        :OnSpawnGroup(
          function(SpawnGroup)
        
    end
  end
end