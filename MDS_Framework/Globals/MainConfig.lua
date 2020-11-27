Configuration.Settings = {
  Coalition = "Blue",
  Nation = "USA",
  Era = 2000,
  TakeoffMode = TakeoffMode.Runway,
  LandMode = LandMode.Runway,
  Flags = {
    Dispatchers = {
      TacticalDiplay = false, 
      
      ["BLUE"] = true,
      ["BLUE_USA"] = true,
      ["BLUE_USA_AG"] = true,
      ["BLUE_USA_AG_A10_" .. Mission.Air.BAI] = true,
      ["BLUE_USA_AG_AH-64D_" .. Mission.Air.BAI] = true,
      ["BLUE_USA_AG_FA-18C_" .. Mission.Air.SEAD] = true,
      
      ["BLUE_USA_AA"] = true,
      ["BLUE_USA_AA_F-16CM_" .. Mission.Air.CAP] = true,
      ["BLUE_USA_AA_F-14B_" .. Mission.Air.CAP] = true,
      
      ["RED"] = true,
      ["RED_RUSSIA"] = true,
      ["RED_RUSSIA_AA"] = true,
      ["RED_RUSSIA_AA_Su-27_" .. Mission.Air.CAP] = true,
      ["RED_RUSSIA_AA_MiG-31_" .. Mission.Air.CAP] = true,
      ["RED_RUSSIA_AA_JF-17_" .. Mission.Air.CAP] = true
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
        TacticalDisplay = Configuration.Settings.Flags.Dispatchers.TacticalDisplay,
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
              [Mission.Air.BAI] = {
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
              [Mission.Air.BAI] = {
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
              [Mission.Air.SEAD] = {
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
        TacticalDisplay = Configuration.Settings.Flags.Dispatchers.TacticalDisplay,
        Units = { 
          ["F-16CM"] = {
            Airbases = { 
              { Name = "Airbase_CAP_SEAD", isPrefix = true }  
            },
            Missions = {
              [Mission.Air.CAP] = {
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
              [Mission.Air.CAP] = {
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
              [Mission.Air.GCI] = {
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
        TacticalDisplay = Configuration.Settings.Flags.Dispatchers.TacticalDisplay,
        Units = { 
          ["Su-27"] = {
            Airbases = { 
              { Name = "Airbase_CAP", isPrefix = true }  
            },
            Missions = {
              [Mission.Air.CAP] = {
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
              [Mission.Air.CAP] = {
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
              [Mission.Air.CAP] = {
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

