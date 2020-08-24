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

