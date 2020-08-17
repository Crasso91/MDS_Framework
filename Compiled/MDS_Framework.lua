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

Reactivity = {
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

Dispatcher = {
  AG = "AG",
  AA = "AA",
  Task = "Task",
  Ground = "Ground"
}

Configuration = {
    Settings = {
    Coalition = "Blue",
    Nation = "USA",
    Era = 1990,
    TakeoffMode = TakeoffMode.Hot,
    LandMode = LandMode.Runway,
    A2GDispatcherBlue_Active = true,
    A2GDispatcherRed_Active = false    
  }
}

Configuration.Dispatchers = {
    ["Blue"] = {
      ["USA"] = {
        CommandCenter = "HQ",
        DetectionArea = 10000,
        DefenseRadious = 50000,
        Reactivity = Reactivity.High,
        TacticalDisplay = true,
        DispatcherType = Dispatcher.AG,
        TakeoffMode = Configuration.Settings.TakeoffMode,
        TakeoffInterval = 20,
        LandMode = Configuration.Settings.LandMode, 
        Active = Configuration.Settings.A2GDispatcherBlue_Active,
        DetectionGroups = { 
          { Name = "Detection", isPrefix = true }
        },
        DefenceCoordinates = {
          { Name = "Defence", isPrefix = true }
        },
        Units = {
          ["A10"] = {
            Airbases = { 
              { Name = "BAI_CAS_", isPrefix = true }  
            },
            Missions = {
              [Mission.BAI] = {
                AttackAltitude = { 2000 , 3000 },
                AttackSpeed = { 360, 450 },
                Overhead = 0.25,
                AirbaseResourceMode = AirbaseResourceMode.RandomAirbase,
                ResourceCount = 4,
                Active = true
              },
              [Mission.CAS] = {},
              [Mission.SEAD] = {}
            }
          },
          ["Apache"] = {
            Airbases = { 
              { Name = "BAI_CAS_", isPrefix = true }  
            },
            Missions = {
              [Mission.BAI] = {
                AttackAltitude = { 2000 , 3000 },
                AttackSpeed = { 360, 450 },
                Overhead = 0.50,
                AirbaseResourceMode = AirbaseResourceMode.EveryAirbase,
                ResourceCount = 4,
                Active = true
              },
              [Mission.CAS] = {},
              [Mission.SEAD] = {}
            }
          }
        }
      }
    }
  }

A2GDispatcherOptions = {
  ClassName = "A2GDispatcherOptions",
  __index = A2GDispatcherOptions,
  CommandCenter = nil,
  DetectionArea = 5000,
  DefenseRadious = 20000,
  Reactivity = Reactivity.High,
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
A2GDispatcherInitializator = {
  ClassName = "A2GDispatcherInitializator",
  DispatcherOptions = nil,
  Options = nil
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
  
  if  self.DispatcherOptions.Reactivity == Reactivity.High then
    A2GDispatcher:SetDefenseReactivityHigh()
  elseif self.DispatcherOptions.Reactivity == Reactivity.Medium then
    A2GDispatcher:SetDefenseReactivityMedium()
  elseif self.DispatcherOptions.Reactivity == Reactivity.Low then
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
          local SquadronName = airbase.AirbaseName .. "_" .. count
          _A2GDispatcher:SetSquadron( SquadronName, airbase.AirbaseName, option.Groups, option.ResourceCount )
          self:SetSquadronMission(SquadronName, option, _A2GDispatcher)
          self:SetSquadronTakeoff(SquadronName, option, _A2GDispatcher)
          self:SetSquadronLand(SquadronName, option, _A2GDispatcher)
          _A2GDispatcher:SetSquadronOverhead( SquadronName, option.OverHead )
          _A2GDispatcher:SetSquadronTakeoffInterval( SquadronName, option.TakeoffIntervall )
          count = count + 1
        end
    else
      local airbaseName = option:GetRandomAirbase().AirbaseName
      local SquadronName = airbaseName .. "_" .. count
      _A2GDispatcher:SetSquadron( SquadronName, airbaseName, option.Groups, option.ResourceCount )
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
--  for i , mission in ipairs(_option.Missions) do
    if _option.Missions == Mission.BAI then
      _A2GDispatcher:SetSquadronBai( _squadronName, _option.AttackSpeed[1], _option.AttackSpeed[2], _option.AttackAltitude[1], _option.AttackAltitude[2])
    elseif _option.Missions == Mission.CAS then
      _A2GDispatcher:SetSquadronCas( _squadronName, _option.AttackSpeed[1], _option.AttackSpeed[2], _option.AttackAltitude[1], _option.AttackAltitude[2])
    elseif _option.Missions == Mission.SEAD then
      _A2GDispatcher:SetSquadronSead( _squadronName, _option.AttackSpeed[1], _option.AttackSpeed[2], _option.AttackAltitude[1], _option.AttackAltitude[2])
    else 
--      _A2GDispatcher:SetSquadronCas( _squadronName, _option.AttackSpeed[1], _option.AttackSpeed[2], _option.AttackAltitude[1], _option.AttackAltitude[2])
    end
--  end
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

local flatdb = require 'flatdb'

MDSDatabase = {
  templates = {}
}

function MDSDatabase:New() 
  local self = BASE:Inherit( self, BASE:New() )
  local dbDirectory = lfs.writedir() .. [[databases]]
  self.db = flatdb(dbDirectory) 
  return self
end

function MDSDatabase:GetTemplates() 
  return self.db.templates.Factions
end

function MDSDatabase:SetTemplates(_templates) 
  if self.db.templates == nil then self.db.templates = {} end
  self.db.templates.Factions = _templates
  return self
end

function MDSDatabase:save() 

  self.db:save()
  
end
--Based on Configuration.lua and pre-generated Database
AIA2GProvider = {
  ClassName = "AIA2GProvider"
}


function AIA2GProvider:Init() 
  local dispatchers = Configuration.Dispatchers
  
  for coalitionId, coalition in pairs(dispatchers) do
    for nationId, nation in pairs(coalition) do
      if nation.Active and nation.DispatcherType == Dispatcher.AG then  
        local prefix = coalitionId .. "_" .. nationId .. "_"
        local dispatcherOptions = AIA2GProvider:InitA2GDispatcherOptions(prefix,nation)
        
        local MissionsOptions = {} 
        for unitId, unit in pairs(nation.Units) do
          local option = AIA2GProvider:InitSquadronOption(coalitionId, nationId, unitId, unit)
          
          if option ~= nil then
            option:SetTakeoffMode(unit.TakeoffMode)
              :SetLandMode(unit.LandMode)
              :SetTakeoffIntervall(unit.TakeoffIntervall)
              
            table.insert(MissionsOptions, option)
          end
        end
        
        local A2GDispatcherInitializator = A2GDispatcherInitializator:New(dispatcherOptions)
          :SetSquadronsOptions(MissionsOptions)
          :Init()
      end
    end
  end
  
  
end

function AIA2GProvider:InitA2GDispatcherOptions(prefix, dispatcher)
  local _result = A2GDispatcherOptions:New()
            :SetCommandCenter(prefix .. dispatcher.CommandCenter)
            :SetDetectionArea(dispatcher.DetectionArea)
            :SetDefenseRadious(dispatcher.DefenseRadious)
            :SetReactivity(dispatcher.Reactivity)
            :SetTacticalDisplay(dispatcher.TacticalDisplay)
  for i, group in ipairs(dispatcher.DetectionGroups) do
    _result:SetDetectionGroups(prefix .. group.Name, group.isPrefix)
  end
  for i, group in ipairs(dispatcher.DefenceCoordinates) do
    _result:SetDefenceCoordinates(prefix .. group.Name, group.isPrefix)
  end
  return _result
end

function AIA2GProvider:InitSquadronOption(coalition, faction, unitId, unit)
  --recupero i template in base all'unita ed alla missione
  local template = MDSDatabase:New():GetTemplates()[coalition].Factions[faction].Units[unitId]
    
  if template ~= nil and Configuration.Settings.Era >= tonumber(template.Era[1]) and Configuration.Settings.Era <= tonumber(template.Era[2]) then   
  for missionId, mission in pairs(unit.Missions) do
    if mission.Active then
     
      local option =  SquadronsOptions:New()
              :SetAttackAltitude(mission.AttackAltitude)
              :SetAttackSpeed(mission.AttackSpeed)
              :SetOverhead(mission.Overhead)
              :SetAirbaseResourceMode(mission.AirbaseResourceMode)
              :SetMissions(missionId)
              :SetResourceCount(mission.ResourceCount)
              :SetTemplates(template.Missions[missionId].Templates)
              
        for i, group in ipairs(unit.Airbases) do
          option:SetAirbases( coalition .. "_" .. faction .. "_" .. group.Name, group.isPrefix)
        end  
        
       
              
        return option
      end
    end
  end
  return nil
end

