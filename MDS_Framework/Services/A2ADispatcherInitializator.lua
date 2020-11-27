
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
    if _option.Missions == Mission.Air.CAP then
      local CAPZone = ZONE_POLYGON:New( "CAP" .. _squadronName, _CAPZone)
      _A2ADispatcher:SetSquadronCap( _squadronName, CAPZone, _option.AttackAltitude[1], _option.AttackAltitude[2], _option.AttackSpeed[1], _option.AttackSpeed[2])
      _A2ADispatcher:SetSquadronCapInterval(_squadronName, _option.CapLimit, _option.LowInterval, _option.HighInterval, _option.Probability)
      _A2ADispatcher:SetSquadronGrouping( _squadronName, _option.CapGroupCount )
--      _A2ADispatcher:SetSquadronGci( _squadronName, _option.AttackSpeed[1], _option.AttackSpeed[2])
      _A2ADispatcher:SetSquadronFuelThreshold(_squadronName, _option.FuelThreshold)
    elseif _option.Missions == Mission.Air.Gci then
      _A2ADispatcher:SetSquadronGci( _squadronName, _option.AttackSpeed[1], _option.AttackSpeed[2])--, _option.AttackAltitude[1], _option.AttackAltitude[2])
    elseif _option.Missions == Mission.Air.SEAD then
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

