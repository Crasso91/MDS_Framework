Configuration = {
    Settings = {
    Coalition = "Blue",
    Nation = "USA",
    Era = 2000,
    TakeoffMode = TakeoffMode.Runway,
    LandMode = LandMode.Runway,
  Flags = {
    TacticalDiplay = true, 
    Dispatchers = {
      Blue_Active = false,
      Blue_USA_Active = true,
      Blue_USA_AG_Active = true,
      Blue_USA_AG_A10_BAI_Active = true,
      Blue_USA_AG_AH64D_BAI_Active = true,
      
      Red_Active = true,
      Red_Russia_Active = true,
      Red_Russia_GCI_Active = false,
      Red_Russia_AA_Active = true,
      ["Red_Russia_AA_Su-27_CAP_Active"] = true,
      ["Red_Russia_AA_MiG-31_CAP_Active"] = true,
      ["Red_Russia_AA_JS-17_CAP_Active"] = true
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
                Overhead = 0.25,
                AirbaseResourceMode = AirbaseResourceMode.RandomAirbase,
                ResourceCount = 4,
              },
              [Mission.CAS] = {},
              [Mission.SEAD] = {}
            }
          },
          ["AH64D"] = {
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
              },
              [Mission.CAS] = {},
              [Mission.SEAD] = {}
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
        Active = Configuration.Settings.Flags.Russia_AA_Active,
        DetectionGroups = {{ Name = "EWR", isPrefix = true }},
        CAPZones = {{ Name = "CAP", isPrefix = true }}, 
        --SimultaneousMaxCAP = 2,
        TakeoffMode = Configuration.Settings.TakeoffMode,
        TakeoffInterval = 20,
        LandMode = Configuration.Settings.LandMode, 
        --EnemyGroupingRadiuos = 6000,
        EngageRadius = 80000,
        InterceptDelay = 10,
        --GciRadious = 10
        TacticalDisplay = Configuration.Settings.Flags.TacticalDiplay,
        Units = { 
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
                ResourceCount = 4,
                CapLimit = 2,
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
                ResourceCount = 4,
                CapLimit = 2,
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

