AI_G2G_Dispatcher = {
    ClassName = "AI_G2G_Dispatcher",
    Detection = {},
    DefenceZones = {},
    MissionsGroups = {},
    IntegratedDispatcher = {},
    Reactivity = Reactiviy.High,
    SimultaneuslyMissions = 1,
    MissionScheduleTime = 30
}

function AI_G2G_Dispatcher:New(_detection) 
  local self = BASE:Inherit( self, DETECTION_MANAGER:New( nil, _detection ) ) -- #AI_G2G_DISPATCHER
  self.Detection = _detection
  
  --Setting default defence zone on detection zones
  for k,v in pairs(_detection) do
      table.insert(self.DefenceZones, v:GetVec3())
  end
  
  return self
end

function AI_G2G_Dispatcher:AddDefenceZone(_zones, _isPrefix)
  if _group ~= table then
    _group = { _group }
  end
  local object = { List = _group, IsPrefix = _isPrefix}
  table.insert(self.DefenceZones, object)

  return self
end

function AI_G2G_Dispatcher:AddMissionGroup(_groups, _isPrefix)
  if _group ~= table then
    _group = { _group }
  end
  local object = { List = _group, IsPrefix = _isPrefix}
  table.insert(self.MissionsGroups, object)
  return self
end

function AI_G2G_Dispatcher:AddReinforceGroup(_group, _isPrefix)
  if _group ~= table then
    _group = { _group }
  end
  local object = { List = _group, IsPrefix = _isPrefix}
  table.insert(self.ReinforceGroups, object)
  return self
end

function AI_G2G_Dispatcher:SetReactivity(_reactivity)
  if _reactivity == nil then
    self:T("Reactiviy is nil")
    return self
  end
  self.reactivity = _reactivity
  return self
end

function AI_G2G_Dispatcher:SetSimultaneuslyMissions(_in)
  if _in == nil then
    self:T("integer input is nil")
    return self
  end
  
  self.SimultaneuslyMissions = _in
  return  self
end

function AI_G2G_Dispatcher:SetMissionScheduledTime(_in)
  if _in == nil then
    self:T("Missione schedule time is nil")
    return self
  end
  
  self.MissionScheduleTime = _in
  return self
end

function AI_G2G_Dispatcher:AddDispatcherIntegration(_dispatcherType, _dispatcher)
  if _dispatcherType == nil then
    self:T("Provided disaptcherType is nil")
    return self
  end
  if _dispatcher == nil then
    self:T("Provided disaptcher si nil")
    return self
  end
  
  table.insert(self.IntegratedDispatcher, { Type = _dispatcherType, Dispatcher = _dispatcher })
  return self
end
  