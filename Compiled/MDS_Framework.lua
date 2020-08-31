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
  SEAD = "SEAD",
  GROUND = "GROUND",
  GCI = "GCI"
}

Dispatcher = {
  AG = "AG",
  AA = "AA",
  Task = "Task",
  Ground = "Ground",
  GCI = "GCI"
}

Categories = {
  AIRPLANE = 0,
  HELICOPTER = 1,
  GROUND = 2,
  SHIP = 3,
  TRAIN = 4,
}


Configuration = {
    Settings = {
    Coalition = "Blue",
    Nation = "USA",
    Era = 2000,
    TakeoffMode = TakeoffMode.Runway,
    LandMode = LandMode.Runway,
    DatabasePath = "C:\\Users\\danie\\Saved Games\\DCS.openbeta\\databases",
    Dependecies = {
      Moose = "E:\\Projects\\GitHub\\MOOSE\\Compiled\\Moose.lua"
    },
    Flags = {
      TacticalDiplay = false, 
      Dispatchers = {
        ["BLUE"] = true,
        ["BLUE_USA"] = true,
        ["BLUE_USA_AG"] = true,
        ["BLUE_USA_AG_A10_" .. Mission.BAI] = true,
        ["BLUE_USA_AG_AH-64D_" .. Mission.BAI] = true,
        ["BLUE_USA_AG_FA-18C_" .. Mission.SEAD] = true,
        
        ["BLUE_USA_AA"] = true,
        ["BLUE_USA_AA_F-16CM_" .. Mission.CAP] = true,
        ["BLUE_USA_AA_F-14B_" .. Mission.CAP] = true,
        
        ["RED"] = true,
        ["RED_RUSSIA"] = true,
        ["RED_RUSSIA_AA"] = true,
        ["RED_RUSSIA_AA_Su-27_" .. Mission.CAP] = true,
        ["RED_RUSSIA_AA_MiG-31_" .. Mission.CAP] = true,
        ["RED_RUSSIA_AA_JF-17_" .. Mission.CAP] = true
      }
    }
  }
}

Configuration.Dispatchers = {
    ["BLUE"] = {
    ["USA"] = {
     [1] = {
        CommandCenter = "HQ",
        DetectionArea = 10000,
        DefenseRadious = 80000,
        Reactivity = Reactivity.High,
        TacticalDisplay = Configuration.Settings.Flags.TacticalDiplay,
        DispatcherType = Dispatcher.AG,
        TakeoffMode = Configuration.Settings.TakeoffMode,
        TakeoffInterval = 20,
        LandMode = Configuration.Settings.LandMode, 
        DetectionGroups = { 
          { Name = "Detection", isPrefix = true }
        },
        DefenceCoordinates = {
          { Name = "Defence", isPrefix = true }
        },
        Units = {
          ["A10"] = {
            Airbases = { 
              { Name = "Airbase_BAI", isPrefix = true }  
            },
            Missions = {
              [Mission.BAI] = {
                AttackAltitude = { 2000 , 3000 },
                AttackSpeed = { 360, 450 },
                Overhead = 0.10,
                AirbaseResourceMode = AirbaseResourceMode.RandomAirbase,
                ResourceCount = 4,
              }
            }
          },
          ["AH-64D"] = {
            Airbases = { 
              { Name = "Airbase_BAI_Heli", isPrefix = true }  
            },
            Missions = {
              [Mission.BAI] = {
                AttackAltitude = { 2000 , 3000 },
                AttackSpeed = { 360, 450 },
                Overhead = 0.25,
                AirbaseResourceMode = AirbaseResourceMode.RandomAirbase,
                ResourceCount = 4,
              }
            }
          },
          ["FA-18C"] = {
            Airbases = { 
              { Name = "Airbase_CAP_SEAD", isPrefix = true }  
            },
            Missions = {
              [Mission.SEAD] = {
                AttackAltitude = { 20000 , 25000 },
                AttackSpeed = { 360, 1950 },
                Overhead = 0.25,
                AirbaseResourceMode = AirbaseResourceMode.EveryAirbase,
                ResourceCount = 4,
              }
            }
          }
        }
      },
      [2] = {
        DispatcherType = Dispatcher.AA,
        DetectionGroups = {{ Name = "EWR", isPrefix = true }},
        CAPZones = {{ Name = "CAP", isPrefix = true }}, 
        --SimultaneousMaxCAP = 2,
        TakeoffMode = Configuration.Settings.TakeoffMode,
        TakeoffInterval = 20,
        LandMode = Configuration.Settings.LandMode, 
        --EnemyGroupingRadiuos = 6000,
        EngageRadius = 190000,
        InterceptDelay = 450,
        --GciRadious = 10
        TacticalDisplay = Configuration.Settings.Flags.TacticalDiplay,
        Units = { 
          ["F-16CM"] = {
            Airbases = { 
              { Name = "Airbase_CAP_SEAD", isPrefix = true }  
            },
            Missions = {
              [Mission.CAP] = {
                AttackAltitude = { 15000 , 25000 },
                AttackSpeed = { 450, 1200 },
                Overhead = 0.5,
                AirbaseResourceMode = AirbaseResourceMode.RandomAirbase,
                ResourceCount = 8,
                CapLimit = 2,
                CapGroupCount = 4,
                LowInterval = 10,
                HighInterval = 30,
                Probability = 1,
                FuelThreshold = 0.25,
              }
            }
          }, 
          ["F-14B"] = {
            Airbases = { 
              { Name = "Airbase_CAP_SEAD", isPrefix = true }  
            },
            Missions = {
              [Mission.CAP] = {
                AttackAltitude = { 15000 , 25000 },
                AttackSpeed = { 450, 2520 },
                Overhead = 0.5,
                AirbaseResourceMode = AirbaseResourceMode.RandomAirbase,
                ResourceCount = 3,
                CapLimit = 2,
                CapGroupCount = 4,
                LowInterval = 10,
                HighInterval = 30,
                Probability = 1,
                FuelThreshold = 0.25,
              }
            }
          }, 
          ["F-15C"] = {
            Airbases = { 
              { Name = "Airbase_CAP_SEAD", isPrefix = true }  
            },
            Missions = {
              [Mission.GCI] = {
                AttackAltitude = { 15000 , 25000 },
                AttackSpeed = { 450, 2650 },
                Overhead = 0.5,
                AirbaseResourceMode = AirbaseResourceMode.RandomAirbase,
                ResourceCount = 4,
                CapLimit = 2,
                CapGroupCount = 4,
                LowInterval = 10,
                HighInterval = 30,
                Probability = 1,
                FuelThreshold = 0.25,
              }
            }
          }
        }
      }
    }
  },
  ["RED"] = {
    ["RUSSIA"] = {
      [1] = {
        DispatcherType = Dispatcher.AA,
        DetectionGroups = {{ Name = "EWR", isPrefix = true }},
        CAPZones = {{ Name = "CAP", isPrefix = true }}, 
        --SimultaneousMaxCAP = 2,
        TakeoffMode = Configuration.Settings.TakeoffMode,
        TakeoffInterval = 20,
        LandMode = Configuration.Settings.LandMode, 
        --EnemyGroupingRadiuos = 6000,
        EngageRadius = 180000,
        InterceptDelay = 450,
        --GciRadious = 10
        TacticalDisplay = Configuration.Settings.Flags.TacticalDiplay,
        Units = { 
          ["Su-27"] = {
            Airbases = { 
              { Name = "Airbase_CAP", isPrefix = true }  
            },
            Missions = {
              [Mission.CAP] = {
                AttackAltitude = { 15000 , 25000 },
                AttackSpeed = { 450, 2500 },
                Overhead = 0.25,
                AirbaseResourceMode = AirbaseResourceMode.RandomAirbase,
                ResourceCount = 8,
                CapLimit = 2,
                CapGroupCount = 2,
                LowInterval = 10,
                HighInterval = 30,
                Probability = 1,
                FuelThreshold = 0.25,
              }
            }
          },
          ["MiG-31"] = {
            Airbases = { 
              { Name = "Airbase_CAP", isPrefix = true }  
            },
            Missions = {
              [Mission.CAP] = {
                AttackAltitude = { 15000 , 25000 },
                AttackSpeed = { 450, 1200 },
                Overhead = 0.25,
                AirbaseResourceMode = AirbaseResourceMode.RandomAirbase,
                ResourceCount = 6,
                CapLimit = 2,
                CapGroupCount = 2,
                LowInterval = 10,
                HighInterval = 30,
                Probability = 1,
                FuelThreshold = 0.25,
              }
            }
          },
          ["JF-17"] = {
            Airbases = { 
              { Name = "Airbase_CAP", isPrefix = true }  
            },
            Missions = {
              [Mission.CAP] = {
                AttackAltitude = { 15000 , 25000 },
                AttackSpeed = { 450, 3000 },
                Overhead = 0.25,
                AirbaseResourceMode = AirbaseResourceMode.RandomAirbase,
                ResourceCount = 2,
                CapLimit = 2,
                CapGroupCount = 2,
                LowInterval = 10,
                HighInterval = 30,
                Probability = 1,
                FuelThreshold = 0.25,
              }
            }
          }
        }
      }
    }
  }
}

UtilitiesService = {
	ClassName = "UtilitiesService"
}

function UtilitiesService:ArrayHasValue (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function UtilitiesService:GetEnumKeyByValue(_enum, _id) 
  for k,v in pairs(_enum) do
    if k == _id then return v end 
  end
  return nil
end

function UtilitiesService:GetRandomOfUnsequncialTable(_table)
  local _random = math.random(1, UtilitiesService:Lenght(_table))
  local _count = 1
  
  for i,row in pairs(_table) do
    if _count == _random then
      return row
    else
      _count = _count + 1
    end
  end
  return nil
end

function UtilitiesService:Lenght(_table)
  local count = 0
  for k,v in pairs(_table) do
    count = count + 1
  end    
  return count
end

function UtilitiesService:LoadDependecies() 
  for k,v in pairs(Configuration.Settings.Dependecies) do
    assert(loadfile(v))()
  end
end



--UtilitiesService:LoadDependecies()



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

A2ADispatcherOptions = {
  ClassName = "A2ADispatcherOptions",
  __index = A2ADispatcherOptions,
  EngageRadius = nil,
  InterceptDelay = nil,
  TacticalDisplay = true,
  DetectionGroups = {},
  CAPZones = {},
  AssignedCAPS = {}
}

function A2ADispatcherOptions:New()
  local self = BASE:Inherit( self, BASE:New() )
  return self
end

--function A2ADispatcherOptions:SetCommandCenter(_commandCenterName)
--  self.CommandCenter = GROUP:FindByName(_commandCenterName)
--  return self
--end

--function A2ADispatcherOptions:SetDetectionArea(_DetectionArea)  
--  self.DetectionArea = _DetectionArea
--  return self
--end

function A2ADispatcherOptions:SetEngageRadius(_EngageRadius)  
  self.EngageRadius = _EngageRadius
  return self
end

--function A2ADispatcherOptions:SetReactivity(_reactivity)
--  self.Reactivity = _reactivity
--  return self
--end

function A2ADispatcherOptions:SetTacticalDisplay(_tacticalDisplay)
  self.TacticalDisplay = _tacticalDisplay
  return self
end

function A2ADispatcherOptions:SetInterceptDelay(_InterceptDelay)
  self.InterceptDelay = _InterceptDelay
  return self
end

function A2ADispatcherOptions:SetDetectionGroups(_Groups, _arePrefix)
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

function A2ADispatcherOptions:SetCAPZones(_Groups, _arePrefix)
  if _arePrefix then
    self.CAPZones = SET_GROUP:New()
      :FilterPrefixes(_Groups)
      :FilterStart()
      .Set
  else
    local foundedGroups = {}
    for id, group in ipairs(_Groups) do
      foundedGroups[_Groups] = GROUP:FindByName(_Groups)
    end
    self.DefenceCoordinates = foundedGroups
  end 
  return self
end

function A2ADispatcherOptions:GetAvailableCap()
  local foundCap = nil
    
  for i,capZone in pairs(self.CAPZones) do
    if self.AssignedCAPS[capZone.GroupName] == nil then
      self.AssignedCAPS[capZone.GroupName] = true
      foundCap = capZone
      break
    end
  end
  return foundCap
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
  Missions = { Mission.CAP },
  CapLimit = 2,
  LowInterval = 30,
  HighInterval = 600,
  Probability = 1,
  FuelThreshold = 2.5
}

function SquadronsOptions:New()
  local self = BASE:Inherit( self, BASE:New() )
  return self
end

function SquadronsOptions:SetAttackAltitude(_AttackAltitude)
  self.AttackAltitude = _AttackAltitude
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
  self.TakeoffMode = _Takeoff
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

function SquadronsOptions:SetCapLimit(_CapLimit)
  self.CapLimit = _CapLimit
  return self
end

function SquadronsOptions:SetLowInterval(_LowInterval)
  self.LowInterval = _LowInterval
  return self
end

function SquadronsOptions:SetHighInterval(_HighInterval)
  self.HighInterval = _HighInterval
  return self
end

function SquadronsOptions:SetProbability(_Probability)
  self.Probability = _Probability
  return self
end

function SquadronsOptions:SetFuelThreshold(_FuelThreshold)
  self.FuelThreshold = _FuelThreshold
  return self
end

function SquadronsOptions:SetGroups(_Groups, _arePrefix)
  self.Groups = _Groups
  return self
end

function SquadronsOptions:SetTemplates(_templates)
  self.Groups = TemplateManager:New()
    :InitLazyGroupsByTemplates(_templates)
    :GetLazyGroupsNames()
  return self

--  for id, _template in pairs(_templates) do
--    local group = GROUP:NewTemplate(_template.Group, _template.Group.CoalitionID, _template.Group.CategoryID, _template.Group.CountryID)
--    
--    local _templateGroup = SPAWN:New(_template.Group.name)
--      :InitLateActivated(true)
--      :_Prepare( _template.Group.name, math.random(1,10000) )
--      
--    local _templateGroup = SPAWN:NewFromTemplate(_templateGroup, _template.Group.name, _template.Group.name)
--      :InitLateActivated(true)
--      :SpawnFromVec2({x=0,y=0})
--      _DATABASE.GROUPS[_template.Group.name] = nil
--      _DATABASE.Templates.Groups[_template.Group.name] = nil
--    -- = group
--    table.insert(self.Groups, _templateGroup.GroupName)
--  end
--  return self;
end

function SquadronsOptions:SetAirbases(_Airbases, _arePrefix)
  local foundedGroups = {}
  if _arePrefix then
    local groups = ZonesManagerService:GetZonesByPrefix(_Airbases)
      
    for i, group in pairs(groups) do
    local airbaseFound = nil;
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
  return self.Airbases[math.random(1,UtilitiesService:Lenght(self.Airbases))]
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
          local SquadronName = airbase.AirbaseName .."_" .. count
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
      local SquadronName = airbaseName .."_" .. count
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


A2ADispatcherInitializator = {
  ClassName = "A2ADispatcherInitializator",
  DispatcherOptions = nil,
  Options = nil,
  AssignedCap = {}
}

function A2ADispatcherInitializator:New(_options) 
  self.DispatcherOptions = _options
  return self
end

function A2ADispatcherInitializator:SetSquadronsOptions(_options)
  self.Options = _options
  return self
end

function A2ADispatcherInitializator:Init() 

  local Detection = DETECTION_AREAS:New( self.DispatcherOptions.DetectionGroups, self.DispatcherOptions.EngageRadius )
  local A2ADispatcher = AI_A2A_DISPATCHER:New( Detection )
  
  if self.DispatcherOptions.InterceptDelay ~= nil then
    A2ADispatcher:SetIntercept(self.DispatcherOptions.InterceptDelay)
  end
  
  if self.DispatcherOptions.EngageRadius ~= nil then
    A2ADispatcher:SetEngageRadius(self.DispatcherOptions.EngageRadius)
  end
  
--  for id, defencePoint in pairs(self.DispatcherOptions.DefenceCoordinates) do
--    A2ADispatcher:AddDefenseCoordinate( defencePoint.ZoneName, defencePoint:GetPointVec2() )
--  end
  
--  if  self.DispatcherOptions.Reactivity == Reactivity.High then
--    A2ADispatcher:SetDefenseReactivityHigh()
--  elseif self.DispatcherOptions.Reactivity == Reactivity.Medium then
--    A2ADispatcher:SetDefenseReactivityMedium()
--  elseif self.DispatcherOptions.Reactivity == Reactivity.Low then
--    A2ADispatcher:SetDefenseReactivityLow()
--  else 
--    A2ADispatcher:SetDefenseReactivityMedium() 
--  end
  
--  A2ADispatcher:SetDefenseRadius( self.DispatcherOptions.DefenseRadious )
--  A2ADispatcher:SetCommandCenter( self.DispatcherOptions.CommandCenter )
  A2ADispatcher:SetTacticalDisplay( self.DispatcherOptions.TacticalDisplay )
  self:SetSquadrons(A2ADispatcher)
  return self
  
end

function A2ADispatcherInitializator:SetSquadrons(_A2ADispatcher)
  local count = 1
  for i,option in ipairs(self.Options) do
    if option.AirbaseResourceMode == AirbaseResourceMode.EveryAirbase then
        for i,airbase in ipairs(option.Airbases) do
          local SquadronName = airbase.AirbaseName .. "_" .. count
          local availableCap = self.DispatcherOptions:GetAvailableCap()
          if availableCap then
            _A2ADispatcher:SetSquadron( SquadronName, airbase.AirbaseName, option.Groups, option.ResourceCount )
            self:SetSquadronMission(SquadronName, availableCap, option, _A2ADispatcher)
            self:SetSquadronTakeoff(SquadronName, option, _A2ADispatcher)
            self:SetSquadronLand(SquadronName, option, _A2ADispatcher)
            _A2ADispatcher:SetSquadronOverhead( SquadronName, option.OverHead )
            _A2ADispatcher:SetSquadronTakeoffInterval( SquadronName, option.TakeoffIntervall )
            count = count + 1
          end
        end
    else
      local airbaseName = option:GetRandomAirbase().AirbaseName
      local SquadronName = airbaseName .. "_" .. count
      local availableCap = self.DispatcherOptions:GetAvailableCap()
      if availableCap then
        _A2ADispatcher:SetSquadron( SquadronName, airbaseName, option.Groups, option.ResourceCount )
        self:SetSquadronMission(SquadronName, availableCap, option, _A2ADispatcher)
        self:SetSquadronTakeoff(SquadronName, option, _A2ADispatcher)
        self:SetSquadronLand(SquadronName, option, _A2ADispatcher)
        _A2ADispatcher:SetSquadronOverhead( SquadronName, option.OverHead )
--       _A2ADispatcher:SetSquadronTakeoffInterval( SquadronName, option.TakeoffIntervall )
        count = count + 1
      end
    end
  end 
end

function A2ADispatcherInitializator:SetSquadronMission(_squadronName, _CAPZone, _option, _A2ADispatcher)
--  for i , mission in ipairs(_option.Missions) do
    if _option.Missions == Mission.CAP then
      local CAPZone = ZONE_POLYGON:New( "CAP" .. _squadronName, _CAPZone)
      _A2ADispatcher:SetSquadronCap( _squadronName, CAPZone, _option.AttackAltitude[1], _option.AttackAltitude[2], _option.AttackSpeed[1], _option.AttackSpeed[2])
      _A2ADispatcher:SetSquadronCapInterval(_squadronName, _option.CapLimit, _option.LowInterval, _option.HighInterval, _option.Probability)
      _A2ADispatcher:SetSquadronGrouping( _squadronName, _option.CapGroupCount )
--      _A2ADispatcher:SetSquadronGci( _squadronName, _option.AttackSpeed[1], _option.AttackSpeed[2])
      _A2ADispatcher:SetSquadronFuelThreshold(_squadronName, _option.FuelThreshold)
    elseif _option.Missions == Mission.Gci then
      _A2ADispatcher:SetSquadronGci( _squadronName, _option.AttackSpeed[1], _option.AttackSpeed[2])--, _option.AttackAltitude[1], _option.AttackAltitude[2])
    elseif _option.Missions == Mission.SEAD then
      _A2ADispatcher:SetSquadronSead( _squadronName, _option.AttackSpeed[1], _option.AttackSpeed[2], _option.AttackAltitude[1], _option.AttackAltitude[2])
    else 
--      _A2ADispatcher:SetSquadronCas( _squadronName, _option.AttackSpeed[1], _option.AttackSpeed[2], _option.AttackAltitude[1], _option.AttackAltitude[2])
    end
--  end
end

function A2ADispatcherInitializator:SetSquadronTakeoff(_squadronName, _option, _A2ADispatcher)
  if _option.TakeoffMode == TakeoffMode.Air then
    _A2ADispatcher:SetDefaultTakeoffInAir(_squadronName)
  elseif _option.TakeoffMode == TakeoffMode.Cold then
    _A2ADispatcher:SetDefaultTakeoffFromParkingCold(_squadronName)
  elseif _option.TakeoffMode == TakeoffMode.Hot then
    _A2ADispatcher:SetDefaultTakeoffFromParkingHot(_squadronName)
  elseif _option.TakeoffMode == TakeoffMode.Runway then
    _A2ADispatcher:SetDefaultTakeoffFromRunway(_squadronName) 
  else
    _A2ADispatcher:SetDefaultTakeoffFromParkingCold(_squadronName)
  end
end


function A2ADispatcherInitializator:SetSquadronLand(_squadronName, _option, _A2ADispatcher)
  if _option.LandMode == LandMode.NearAirbase then
    _A2ADispatcher:SetSquadronLandingNearAirbase(_squadronName)
  elseif _option.LandMode == LandMode.Runway then
    _A2ADispatcher:SetSquadronLandingAtRunway(_squadronName)
  elseif _option.LandMode == LandMode.Shutdown then
    _A2ADispatcher:SetSquadronLandingAtEngineShutdown(_squadronName)
  else 
    _A2ADispatcher:SetSquadronLandingAtEngineShutdown(_squadronName)
  end
end

ZonesManagerService = {
  ClassName = "ZonesManagerService",
}

function ZonesManagerService:New()
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
  
  return zones[math.random(0, UtilitiesService:Lenght(zones))]
end

function ZonesManagerService:GetRandomZoneByPrefix(_prefix)
  env.info("GetRandomZoneByPrefix")
  local set_zone = self:GetSetZonesByPrefix(_prefix)
  
  --local random = math.random(1, table.getn(set_zone) - 1)
  local count = 0
  for k,v in pairs(set_zone.Set) do
    count = count + 1
  end
  local random = math.random(1, UtilitiesService:Lenght(set_zone.Set))
  
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





ConvoyService = {
  ClassName = "ConvoyService",
  Configuration = Configuration.Settings,
  SendMessageOnSpawn = false,
  Message = "Enemy convoy at $cordinates moving to $compassDirection Heading ($heading)",
  StartZones = {},
  EndZones = {},
  Groups = {},
  GroupType = nil,
  Faction = nil,
  MenuCoalition = nil,
  ConvoyCoalition = nil,
  Type = nil,
  SpawnOnMenuAction = false,
  Menu = "Convoy",
  Command = "Spawn Convoy",
  MenuCoalitionObject = nil,
  MenuIntelObject = nil,
  MenuConvoyObject = nil,
  UnitNumber = 3,
  RequestableIntel = true
}

function ConvoyService:New()
  self = ConvoyService
  return self
end

function ConvoyService:SetGroup(_group) 
  self.Groups  = { GROUP:FindByName(_group).GroupName }
  return self
end

function ConvoyService:SetGroupType(_type)
  self.GroupType = _type
  return self
end

function ConvoyService:SetFaction(_faction) 
  self.Faction = _faction
  return self
end

function ConvoyService:SetCoalition(_coalition) 
  self.Coalition = _coalition
  return self
end

function ConvoyService:SetCategory(_category) 
  self.Category = _category
  return self
end

function ConvoyService:SetUnitNumber(_unitNumber)
  self.UnitNumber = _unitNumber
  return self
end

function ConvoyService:SetStartZones(_startZones, _isPrefix)
  self.StartZones = { Zones = _startZones, isPrefix = _isPrefix } 
  return self
end

function ConvoyService:SetEndZones(_endZones, _isPrefix) 
  self.EndZones = { Zones = _endZones, isPrefix = _isPrefix } 
  
  return self
end

function ConvoyService:SetMessageOnSpawn(_message)
  self.SendMessageOnSpawn = true
  if _message ~= nil then self.Message = _message end
  return self
end

function ConvoyService:SetRequestableIntel(_in)
  self.RequestableIntel = _in
  return self
end

function ConvoyService:AssignTask()
  self.AssignTask = true
  return self
end

function ConvoyService:InitGroupByFilters()
  if table.getn(self.Groups) ~= 0 then return self.Groups  end
  self.Groups = TemplateManager:New()
    --:InitLazyGroupsByFilters(self.Coalition, self.Faction, self.Category, Mission.GROUND, self.GroupType)
    :InitLazyConovyGroupByFilters(self.UnitNumber, self.Coalition, self.Faction, self.Category, Mission.GROUND, self.GroupType)
    :GetLazyGroupsNames()
end

function ConvoyService:SetMenuAction(_menu, _command, _coalition)
  self.SpawnOnMenuAction = true
  self.Command = _command 
  self.MenuCoalition = _coalition 
  self.MenuCoalitionObject =  MENU_COALITION:New(_coalition, _menu)
  
  return self
end

function ConvoyService:GetRandomizedSpawn()
  self:InitGroupByFilters()
  local SpawnConvoy = self:GetSpawnObject()
  return SpawnConvoy
end

function ConvoyService:Spawn()
  
  if self.SpawnOnMenuAction then
    MENU_COALITION_COMMAND:New(self.MenuCoalition, self.Command, self.MenuCoalitionObject, 
      function () 
        self.Groups = {}
        self:InitGroupByFilters()
        local SpawnConvoy = self:GetSpawnObject()
        SpawnConvoy:Spawn() 
      end
    )
  else
  self:InitGroupByFilters()
  local SpawnConvoy = self:GetSpawnObject()
  SpawnConvoy:Spawn() 
  end
end 

function ConvoyService:GetSpawnObject()
  local GroundOrgZones = {}
  local startZones = {}
  local endZone = {}
  
  if self.StartZones.isPrefix then
    startZones = ZonesManagerService:GetZonesByPrefix(self.StartZones.Zones)
  else
    for zoneId, zone in pairs(self.StartZones) do
      table.insert(startZones, zone)
    end
  end
  
  if self.EndZones.isPrefix then
    endZone = ZonesManagerService:GetRandomZoneByPrefix(self.EndZones.Zones)
  else
    local randomZone = self.EndZones.Zones[math.random(1, UtilitiesService:Lenght(self.EndZones.Zones))]
    endZone = ZONE:New(self.EndZones.Zones)
  end
  
  for zoneId, zone in pairs(startZones) do
     table.insert(GroundOrgZones, zone)
  end
  
  local unitSpawn = SPAWN:New( self.Groups[1] )
    :InitLimit(self.UnitNumber,1)
    --:InitGrouping(self.UnitNumber)
  
  if table.getn(self.Groups) > 1 then
    unitSpawn:InitRandomizeTemplate(self.Groups)
  end
  
  unitSpawn
    :InitRandomizeRoute( 1, 1, 200 ) 
    :InitRandomizePosition(500, 50)
    :InitRandomizeUnits(true,500,50)
    :InitRandomizeZones( GroundOrgZones )
    :OnSpawnGroup(
      function(SpawnGroup)
        env.info("Convoy " .. SpawnGroup.GroupName .. " Spawned")
        SpawnGroup:TaskRouteToZone(endZone,true,150,"On Road")
        
        if self.SendMessageOnSpawn then
          
          self:SendIntelMessage(SpawnGroup, endZone)
          
          if self.SpawnOnMenuAction then
          
            self.MenuConvoyObject =  MENU_COALITION:New(self.MenuCoalition, SpawnGroup.GroupName, self.MenuCoalitionObject)
             SpawnGroup:HandleEvent(EVENTS.Dead, function ()
                if table.getn(SpawnGroup:GetUnits()) == 1 then
                  self:RemoveMenu(SpawnGroup.GroupName)
                end 
              end
              )
            
            if self.RequestableIntel then
              MENU_COALITION_COMMAND:New(self.MenuCoalition, "Intel",self.MenuConvoyObject, function() self:SendIntelMessage(SpawnGroup, endZone) end)
            end
            
            MENU_COALITION_COMMAND:New(self.MenuCoalition, "Delete convoy", self.MenuConvoyObject, 
              function(removeMenu)
                SpawnGroup:Destroy(true)
                env.info("Convoy " .. SpawnGroup.GroupName .. " Removed")
              end
            )
          end
        end
      end
  )
  return unitSpawn
end

function ConvoyService:SendIntelMessage(_SpawnGroup, _endZone)
  local message = "" 
  local vec2Start = _SpawnGroup:GetPointVec2()
  local direction = _SpawnGroup:GetPointVec3():GetDirectionVec3(_endZone:GetCoordinate())
  local azimuth = _SpawnGroup:GetPointVec3():GetAngleDegrees(direction)
  local compass_brackets = {"N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"}
  local compass_lookup = math.floor(azimuth / 45) + 1
  local compass_direction = compass_brackets[compass_lookup]
  if compass_direction == nil then compass_direction = "" end
  azimuth = math.floor(azimuth)
  if string.len(azimuth) == 2 then azimuth = "0" .. azimuth end
  if string.len(azimuth) == 1 then azimuth = "00" .. azimuth end
  
  --local message = "Enemy convoy at " .. vec2Start:ToStringLLDDM(nil) .. " moving to " .. compass_direction .. " Heading (" .. azimuth .. ")"
  
  message = self.Message:gsub( "$cordinates", vec2Start:ToStringLLDDM(nil) )
  message = self.Message:gsub( "$compassDirection", compass_direction )
  message = self.Message:gsub( "$heading", azimuth )
  message = self.Message
  local aaAlert = false;
  for i,u in pairs(_SpawnGroup:GetUnits()) do
    if u:GetDCSObject():getAttributes()["Air Defence"] ~= nil then
      aaAlert = true
    end
  end
        
  if aaAlert then
    message = message .. " - Possible anti-aircraft threat in the area"
  end
  
  MESSAGE:New(message, 10):ToCoalition(self.MenuCoalition)
end

function ConvoyService:RemoveMenu(_menuId) 
  local masterObject = SCHEDULER:New(self.MenuCoalitionObject:GetMenu(_menuId))
  masterObject:Schedule(nil,
    function (commandMenu) 
      commandMenu:Remove()
      env.info("Remove command deleted")
    end
  , {self.MenuCoalitionObject:GetMenu(_menuId)}, .5)
end

TemplateManager = {
  ClassName = "TemplateManager",
  LazyGroups = {},
  InitializedGroups = {}
}

function TemplateManager:New()
  self.db = MDSDatabase:New()
  self.LazyGroups = {}
  return self
end

function TemplateManager:GetLazyGroups()
  return self.LazyGroups
end

function TemplateManager:GetLazyGroupsNames()
  local _result = {}
  for i,g in pairs(self.LazyGroups) do
    table.insert(_result, g.GroupName)
  end
  return _result
end

function TemplateManager:InitLazyGroupsByFilters(_coalition, _faction, _category, _mission, _unitType)
  --local _templates = self.db:GetTemplatesBy(_coalition, _faction, _category, _mission, _unitType)
  local _templates = self.db:FilterCoalition(_coalition)
    :FilterFactions({ _faction })
    :FilterCategories({ _category })
    :FilterMissions({ _mission })
    :FilterUnitTypes({ _unitType })
    :FilterStart()
    :GetFilterResult()
    
  self:InitLazyGroupsByTemplates(_templates)
  return self
end

function TemplateManager:InitLazyConovyGroupByFilters(_unitNumber, _coalition, _faction, _category, _mission, _unitType)
  --local _templates = self.db:GetTemplatesBy(_coalition, _faction, _category, _mission, _unitType)
  local _templates = self.db:FilterCoalition(_coalition)
    :FilterFactions({ _faction })
    :FilterCategories({ _category })
    :FilterMissions({ _mission })
    :FilterUnitTypes({ _unitType })
    :FilterStart()
    :GetFilterResult()
  
  local convoy = routines.utils.deepCopy(UtilitiesService:GetRandomOfUnsequncialTable(_templates))
  convoy.Group.name = convoy.Group.name .. "_Dynamic"
  for i = 2, _unitNumber do
    local _unit =  routines.utils.deepCopy(UtilitiesService:GetRandomOfUnsequncialTable(_templates))
--    local _unit = routines.utils.deepCopy(_templates[2])
    convoy.Group.units[i] = _unit.Group.units[1]
    convoy.Group.units[i].x = convoy.Group.units[1].x + math.random(1, 1000) + (i * 100)
    convoy.Group.units[i].y = convoy.Group.units[1].y + math.random(1, 1000) + (i * 100)
  end
  
  self:InitLazyGroupByTemplate(convoy.Group.name .. "_Dynamic",convoy)
  return self
end


function TemplateManager:InitLazyGroupByTemplate(id, _template)
  local initializedTemplate = self.InitializedGroups[i]
    if not initializedTemplate then
      local group = GROUP:NewTemplate(_template.Group, _template.Group.CoalitionID, _template.Group.CategoryID, _template.Group.CountryID)
        
      local _templateGroup = SPAWN:New(_template.Group.name)
        :InitLateActivated(true)
        :_Prepare( _template.Group.name, math.random(1,10000) )
        
      local _templateGroup = SPAWN:NewFromTemplate(_templateGroup, _template.Group.name, _template.Group.name)
        :InitLateActivated(true)
        :SpawnFromVec2({x=0,y=0})
        
      _DATABASE.GROUPS[_template.Group.name] = nil
      _DATABASE.Templates.Groups[_template.Group.name] = nil
      
      table.insert(self.LazyGroups, _templateGroup)
      self.InitializedGroups[id] = _templateGroup
    else    
      table.insert(self.LazyGroups, initializedTemplate)
    end
  return self
end

function TemplateManager:InitLazyGroupsByTemplates(_templates)
  local _result = {}
  for i,t in pairs(_templates) do
    local initializedTemplate = self.InitializedGroups[i]
    if not initializedTemplate then
      local group = GROUP:NewTemplate(t.Group, t.Group.CoalitionID, t.Group.CategoryID, t.Group.CountryID)
        
      local _templateGroup = SPAWN:New(t.Group.name)
        :InitLateActivated(true)
        :_Prepare( t.Group.name, math.random(1,10000) )
        
      local _templateGroup = SPAWN:NewFromTemplate(_templateGroup, t.Group.name, t.Group.name)
        :InitLateActivated(true)
        :SpawnFromVec2({x=0,y=0})
        
      _DATABASE.GROUPS[t.Group.name] = nil
      _DATABASE.Templates.Groups[t.Group.name] = nil
      
      table.insert(self.LazyGroups, _templateGroup)
      self.InitializedGroups[i] = _templateGroup
    else    
      table.insert(self.LazyGroups, initializedTemplate)
    end
  end
  return self
end


local flatdb = require 'flatdb'

MDSDatabase = {
  templates = {},
  Coalition = nil,
  Factions = {},
  Categories = {},
  Types = {},
  UnitNames = {},
  Missions = {},
  Era = nil,
  FilterResult = {}
}

function MDSDatabase:New() 
  local self = BASE:Inherit( self, BASE:New() )
  local dbDirectory = lfs.writedir() .. [[databases]]
  if Configuration.Settings.DatabasePath ~= nil and Configuration.Settings.DatabasePath ~= "" then
    dbDirectory = Configuration.Settings.DatabasePath
  end
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

function MDSDatabase:FilterCoalition(_in)
  self.Coalition = _in
  return self
end

function MDSDatabase:FilterFactions(_in)
  self.Factions = _in
  return self
end

function MDSDatabase:FilterCategories(_in)
  self.Categories = _in
  return self
end

function MDSDatabase:FilterUnitTypes(_in)
  self.Types = _in
  return self
end

function MDSDatabase:FilterUnitNames(_in)
  self.UnitNames = _in
  return self
end

function MDSDatabase:FilterMissions(_in)
  self.Missions = _in
  return self
end

function MDSDatabase:FilterEra(_in)
  self.Era = _in
  return self
end

function MDSDatabase:GetFilterResult()
  return self.FilterResult
end

function MDSDatabase:FilterStart()
  local templates = self:GetTemplates()
  local _result = {}
  for i,t in ipairs(templates) do  
    if      (self.Coalition == nil or self.Coalition == t.Coalition)
        and (table.getn(self.Factions) == 0 or UtilitiesService:ArrayHasValue(self.Factions, t.Faction))
        and (table.getn(self.Types) == 0 or UtilitiesService:ArrayHasValue(self.Types,t.VehicleType))
        and (table.getn(self.UnitNames) == 0 or UtilitiesService:ArrayHasValue(self.UnitNames,t.VehicleName))
        and (table.getn(self.Categories) == 0 or UtilitiesService:ArrayHasValue(self.Categories,t.Category))
        and (table.getn(self.Missions) == 0 or UtilitiesService:ArrayHasValue(self.Missions,t.Mission))
        and (self.Era == nil or (self.Era >= t.Era[1] and self.Era <= t.Era[2]))
        then
      _result[i] = t
    end
  end
  self.FilterResult = _result
  return self
end

function MDSDatabase:save() 

  self.db:save()
  
end
--Based on Configuration.lua and pre-generated Database
DispatchersProvider = {
  ClassName = "DispatchersProvider"
}


function DispatchersProvider:Init() 
  local dispatchers = Configuration.Dispatchers
  
  for coalitionId, coalition in pairs(dispatchers) do
    if Configuration.Settings.Flags.Dispatchers[coalitionId] then
      for nationId, nation in pairs(coalition) do
        if Configuration.Settings.Flags.Dispatchers[coalitionId .. "_" .. nationId] then
          for dispatcherId, dispatcher in ipairs(nation) do
            if Configuration.Settings.Flags.Dispatchers[coalitionId .. "_" .. nationId .. "_" .. dispatcher.DispatcherType] and dispatcher.DispatcherType == Dispatcher.AG then  
              local prefix = coalitionId .. "_" .. nationId .. "_"
              local dispatcherOptions = DispatchersProvider:InitA2GDispatcherOptions(prefix,dispatcher)
              
              local MissionsOptions = {} 
              for unitId, unit in pairs(dispatcher.Units) do
                local option = DispatchersProvider:InitAGSquadronOption(coalitionId, nationId, dispatcher.DispatcherType, unitId, unit)
                
                if option ~= nil then
                  option:SetTakeoffMode(dispatcher.TakeoffMode)
                    :SetLandMode(dispatcher.LandMode)
                    :SetTakeoffIntervall(dispatcher.TakeoffIntervall)
                    
                  table.insert(MissionsOptions, option)
                end
              end
              
              local A2GDispatcherInitializator = A2GDispatcherInitializator:New(dispatcherOptions)
                :SetSquadronsOptions(MissionsOptions)
                :Init()
            elseif Configuration.Settings.Flags.Dispatchers[coalitionId .. "_" .. nationId .. "_" .. dispatcher.DispatcherType] and dispatcher.DispatcherType == Dispatcher.AA then
              local prefix = coalitionId .. "_" .. nationId .. "_"
              local dispatcherOptions = DispatchersProvider:InitA2ADispatcherOptions(prefix,dispatcher)
              
              local MissionsOptions = {} 
              for unitId, unit in pairs(dispatcher.Units) do
                local option = DispatchersProvider:InitAASquadronOption(coalitionId, nationId, dispatcher.DispatcherType, unitId, unit)
                
                if option ~= nil then
                  option:SetTakeoffMode(dispatcher.TakeoffMode)
                    :SetLandMode(dispatcher.LandMode)
                    :SetTakeoffIntervall(dispatcher.TakeoffIntervall)
                    
                  table.insert(MissionsOptions, option)
                end
              end
              
              local A2ADispatcherInitializator = A2ADispatcherInitializator:New(dispatcherOptions)
                :SetSquadronsOptions(MissionsOptions)
                :Init()
            end
          end
        end
      end
    end
  end
  
  
end

function DispatchersProvider:InitA2GDispatcherOptions(prefix, dispatcher)
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


function DispatchersProvider:InitA2ADispatcherOptions(prefix, dispatcher)
  local _result = A2ADispatcherOptions:New()
            :SetEngageRadius(dispatcher.EngageRadius)
            :SetInterceptDelay(dispatcher.InterceptDelay)
            :SetTacticalDisplay(dispatcher.TacticalDisplay)
  for i, group in ipairs(dispatcher.DetectionGroups) do
    _result:SetDetectionGroups(prefix .. group.Name, group.isPrefix)
  end
  for i, group in ipairs(dispatcher.CAPZones) do
    _result:SetCAPZones(prefix .. group.Name, group.isPrefix)
  end
  return _result
end

function DispatchersProvider:InitAGSquadronOption(_coalition, faction,  _dispatcherType, unitId, unit)
  --recupero i template in base all'unita ed alla missione
--  local template = MDSDatabase:New():GetTemplates()[_coalition].Factions[faction].Units[unitId]

--  if template ~= nil and Configuration.Settings.Era >= tonumber(template.Era[1]) and Configuration.Settings.Era <= tonumber(template.Era[2]) then
    for missionId, mission in pairs(unit.Missions) do
      if  Configuration.Settings.Flags.Dispatchers[_coalition .. "_" .. faction .. "_" .. _dispatcherType .. "_" .. unitId .. "_" .. missionId]  then
        local templates = MDSDatabase:New()
          :FilterCoalition(UtilitiesService:GetEnumKeyByValue(coalition.side,_coalition))
          :FilterFactions({ country.name[faction] })
          :FilterUnitNames({ unitId })
          :FilterMissions({ missionId })
          :FilterEra(Configuration.Settings.Era)
          :FilterStart()
          :GetFilterResult()
        local option =  SquadronsOptions:New()
                :SetAttackAltitude(mission.AttackAltitude)
                :SetAttackSpeed(mission.AttackSpeed)
                :SetOverhead(mission.Overhead)
                :SetAirbaseResourceMode(mission.AirbaseResourceMode)
                :SetMissions(missionId)
                :SetResourceCount(mission.ResourceCount)
                :SetTemplates(templates)
                
          for i, group in ipairs(unit.Airbases) do
            option:SetAirbases( _coalition .. "_" .. faction .. "_" .. group.Name, group.isPrefix)
          end  
          
         
                
          return option
        end
      end
--    end
  return nil
end

function DispatchersProvider:InitAASquadronOption(_coalition, faction, _dispatcherType, unitId, unit)
  --recupero i template in base all'unita ed alla missione
--  local template = MDSDatabase:New():GetTemplates()[_coalition].Factions[faction].Units[unitId]
    
--  if template ~= nil and Configuration.Settings.Era >= tonumber(template.Era[1]) and Configuration.Settings.Era <= tonumber(template.Era[2]) then   
  for missionId, mission in pairs(unit.Missions) do
    if  Configuration.Settings.Flags.Dispatchers[_coalition .. "_" .. faction .. "_" .. _dispatcherType .. "_" .. unitId .. "_" .. missionId]  then
      local templates = MDSDatabase:New()
          :FilterCoalition(UtilitiesService:GetEnumKeyByValue(coalition.side,_coalition))
          :FilterFactions({ country.name[faction] })
          :FilterUnitNames({ unitId })
          :FilterMissions({ missionId })
          :FilterEra(Configuration.Settings.Era)
          :FilterStart()
          :GetFilterResult()
      local option =  SquadronsOptions:New()
              :SetAttackAltitude(mission.AttackAltitude)
              :SetAttackSpeed(mission.AttackSpeed)
              :SetOverhead(mission.Overhead)
              :SetAirbaseResourceMode(mission.AirbaseResourceMode)
              :SetMissions(missionId)
              :SetResourceCount(mission.ResourceCount)
              :SetTemplates(templates)
              :SetCapLimit(mission.CapLimit)
              :SetLowInterval(mission.LowInterval)
              :SetHighInterval(mission.HighInterval)
              :SetProbability(mission.Probability)
              :SetFuelThreshold(mission.FuelThreshold)
              
        for i, group in ipairs(unit.Airbases) do
          option:SetAirbases(  _coalition .. "_" .. faction .. "_" .. group.Name, group.isPrefix)
        end    
        return option
      end
    end
  --end
  return nil
end--- Will spawn a group with a specified index number.
-- Method overrided to chek coordinates assigned to previous units to prevent overlapping
-- Uses @{DATABASE} global object defined in MOOSE.
-- @param #SPAWN self
-- @param #string SpawnIndex The index of the group to be spawned.
-- @return Wrapper.Group#GROUP The group that was spawned. You can use this group for further actions.
function SPAWN:SpawnWithIndex( SpawnIndex, NoBirth )
  self:F2( { SpawnTemplatePrefix = self.SpawnTemplatePrefix, SpawnIndex = SpawnIndex, AliveUnits = self.AliveUnits, SpawnMaxGroups = self.SpawnMaxGroups } )
  
  if self:_GetSpawnIndex( SpawnIndex ) then
    
    if self.SpawnGroups[self.SpawnIndex].Visible then
      self.SpawnGroups[self.SpawnIndex].Group:Activate()
    else

      local SpawnTemplate = self.SpawnGroups[self.SpawnIndex].SpawnTemplate
      self:T( SpawnTemplate.name )

      if SpawnTemplate then

        local PointVec3 = POINT_VEC3:New( SpawnTemplate.route.points[1].x, SpawnTemplate.route.points[1].alt, SpawnTemplate.route.points[1].y )
        self:T( { "Current point of ", self.SpawnTemplatePrefix, PointVec3 } )

        -- If RandomizePosition, then Randomize the formation in the zone band, keeping the template.
        if self.SpawnRandomizePosition then
          local RandomVec2 = PointVec3:GetRandomVec2InRadius( self.SpawnRandomizePositionOuterRadius, self.SpawnRandomizePositionInnerRadius )
          local CurrentX = SpawnTemplate.units[1].x
          local CurrentY = SpawnTemplate.units[1].y
          SpawnTemplate.x = RandomVec2.x
          SpawnTemplate.y = RandomVec2.y
          for UnitID = 1, #SpawnTemplate.units do
            SpawnTemplate.units[UnitID].x = SpawnTemplate.units[UnitID].x + ( RandomVec2.x - CurrentX )
            SpawnTemplate.units[UnitID].y = SpawnTemplate.units[UnitID].y + ( RandomVec2.y - CurrentY )
            self:T( 'SpawnTemplate.units['..UnitID..'].x = ' .. SpawnTemplate.units[UnitID].x .. ', SpawnTemplate.units['..UnitID..'].y = ' .. SpawnTemplate.units[UnitID].y )
          end
        end
        
        -- If RandomizeUnits, then Randomize the formation at the start point.
        local _previousAssignedCoordinates = {}
        local _vec2AssignedPreviously = false
        if self.SpawnRandomizeUnits then
          if not self.SpawnOuterRadius or self.SpawnOuterRadius <= 0 then self.SpawnOuterRadius = 150 end 
          if not self.SpawnInnerRadius or self.SpawnInnerRadius <= 0 then self.SpawnInnerRadius = 50 end
          for UnitID = 1, #SpawnTemplate.units do
            --[[ 
              =MDS=Crasso 27/08/2020 - prevent unit overlapping by checking if distance 
              from random vec2 and all previous assigned vec2 is > then 50
            --]]
            local RandomVec2 = PointVec3:GetRandomVec2InRadius( self.SpawnOuterRadius, self.SpawnInnerRadius )
            _vec2AssignedPreviously = table.getn(_previousAssignedCoordinates) > 0
            local _innerCheck = true
            while(_vec2AssignedPreviously) do
              for i,vec in ipairs(_previousAssignedCoordinates) do
                local _previousCoordinate = COORDINATE:NewFromVec2(vec) 
                local _coordinate = COORDINATE:NewFromVec2(RandomVec2)
                local _distance = _previousCoordinate:DistanceFromPointVec2(_coordinate)
                _innerCheck = _innerCheck and _distance > 50
              end
              if _innerCheck then
                _vec2AssignedPreviously = false
              else
                _innerCheck = true
                RandomVec2 = PointVec3:GetRandomVec2InRadius( self.SpawnOuterRadius, self.SpawnInnerRadius )
              end
            end
            
            SpawnTemplate.units[UnitID].x = RandomVec2.x
            SpawnTemplate.units[UnitID].y = RandomVec2.y
            table.insert(_previousAssignedCoordinates, RandomVec2)
            self:T( 'SpawnTemplate.units['..UnitID..'].x = ' .. SpawnTemplate.units[UnitID].x .. ', SpawnTemplate.units['..UnitID..'].y = ' .. SpawnTemplate.units[UnitID].y )
            
          end
        end
        
        -- Get correct heading in Radians.
        local function _Heading(courseDeg)
          local h
          if courseDeg<=180 then
            h=math.rad(courseDeg)
          else
            h=-math.rad(360-courseDeg)
          end
          return h 
        end        

        local Rad180 = math.rad(180)
        local function _HeadingRad(courseRad)
          if courseRad<=Rad180 then
            return courseRad
          else
            return -((2*Rad180)-courseRad)
          end
        end        

        -- Generate a random value somewhere between two floating point values.
        local function _RandomInRange ( min, max )
          if min and max then
            return min + ( math.random()*(max-min) )
          else
            return min
          end
        end

        -- Apply InitGroupHeading rotation if requested.
        -- We do this before InitHeading unit rotation so that can take precedence
        -- NOTE: Does *not* rotate the groups route; only its initial facing.
        if self.SpawnInitGroupHeadingMin and #SpawnTemplate.units > 0 then

          local pivotX = SpawnTemplate.units[1].x -- unit #1 is the pivot point
          local pivotY = SpawnTemplate.units[1].y

          local headingRad = math.rad(_RandomInRange(self.SpawnInitGroupHeadingMin or 0,self.SpawnInitGroupHeadingMax))
          local cosHeading = math.cos(headingRad)
          local sinHeading = math.sin(headingRad)  
          
          local unitVarRad = math.rad(self.SpawnInitGroupUnitVar or 0)

          for UnitID = 1, #SpawnTemplate.units do
          
            if UnitID > 1 then -- don't rotate position of unit #1
              local unitXOff = SpawnTemplate.units[UnitID].x - pivotX -- rotate position offset around unit #1
              local unitYOff = SpawnTemplate.units[UnitID].y - pivotY

              SpawnTemplate.units[UnitID].x = pivotX + (unitXOff*cosHeading) - (unitYOff*sinHeading)
              SpawnTemplate.units[UnitID].y = pivotY + (unitYOff*cosHeading) + (unitXOff*sinHeading)
            end
            
            -- adjust heading of all units, including unit #1
            local unitHeading = SpawnTemplate.units[UnitID].heading + headingRad -- add group rotation to units default rotation
            SpawnTemplate.units[UnitID].heading = _HeadingRad(_RandomInRange(unitHeading-unitVarRad, unitHeading+unitVarRad))
            SpawnTemplate.units[UnitID].psi = -SpawnTemplate.units[UnitID].heading
            
          end

        end
        
        -- If Heading is given, point all the units towards the given Heading.  Overrides any heading set in InitGroupHeading above.
        if self.SpawnInitHeadingMin then
          for UnitID = 1, #SpawnTemplate.units do
            SpawnTemplate.units[UnitID].heading = _Heading(_RandomInRange(self.SpawnInitHeadingMin, self.SpawnInitHeadingMax))
            SpawnTemplate.units[UnitID].psi = -SpawnTemplate.units[UnitID].heading
          end
        end
        
        -- Set livery.
        if self.SpawnInitLivery then
          for UnitID = 1, #SpawnTemplate.units do
            SpawnTemplate.units[UnitID].livery_id = self.SpawnInitLivery
          end
        end

        -- Set skill.
        if self.SpawnInitSkill then
          for UnitID = 1, #SpawnTemplate.units do
            SpawnTemplate.units[UnitID].skill = self.SpawnInitSkill
          end
        end

        -- Set tail number.
        if self.SpawnInitModex then
          for UnitID = 1, #SpawnTemplate.units do
            SpawnTemplate.units[UnitID].onboard_num = string.format("%03d", self.SpawnInitModex+(UnitID-1))
          end
        end
        
        -- Set radio comms on/off.
        if self.SpawnInitRadio then
          SpawnTemplate.communication=self.SpawnInitRadio
        end        
        
        -- Set radio frequency.
        if self.SpawnInitFreq then
          SpawnTemplate.frequency=self.SpawnInitFreq
        end
        
        -- Set radio modulation.
        if self.SpawnInitModu then
          SpawnTemplate.modulation=self.SpawnInitModu
        end        
        
        -- Set country, coaliton and categroy.
        SpawnTemplate.CategoryID = self.SpawnInitCategory or SpawnTemplate.CategoryID 
        SpawnTemplate.CountryID = self.SpawnInitCountry or SpawnTemplate.CountryID 
        SpawnTemplate.CoalitionID = self.SpawnInitCoalition or SpawnTemplate.CoalitionID 
        
        
--        if SpawnTemplate.CategoryID == Group.Category.HELICOPTER or SpawnTemplate.CategoryID == Group.Category.AIRPLANE then
--          if SpawnTemplate.route.points[1].type == "TakeOffParking" then
--            SpawnTemplate.uncontrolled = self.SpawnUnControlled
--          end
--        end
      end
      
      if not NoBirth then
        self:HandleEvent( EVENTS.Birth, self._OnBirth )
      end
      self:HandleEvent( EVENTS.Dead, self._OnDeadOrCrash )
      self:HandleEvent( EVENTS.Crash, self._OnDeadOrCrash )
      self:HandleEvent( EVENTS.RemoveUnit, self._OnDeadOrCrash )
      if self.Repeat then
        self:HandleEvent( EVENTS.Takeoff, self._OnTakeOff )
        self:HandleEvent( EVENTS.Land, self._OnLand )
      end
      if self.RepeatOnEngineShutDown then
        self:HandleEvent( EVENTS.EngineShutdown, self._OnEngineShutDown )
      end

      self.SpawnGroups[self.SpawnIndex].Group = _DATABASE:Spawn( SpawnTemplate )
      
      local SpawnGroup = self.SpawnGroups[self.SpawnIndex].Group -- Wrapper.Group#GROUP
      
      --TODO: Need to check if this function doesn't need to be scheduled, as the group may not be immediately there!
      if SpawnGroup then
      
        SpawnGroup:SetAIOnOff( self.AIOnOff )
      end

      self:T3( SpawnTemplate.name )
      
      -- If there is a SpawnFunction hook defined, call it.
      if self.SpawnFunctionHook then
        -- delay calling this for .1 seconds so that it hopefully comes after the BIRTH event of the group.
        self.SpawnHookScheduler:Schedule( nil, self.SpawnFunctionHook, { self.SpawnGroups[self.SpawnIndex].Group, unpack( self.SpawnFunctionArguments)}, 0.1 )
      end
      -- TODO: Need to fix this by putting an "R" in the name of the group when the group repeats.
      --if self.Repeat then
      --  _DATABASE:SetStatusGroup( SpawnTemplate.name, "ReSpawn" )
      --end
    end
    
    
    self.SpawnGroups[self.SpawnIndex].Spawned = true
    return self.SpawnGroups[self.SpawnIndex].Group
  else
    --self:E( { self.SpawnTemplatePrefix, "No more Groups to Spawn:", SpawnIndex, self.SpawnMaxGroups } )
  end

  return nil
end
