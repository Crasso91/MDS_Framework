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
  Air = {
    CAP = "CAP",
    CAS = "CAS",
    BAI = "BAI",
    SEAD = "SEAD",
    GCI = "GCI"
  },
  Ground = {
    GROUND = "GROUND",
    ATTACK = "ATTACK",
    DEFENCE = "DEFENCE",
    ANTIAIR = "ANTIAIR"    
  }
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

Predicate = {
  Action = {
    MarkCoalition = "a_mark_coalition"
  },
  Condition = {
    UnitInZone = "c_unit_in_zone"
  },
  TriggerOnce = "triggerOnce"
  
}