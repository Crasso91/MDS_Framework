UnitTypeAG = {
  Ground = "Ground",
  Helicopter = "Helicopter",
  Airplane = "Airplane"
}

TakeoffMode = {
  Cold = "Cold",
  Hot = "Hot",
  Runway = "Runway",
  Air = "Air"
}

LandMode = {
  Shutdown = "Shutdown",
  Runway = "Runway",
  NearAirbase = "NearAirbase"
}

Rectivity = {
  High = "High",
  Medium = "Medium",
  Low = "Low"
}

AirbaseResourceMode = {
  EveryAirbase = "EveryAirbase",
  RandomAirbase = "RandomAirbase"
}

Mission = {
  CAP = "CAP",
  CAS = "CAS",
  BAI = "BAI",
  SEAD = "SEAD"
}

A2GDispatcherOptions = {
  ClassName = "A2GDispatcherOptions",
  __index = A2GDispatcherOptions,
  CommandCenter = nil,
  DetectionArea = 5000,
  DefenseRadious = 20000,
  Reactivity = Rectivity.High,
  TacticalDisplay = true,
  DetectionGroups = {},
  DefenceCoordinates = {}
}

function A2GDispatcherOptions:New()
  local self = BASE:Inherit( self, BASE:New() )
  return self
end

function A2GDispatcherOptions:SetCommandCenter(_commandCenterName)
  self.CommandCenter = GROUP:FindByName(_commandCenterName)
  return self
end

function A2GDispatcherOptions:SetDetectionArea(_DetectionArea)  
  self.DetectionArea = _DetectionArea
  return self
end

function A2GDispatcherOptions:SetDefenseRadious(_defenseRadious)  
  self.DefenseRadious = _defenseRadious
  return self
end

function A2GDispatcherOptions:SetReactivity(_reactivity)
  self.Reactivity = _reactivity
  return self
end

function A2GDispatcherOptions:SetTacticalDisplay(_tacticalDisplay)
  self.TacticalDisplay = _tacticalDisplay
  return self
end


function A2GDispatcherOptions:SetDetectionGroups(_Groups, _arePrefix)
  if _arePrefix then
    self.DetectionGroups = SET_GROUP:New()
      :FilterPrefixes(_Groups)
      :FilterStart()
  else
    local foundedGroups = {}
    for groupId, groupName in ipairs(_Groups) do
      --table.insert(foundedGroups, GROUP:FindByName(group))
      local group = GROUP:FindByName(group)
      foundedGroups[groupName] = group
    end
    self.DetectionGroups = foundedGroups
  end 
  return self
end

function A2GDispatcherOptions:SetDefenceCoordinates(_triggers, _arePrefix)
  if _arePrefix then
    self.DefenceCoordinates = SET_ZONE:New()
      :FilterPrefixes(_triggers)
      :FilterStart()
      .Set
  else
    local foundedGroups = {}
    for id, trigger in ipairs(_triggers) do
      table.insert(foundedGroups, ZONE:FindByName(trigger))
    end
    self.DefenceCoordinates = foundedGroups
  end 
  return self
end
SquadronsOptions = {
  ClassName = "SquadronsOptions",
  AttackAltitude = { 300, 400 },
  AttackSpeed = { 0, 1 },
  OverHead = 0.25,
  TakeoffMode = TakeoffMode.Cold,
  LandMode = LandMode.Shutdown, 
  TakeoffIntervall = 10,
  UnitType = UnitTypeAG.Helicopter,
  Groups = nil,
  Airbases = nil,
  ResourceCount = 5,
  AirbaseResourceMode = AirbaseResourceMode.EveryAirbase,
  Mission = Mission.CAP
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

function SquadronsOptions:SetOverHead(_OverHead)
  self.OverHead = _OverHead
  return self
end

function SquadronsOptions:SetTakeoff(_Takeoff)
  self.Takeoff = _Takeoff
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
A2GDispatcherInitializator = {
  ClassName = "A2GDispatcherInitializator",
  DispatcherOptions = nil,
  Options = nil,
}

function A2GDispatcherInitializator:New(_options) 
  self.DispatcherOptions = _options
  return self
end

function A2GDispatcherInitializator:SetSquadronsOptions(_options)
  self.Options = _options
  return self
end

function A2GDispatcherInitializator:Init() 

  local Detection = DETECTION_AREAS:New( self.DispatcherOptions.DetectionGroups, self.DispatcherOptions.DetectionArea )
  local A2GDispatcher = AI_A2G_DISPATCHER:New( Detection )
  
  for id, defencePoint in pairs(self.DispatcherOptions.DefenceCoordinates) do
    A2GDispatcher:AddDefenseCoordinate( defencePoint.ZoneName, defencePoint:GetPointVec2() )
  end
  
  if  self.DispatcherOptions.Reactivity == Rectivity.High then
    A2GDispatcher:SetDefenseReactivityHigh()
  elseif self.DispatcherOptions.Reactivity == Rectivity.Medium then
    A2GDispatcher:SetDefenseReactivityMedium()
  elseif self.DispatcherOptions.Reactivity == Rectivity.Low then
    A2GDispatcher:SetDefenseReactivityLow()
  else 
    A2GDispatcher:SetDefenseReactivityMedium() 
  end
  
  A2GDispatcher:SetDefenseRadius( self.DispatcherOptions.DefenseRadious )
  A2GDispatcher:SetCommandCenter( self.DispatcherOptions.CommandCenter )
  A2GDispatcher:SetTacticalDisplay( self.DispatcherOptions.TacticalDisplay )
  self:SetSquadrons(A2GDispatcher)
  return self
  
end

function A2GDispatcherInitializator:SetSquadrons(_A2GDispatcher)
  local count = 1
  for i,option in ipairs(self.Options) do
    if option.AirbaseResourceMode == AirbaseResourceMode.EveryAirbase then
        for i,airbase in ipairs(option.Airbases) do
          local SquadronName = option.Mission .. "_" .. count
          _A2GDispatcher:SetSquadron( SquadronName, airbase.AirbaseName, option.Groups, option.ResourceCount )
          self:SetSquadronMission(SquadronName, option, _A2GDispatcher)
          self:SetSquadronTakeoff(SquadronName, option, _A2GDispatcher)
          self:SetSquadronLand(SquadronName, option, _A2GDispatcher)
          _A2GDispatcher:SetSquadronOverhead( SquadronName, option.OverHead )
          _A2GDispatcher:SetSquadronTakeoffInterval( SquadronName, option.TakeoffIntervall )
          count = count + 1
        end
    else
      local SquadronName = option.Mission .. "_" .. count
      _A2GDispatcher:SetSquadron( SquadronName, option:GetRandomAirbase().AirbaseName, option.Groups, option.ResourceCount )
      self:SetSquadronMission(SquadronName, option, _A2GDispatcher)
      self:SetSquadronTakeoff(SquadronName, option, _A2GDispatcher)
      self:SetSquadronLand(SquadronName, option, _A2GDispatcher)
      _A2GDispatcher:SetSquadronOverhead( SquadronName, option.OverHead )
      _A2GDispatcher:SetSquadronTakeoffInterval( SquadronName, option.TakeoffIntervall )
      count = count + 1
    end
  end 
end

function A2GDispatcherInitializator:SetSquadronMission(_squadronName, _option, _A2GDispatcher)
  if _option.Mission == Mission.BAI then
    _A2GDispatcher:SetSquadronBai( _squadronName, _option.AttackSpeed[1], _option.AttackSpeed[2], _option.AttackAltitude[1], _option.AttackAltitude[2])
  elseif _option.Mission == Mission.CAS then
    _A2GDispatcher:SetSquadronCas( _squadronName, _option.AttackSpeed[1], _option.AttackSpeed[2], _option.AttackAltitude[1], _option.AttackAltitude[2])
  elseif _option.Mission == Mission.SEAD then
    _A2GDispatcher:SetSquadronSead( _squadronName, _option.AttackSpeed[1], _option.AttackSpeed[2], _option.AttackAltitude[1], _option.AttackAltitude[2])
  else 
    _A2GDispatcher:SetSquadronCas( _squadronName, _option.AttackSpeed[1], _option.AttackSpeed[2], _option.AttackAltitude[1], _option.AttackAltitude[2])
  end
end

function A2GDispatcherInitializator:SetSquadronTakeoff(_squadronName, _option, _A2GDispatcher)
  if _option.TakeoffMode == TakeoffMode.Air then
    _A2GDispatcher:SetDefaultTakeoffInAir(_squadronName)
  elseif _option.TakeoffMode == TakeoffMode.Cold then
    _A2GDispatcher:SetDefaultTakeoffFromParkingCold(_squadronName)
  elseif _option.TakeoffMode == TakeoffMode.Hot then
    _A2GDispatcher:SetDefaultTakeoffFromParkingHot(_squadronName)
  elseif _option.TakeoffMode == TakeoffMode.Runway then
    _A2GDispatcher:SetDefaultTakeoffFromRunway(_squadronName) 
  else
    _A2GDispatcher:SetDefaultTakeoffFromParkingCold(_squadronName)
  end
end


function A2GDispatcherInitializator:SetSquadronLand(_squadronName, _option, _A2GDispatcher)
  if _option.LandMode == LandMode.NearAirbase then
    _A2GDispatcher:SetSquadronLandingNearAirbase(_squadronName)
  elseif _option.LandMode == LandMode.Runway then
    _A2GDispatcher:SetSquadronLandingAtRunway(_squadronName)
  elseif _option.LandMode == LandMode.Shutdown then
    _A2GDispatcher:SetSquadronLandingAtEngineShutdown(_squadronName)
  else 
    _A2GDispatcher:SetSquadronLandingAtEngineShutdown(_squadronName)
  end
end
-- Service per la gestione delle zone predefinite nella mappa attraverso i Trigger
-- Per poter essere gestiti da questo service i trigger devono avere la segunte nomenclatura:
-- Nome_Tipo_Sottotipo ex. Trigger112_0_0 = Trigger112_AG_CONVOY

--Elenco delle numerazioni: 
--Tipi:
--AG = 0,
--AA = 1,
--Sottotipi:
--CONVOY = 0,
--CAP = 1,
--CAS = 2,
--STATIC = 3

ZonesManagerService = {
  ClassName = "ZonesManagerService",
--  Zones = {},
--  ZonesCount = 0
}

function ZonesManagerService:New()
--  for ZoneID, ZoneData in pairs(DATABASE.ZONES) do
--    local zoneNameSplitted = split(ZoneData.ZoneName, "_")
--    local zoneName = zoneNameSplitted[0]
--    local type = zoneNameSplitted[1]
--    local subtype = zoneNameSplitted[2]
--    
--    local zoneEnriched = ZONE_ENRICHED:NEW(ZoneData, zoneName, type, subtype)
--    
--    if zoneName ~= nil then
--      self.Zones[zoneName] = zoneEnriched
--      self.ZonesCount = self.ZonesCount + 1;
--    end 
--  end
return self
end

function ZonesManagerService:GetZonesByPrefix(_prefix)
  env.info("GetZonesByPrefix")
  return SET_ZONE:New()
    :FilterPrefixes(_prefix)
    :FilterStart().Set
end

function ZonesManagerService:GetSetZonesByPrefix(_prefix)
  env.info("GetZonesByPrefix")
  return SET_ZONE:New()
    :FilterPrefixes(_prefix)
    :FilterStart()
end

function ZonesManagerService:GetZoneByName(_name)
  return ZONE:New(_name)
end

function ZonesManagerService:GetRandomZone()
  local zones = SET_ZONE:New()
    :FilterPrefixes()
    :FilterStart()
  local count = 0
  
  for zoneId, zone in pairs(zones) do
    count = count + 1  
  end
  
  local random = math.random(0, count)
  
  return zones[random]
end

function ZonesManagerService:GetRandomZoneByPrefix(_prefix)
  env.info("GetRandomZoneByPrefix")
  local set_zone = self:GetSetZonesByPrefix(_prefix)
  local count = 0
  
  for zoneId, zone in pairs(set_zone.Set) do
    count = count + 1  
  end
  
  local random = math.random(1, count)
  
  return set_zone.Set[set_zone.Index[random]]:GetZoneMaybe() 
end

--function ZonesManagerService:GetZoneByName(_zoneName)
--  local zoneFound = self.AG[_zoneName]
--  
--  if zoneFound == nil then
--    zoneFound = self.AA[_zoneName]
--  end
--  
--  return zoneFound;
--end
--
--function ZonesManagerService:GetZonesByType(_zoneType)
--  local _return = {}
--  for zoneId, zone in pairs(self.Zones) do
--    if zone.Type == _zoneType then
--      _return[zone.ZoneName] = zone
--    end
--  end
--  return _return
-- end
--
--function ZonesManagerService:GetZonesBySubType(_zoneSubType)
--  local _return = {}
--  for zoneId, zone in pairs(self.Zones) do
--    if zone.SubType == _zoneSubType then
--      _return[zone.ZoneName] = zone
--    end
--  end
--  return _return 
--end
--
--function ZonesManagerService:GetRandomZone()
--  local _return = {}
--  local random = math.random(0, self.ZonesCount)
--  
--  return self.zones[random]
--    
--end
--
--function ZonesManagerService:GetRandomZoneByType(_zoneType)
--  local zones = self:GetZonesByType(_zoneType)
--  local zonesCount = 0
--  for zoneis, zone in pairs(zones) do
--    zonesCount = zonesCount + 1
--  end
--  local random = math.random(0, zonesCount)
--  return zones[random]
--end
--
--function ZonesManagerService:GetRandomZoneBySubType(_zoneType)
--  local zones = self:GetZonesBySubType(_zoneType)
--  local zonesCount = 0
--  for zoneis, zone in pairs(zones) do
--    zonesCount = zonesCount + 1
--  end
--  local random = math.random(0, zonesCount)
--  return zones[random]
--end

