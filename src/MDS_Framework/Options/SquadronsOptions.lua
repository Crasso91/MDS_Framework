SquadronsOptions = {
  ClassName = "SquadronsOptions",
  AttackAltitude = { 300, 400 },
  AttackSpeed = { 0, 1 },
  OverHead = 0.25,
  TakeoffMode = TakeoffMode.Cold,
  LandMode = LandMode.Shutdown, 
  TakeoffIntervall = 10,
  UnitType = UnitTypeAG.Helicopter,
  Groups = {},
  Airbases = {},
  ResourceCount = 5,
  AirbaseResourceMode = AirbaseResourceMode.EveryAirbase,
  Missions = { Mission.CAP }
}

function SquadronsOptions:New()
  local self = BASE:Inherit( self, BASE:New() )
  return self
end

function SquadronsOptions:SetAttackAltitude(_AttackAltitude)
  self.AttackSpeed = _AttackAltitude
  return self
end

function SquadronsOptions:SetAttackSpeed(_AttackSpeed)
  self.AttackSpeed = _AttackSpeed
  return self
end

function SquadronsOptions:SetOverhead(_OverHead)
  self.OverHead = _OverHead
  return self
end

function SquadronsOptions:SetTakeoffMode(_Takeoff)
  self.Takeoff = _Takeoff
  return self
end

function SquadronsOptions:SetLandMode(_LandMode)
  self.LandMode = _LandMode
  return self
end

function SquadronsOptions:SetTakeoffIntervall(_TakeoffIntervall)
  self.TakeoffIntervall = _TakeoffIntervall
  return self
end

function SquadronsOptions:SetUnitType(_UnitType)
  self.UnitType = _UnitType
  return self
end

function SquadronsOptions:SetAirbaseResourceMode(_AirbaseResourceMode)
  self.AirbaseResourceMode = _AirbaseResourceMode
  return self
end

function SquadronsOptions:SetMissions(_Mission)
  self.Missions = _Mission
  return self
end

function SquadronsOptions:SetResourceCount(_ResourceCount)
  self.ResourceCount = _ResourceCount
  return self
end

function SquadronsOptions:SetGroups(_Groups, _arePrefix)
--  if _arePrefix then
--    self.Groups = GROUP_SET:New()
--      :FilterPrefixes(_Groups)
--      :FilterStart()
--      .Set
--  else
--    local foundedGroups = {}
--    for groupId, group in _Groups do
--      table.insert(foundedGroups, GROUP:New(group))
--    end
--    self.Groups = foundedGroups
--  end 
  self.Groups = _Groups
  return self
end

function SquadronsOptions:SetTemplates(_templates)
  for id, _template in pairs(_templates) do
    local group = GROUP:NewTemplate(_template.Group, _template.Group.CoalitionID, _template.Group.CategoryID, _template.Group.CountryID)
    
    local _templateGroup = SPAWN:New(_template.Group.name)
      :InitLateActivated(true)
      :_Prepare( _template.Group.name, math.random(1,10000) )
      
    local _templateGroup = SPAWN:NewFromTemplate(_templateGroup, _template.Group.name, _template.Group.name)
      --:InitRandomizeZones({ ZONE:New("LATE_ACTIVED_ZONE") })
      :InitLateActivated(true)
      --:SpawnFromCoordinate(PointVec2:AddX( 0 ):AddY( 0 ):GetVec2())
      --:Spawn()
      :SpawnFromVec2({x=0,y=0})
      _DATABASE.GROUPS[_template.Group.name] = nil
      _DATABASE.Templates.Groups[_template.Group.name] = nil
    -- = group
    table.insert(self.Groups, _templateGroup.GroupName)
  end
  return self;
end

function SquadronsOptions:SetAirbases(_Airbases, _arePrefix)
  local foundedGroups = {}
  if _arePrefix then
    local groups = ZonesManagerService:GetZonesByPrefix(_Airbases)
      
    for i, group in pairs(groups) do
    local airbaseFound = nil;
--      local airbase = SET_AIRBASE:New()
--        :FindAirbaseInRange(group:GetVec2(), 10000)
      for AirbaseName, AirbaseObject in pairs( _DATABASE.AIRBASES ) do
      
        local AirbaseCoordinate = AirbaseObject:GetCoordinate()
        local Distance = group:GetPointVec2():Get2DDistance( AirbaseCoordinate )
        
        self:F({Distance=Distance})
      
        if Distance <= 10000 then
          airbaseFound = AirbaseObject
          break
        end
          
      end

      table.insert(foundedGroups, airbaseFound)
      env.info("asd")
    end
    
  else
    for i, airbase in ipairs(_Airbases) do
      table.insert(foundedGroups, AIRBASE:FindByName(airbase))
    end
  end 
  self.Airbases = foundedGroups
  return self
end

function SquadronsOptions:GetRandomAirbase()
  local count = 0
  
  for i,airbase in ipairs(self.Airbases) do
    count = count + 1
  end
  
  local random = math.random(1,count)
  
  return self.Airbases[random]
end
