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
