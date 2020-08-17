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

