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
}Configuration = {
    Settings = {
    Coalition = "Blue",
    Nation = "USA",
    Era = 2000,
    TakeoffMode = TakeoffMode.Runway,
    LandMode = LandMode.Runway,
  Flags = {
    TacticalDiplay = true, 
    Dispatchers = {
      Blue_Active = true,
      Blue_USA_Active = true,
      Blue_USA_AG_Active = true,
      Blue_USA_AG_A10_BAI_Active = true,
      ["Blue_USA_AG_AH-64D_BAI_Active"] = true,
      ["Blue_USA_AG_AH-A10_BAI_Active"] = true,
      ["Blue_USA_AG_F-18C_SEAD_Active"] = true,
      
      Blue_USA_AA_Active = true,
      ["Blue_USA_AA_F-16CM_CAP_Active"] = true,
      
      Red_Active = true,
      Red_Russia_Active = true,
      Red_Russia_GCI_Active = false,
      Red_Russia_AA_Active = true,
      ["Red_Russia_AA_Su-27_CAP_Active"] = true,
      ["Red_Russia_AA_MiG-31_CAP_Active"] = true,
      ["Red_Russia_AA_JF-17_CAP_Active"] = true
    }
  }
  }
}

Configuration.Dispatchers = {
    ["Blue"] = {
    ["USA"] = {
     [1] = {
        CommandCenter = "HQ",
        DetectionArea = 10000,
        DefenseRadious = 50000,
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
              { Name = "BAI_CAS_", isPrefix = true }  
            },
            Missions = {
              [Mission.BAI] = {
                AttackAltitude = { 2000 , 3000 },
                AttackSpeed = { 360, 450 },
                Overhead = 0.10,
                AirbaseResourceMode = AirbaseResourceMode.RandomAirbase,
                ResourceCount = 4,
              },
              [Mission.CAS] = {},
              [Mission.SEAD] = {}
            }
          },
          ["AH-64D"] = {
            Airbases = { 
              { Name = "BAI_CAS_", isPrefix = true }  
            },
            Missions = {
              [Mission.BAI] = {
                AttackAltitude = { 2000 , 3000 },
                AttackSpeed = { 360, 450 },
                Overhead = 0.25,
                AirbaseResourceMode = AirbaseResourceMode.EveryAirbase,
                ResourceCount = 4,
              },
              [Mission.CAS] = {},
              [Mission.SEAD] = {}
            }
          },
          ["F-18C"] = {
            Airbases = { 
              { Name = "Airbase_CAP_SEAD", isPrefix = true }  
            },
            Missions = {
              [Mission.BAI] = {},
              [Mission.CAS] = {},
              [Mission.SEAD] = {
                AttackAltitude = { 20000 , 25000 },
                AttackSpeed = { 360, 450 },
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
        EngageRadius = 80000,
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
                AttackSpeed = { 800, 1200 },
                Overhead = 0.25,
                AirbaseResourceMode = AirbaseResourceMode.RandomAirbase,
                ResourceCount = 8,
                CapLimit = 2,
                CapGroupCount = 2,
                LowInterval = 30,
                HighInterval = 600,
                Probability = 1,
                FuelThreshold = 2.5,
              }
            }
          }
        }
      }
    }
  },
  ["Red"] = {
    ["Russia"] = {
      [1] = {
        DispatcherType = Dispatcher.AA,
        DetectionGroups = {{ Name = "EWR", isPrefix = true }},
        CAPZones = {{ Name = "CAP", isPrefix = true }}, 
        --SimultaneousMaxCAP = 2,
        TakeoffMode = Configuration.Settings.TakeoffMode,
        TakeoffInterval = 20,
        LandMode = Configuration.Settings.LandMode, 
        --EnemyGroupingRadiuos = 6000,
        EngageRadius = 80000,
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
                AttackAltitude = { 10000 , 20000 },
                AttackSpeed = { 800, 1200 },
                Overhead = 0.25,
                AirbaseResourceMode = AirbaseResourceMode.RandomAirbase,
                ResourceCount = 6,
                CapLimit = 2,
                CapGroupCount = 2,
                LowInterval = 30,
                HighInterval = 600,
                Probability = 1,
                FuelThreshold = 2.5,
              }
            }
          },
          ["MiG-31"] = {
            Airbases = { 
              { Name = "Airbase_CAP", isPrefix = true }  
            },
            Missions = {
              [Mission.CAP] = {
                AttackAltitude = { 10000 , 20000 },
                AttackSpeed = { 800, 1200 },
                Overhead = 0.25,
                AirbaseResourceMode = AirbaseResourceMode.RandomAirbase,
                ResourceCount = 6,
                CapLimit = 2,
                CapGroupCount = 2,
                LowInterval = 30,
                HighInterval = 600,
                Probability = 1,
                FuelThreshold = 2.5,
              }
            }
          },
          ["JF-17"] = {
            Airbases = { 
              { Name = "Airbase_CAP", isPrefix = true }  
            },
            Missions = {
              [Mission.CAP] = {
                AttackAltitude = { 10000 , 20000 },
                AttackSpeed = { 800, 1200 },
                Overhead = 0.25,
                AirbaseResourceMode = AirbaseResourceMode.RandomAirbase,
                ResourceCount = 6,
                CapLimit = 2,
                CapGroupCount = 2,
                LowInterval = 30,
                HighInterval = 600,
                Probability = 1,
                FuelThreshold = 2.5,
              }
            }
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





ConvoyService = {
  ClassName = "ConvoyService",
  Configuration = Configuration.Settings,
  SendMessageOnSpawn = false,
  Message = "Enemy convoy at $cordinates moving to $compassDirection Heading ($heading)",
  StartZones = {},
  EndZone = {},
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
  UnitNumber = 3
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
  if _isPrefix then
    self.StartZones = ZonesManagerService:GetZonesByPrefix(_startZones)
    --self.StartZones = { ZonesManagerService:GetRandomZoneByPrefix(_startZones) }
  else
    self.StartZones = { ZONE:New(_startZones) }
  end
  return self
end

function ConvoyService:SetRandomEndZone(_endZones, _isPrefix) 
  if _isPrefix then
    self.EndZone = ZonesManagerService:GetRandomZoneByPrefix(_endZones)
  else
    self.EndZone = { ZONE:New(_endZones) }
  end
  return self
end

function ConvoyService:SetMessageOnSpawn(_message)
  self.SendMessageOnSpawn = true
  if _message ~= nil then self.Message = _message end
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
  
  if self.SpawnOnMenuAction then
    MENU_COALITION_COMMAND:New(self.MenuCoalition, self.Command, self.MenuCoalitionObject, 
      function () 
        --SpawnConvoy:SpawnScheduled(5, 0.5)
        SpawnConvoy:Spawn() 
      end
    )
  end
  return SpawnConvoy
end

function ConvoyService:Spawn()
  self:InitGroupByFilters()
  local SpawnConvoy = self:GetSpawnObject()
  
  if self.SpawnOnMenuAction then
    MENU_COALITION_COMMAND:New(self.MenuCoalition, self.Command, self.MenuCoalitionObject, 
      function () 
        --SpawnConvoy:SpawnScheduled(5, 0.5)
        SpawnConvoy:Spawn() 
      end
    )
  else
        --SpawnConvoy:SpawnScheduled(5, 0.5)
  SpawnConvoy:Spawn() 
  end
end 

function ConvoyService:GetSpawnObject()
  local GroundOrgZones = {}
  
  for zoneId, zone in pairs(self.StartZones) do
     table.insert(GroundOrgZones, zone)
  end
  
  local unitSpawn = SPAWN:New( self.Groups[1] )
    :InitLimit(self.UnitNumber,self.UnitNumber)
    --:InitGrouping(self.UnitNumber)
  
  if table.getn(self.Groups) > 1 then
    unitSpawn:InitRandomizeTemplate(self.Groups)
  end
  
  unitSpawn
    :InitRandomizeRoute( 100, 100, 200 ) 
    --:InitRandomizePosition(1000, 10)
    :InitRandomizeUnits(true, 2000, 300)
    :InitRandomizeZones( GroundOrgZones )
    :OnSpawnGroup(
      function(SpawnGroup)
        env.info("Convoy " .. SpawnGroup.GroupName .. " Spawned")
        SpawnGroup:TaskRouteToZone(self.EndZone,true,150,"On Road")
        local aaAlert = false;
        for i,u in pairs(SpawnGroup:GetUnits()) do
          if u:GetDCSObject():getAttributes()["Air Defence"] ~= nil then
            aaAlert = true
          end
        end
        
        if self.SendMessageOnSpawn then
          local vec2Start = SpawnGroup:GetPointVec2()
          local direction = SpawnGroup:GetPointVec3():GetDirectionVec3(self.EndZone:GetCoordinate())
          local azimuth = SpawnGroup:GetPointVec3():GetAngleDegrees(direction)
          local compass_brackets = {"N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"}
          local compass_lookup = math.floor(azimuth / 45) + 1
          local compass_direction = compass_brackets[compass_lookup]
          if compass_direction == nil then compass_direction = "" end
          azimuth = math.floor(azimuth)
          if string.len(azimuth) == 2 then azimuth = "0" .. azimuth end
          if string.len(azimuth) == 1 then azimuth = "00" .. azimuth end
          
          --local message = "Enemy convoy at " .. vec2Start:ToStringLLDDM(nil) .. " moving to " .. compass_direction .. " Heading (" .. azimuth .. ")"
          
          self.Message = self.Message:gsub( "$cordinates", vec2Start:ToStringLLDDM(nil) )
          self.Message = self.Message:gsub( "$compassDirection", compass_direction )
          self.Message = self.Message:gsub( "$heading", azimuth )
          
          if aaAlert then
            self.Message = self.Message .. " - Possible anti-aircraft threat in the area"
          end
          
          MESSAGE:New(self.Message, 10):ToBlue()
          
          if self.SpawnOnMenuAction then
           
            MENU_COALITION_COMMAND:New(self.MenuCoalition, "Delete convoy " .. SpawnGroup.GroupName, self.MenuCoalitionObject, 
              function(removeMenu)
                SpawnGroup:Destroy(true)
                env.info("Convoy " .. self.Groups.GroupName .. " Removed")
                local masterObject = SCHEDULER:New(self.MenuCoalitionObject:GetMenu("Delete convoy " .. SpawnGroup.GroupName))
                masterObject:Schedule(self.MenuCoalitionObject:GetMenu("Delete convoy " .. SpawnGroup.GroupName),
                  function (mo, commandMenu) 
                    commandMenu:Remove()
                  end
                , {self.MenuCoalitionObject:GetMenu("Delete convoy " .. SpawnGroup.GroupName)}, .5)
                env.info("Remove command deleted")
              end)
          end
        end
      end
  )
  return unitSpawn
end
TemplateManager = {
  ClassName = "TemplateManager",
  LazyGroups = {}
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
  
  local convoy = _templates[math.random(1, table.getn(_templates))]
  convoy.Group.name = "Dynamic Generated Conovy"
  for i = 2, _unitNumber - 1 do
    local _unit = _templates[math.random(1, table.getn(_templates))]
    convoy.Group.units[i] = _unit.Group.units[1]
--    convoy.Group.units[i].x = convoy.Group.units[1].x + math.random(1, 1000) + (i * 100)
--    convoy.Group.units[i].y = convoy.Group.units[1].y + math.random(1, 1000) + (i * 100)
  end
  
  self:InitLazyGroupByTemplate(convoy)
  return self
end


function TemplateManager:InitLazyGroupByTemplate(_template)
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
  return self
end

function TemplateManager:InitLazyGroupsByTemplates(_templates)
  local _result = {}
  for i,t in pairs(_templates) do
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
  if self.Coalition then
     for cId,c in pairs(templates) do  
      if cId ~= self.Coalition then
        templates[cId] = nil
      end
    end
  end
  
  if table.getn(self.Factions) >0 then
    for cId,c in pairs(templates) do  
      for fId, f in pairs(templates[cId].Factions) do
        if not self:ArrayHasValue(self.Factions, fId) then
          c.Factions[fId] = nil
        end
      end
    end
  end
  
  if table.getn(self.UnitNames) > 0 then
    for cId,c in pairs(templates) do  
      for fId, f in pairs(templates[cId].Factions) do
        for uId,u in pairs(templates[cId].Factions[fId].Units) do
          if not self:ArrayHasValue(self.UnitNames,uId) then
            f.Units[uId] = nil
          end
        end
      end
    end
  end
   
  if table.getn(self.Missions) > 0 then
    for cId,c in pairs(templates) do  
      for fId, f in pairs(templates[cId].Factions) do
        for uId,u in pairs(templates[cId].Factions[fId].Units) do
          for mId,m in pairs(u.Missions) do
            if not self:ArrayHasValue(self.Missions,mId) then
              u.Missions[mId] = nil
            elseif (self.Era ~= nil and self.Era < tonumber(u.Era[1]) and self.Era > tonumber(u.Era[2])) then
              u.Missions[mId] = nil
            end
          end
        end
      end
    end
  end
  
  if table.getn(self.Categories) > 0 then
    for cId,c in pairs(templates) do  
      for fId, f in pairs(templates[cId].Factions) do
        for uId,u in pairs(templates[cId].Factions[fId].Units) do
          for mId,m in pairs(u.Missions) do
            for tId,t in pairs(m.Templates) do
                if not self:ArrayHasValue(self.Categories,t.Group.CategoryID )
                 then
                  m.Templates[tId] = nil
                end
              end
          end
        end
      end
    end
  end
  
  if table.getn(self.Types) > 0 then
    for cId,c in pairs(templates) do  
      for fId, f in pairs(templates[cId].Factions) do
        for uId,u in pairs(templates[cId].Factions[fId].Units) do
          for mId,m in pairs(u.Missions) do
            for tId,t in pairs(m.Templates) do
                if not self:ArrayHasValue(self.Types,t.Group.units[1].type )
                 then
                  m.Templates[tId] = nil
                end
              end
          end
        end
      end
    end
  end
  
  for cId,c in pairs(templates) do  
      for fId, f in pairs(templates[cId].Factions) do
        for uId,u in pairs(templates[cId].Factions[fId].Units) do
          for mId,m in pairs(u.Missions) do
            for tId,t in pairs(m.Templates) do
                table.insert(self.FilterResult, t)
              end
          end
        end
      end
    end
  
  --return templates
  return self
end

function MDSDatabase:GetTemplatesBy(_coalition, _faction, _category, _mission, _type)
  local templates = self:GetTemplates()[_coalition].Factions[_faction]
  local _result = {}
  local template = nil
  
  for i,u in pairs(templates.Units) do
    if u.Missions[_mission] ~= nil then
      for y,t in pairs(u.Missions[_mission].Templates) do
        if   t.Group.units[1].type == _type  or (_type == nil and t.Group.CategoryID == _category)  then
--          template = t
          table.insert(_result, t)
        end
      end
    end
  end
  
  return _result
end

function MDSDatabase:save() 

  self.db:save()
  
end

function MDSDatabase:ArrayHasValue (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end--Based on Configuration.lua and pre-generated Database
DispatchersProvider = {
  ClassName = "DispatchersProvider"
}


function DispatchersProvider:Init() 
  local dispatchers = Configuration.Dispatchers
  
  for coalitionId, coalition in pairs(dispatchers) do
    if Configuration.Settings.Flags.Dispatchers[coalitionId .. "_Active"] then
      for nationId, nation in pairs(coalition) do
        if Configuration.Settings.Flags.Dispatchers[coalitionId .. "_" .. nationId .. "_Active"] then
          for dispatcherId, dispatcher in ipairs(nation) do
            if Configuration.Settings.Flags.Dispatchers[coalitionId .. "_" .. nationId .. "_" .. dispatcher.DispatcherType .. "_Active"] and dispatcher.DispatcherType == Dispatcher.AG then  
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
            elseif Configuration.Settings.Flags.Dispatchers[coalitionId .. "_" .. nationId .. "_" .. dispatcher.DispatcherType .. "_Active"] and dispatcher.DispatcherType == Dispatcher.AA then
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

function DispatchersProvider:InitAGSquadronOption(coalition, faction,  _dispatcherType, unitId, unit)
  --recupero i template in base all'unita ed alla missione
  local template = MDSDatabase:New():GetTemplates()[coalition].Factions[faction].Units[unitId]
  
  if template ~= nil and Configuration.Settings.Era >= tonumber(template.Era[1]) and Configuration.Settings.Era <= tonumber(template.Era[2]) then
    for missionId, mission in pairs(unit.Missions) do
          if  Configuration.Settings.Flags.Dispatchers[coalition .. "_" .. faction .. "_" .. _dispatcherType .. "_" .. unitId .. "_" .. missionId .. "_Active"]  then
       
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

function DispatchersProvider:InitAASquadronOption(coalition, faction, _dispatcherType, unitId, unit)
  --recupero i template in base all'unita ed alla missione
  local template = MDSDatabase:New():GetTemplates()[coalition].Factions[faction].Units[unitId]
    
  if template ~= nil and Configuration.Settings.Era >= tonumber(template.Era[1]) and Configuration.Settings.Era <= tonumber(template.Era[2]) then   
  for missionId, mission in pairs(unit.Missions) do
        if  Configuration.Settings.Flags.Dispatchers[coalition .. "_" .. faction .. "_" .. _dispatcherType .. "_" .. unitId .. "_" .. missionId .. "_Active"]  then
     
      local option =  SquadronsOptions:New()
              :SetAttackAltitude(mission.AttackAltitude)
              :SetAttackSpeed(mission.AttackSpeed)
              :SetOverhead(mission.Overhead)
              :SetAirbaseResourceMode(mission.AirbaseResourceMode)
              :SetMissions(missionId)
              :SetResourceCount(mission.ResourceCount)
              :SetTemplates(template.Missions[missionId].Templates)
              :SetCapLimit(mission.CapLimit)
              :SetLowInterval(mission.LowInterval)
              :SetHighInterval(mission.HighInterval)
              :SetProbability(mission.Probability)
              :SetFuelThreshold(mission.FuelThreshold)
              
        for i, group in ipairs(unit.Airbases) do
          option:SetAirbases( coalition .. "_" .. faction .. "_" .. group.Name, group.isPrefix)
        end  
        
       
              
        return option
      end
    end
  end
  return nil
end