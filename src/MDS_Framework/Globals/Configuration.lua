Configuration = {
    Settings = {
    Coalition = "Blue",
    Nation = "USA",
    Era = 1990,
    TakeoffMode = TakeoffMode.Hot,
    LandMode = LandMode.Runway,
	Flags = {
		Dispatchers = {
			Blue_Active = true,
			Red_Active = false,
			USA_Active = true,
			A10_BAI_Active = true,
			AH64D_BAI_Active = true
		}
	}
  }
}

Configuration.Dispatchers = {
    ["Blue"] = {
		Active = Configuration.Settings.Flags.Blue_Active,
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
			Active = Configuration.Settings.Flags.USA_Active,
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
					Active = Configuration.Settings.Flags.A10_BAI_Active
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
					Active = Configuration.Settings.Flags.AH64D_BAI_Active
				  },
				  [Mission.CAS] = {},
				  [Mission.SEAD] = {}
				}
			  }
			}
		}
    }
  }

