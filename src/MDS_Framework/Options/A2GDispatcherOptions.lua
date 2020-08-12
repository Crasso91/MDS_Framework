A2GDispatcherOptions = {
  ClassName = "A2GDispatcherOptions",
  __index = A2GDispatcherOptions,
  CommandCenter = nil,
  DetectionArea = 5000,
  DefenseRadious = 20000,
  Reactivity = Rectivity.High,
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
