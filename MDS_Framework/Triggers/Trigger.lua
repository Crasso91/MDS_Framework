Trigger = {
  trigrules = {
    action = {
        KeyDict_comment = "DynamicTrigger_$unitName_$triggerName_comment",
        KeyDict_text = "DynamicTrigger_$unitName_$triggerName_text",
        coalitionlist = "",
        comment = "DynamicTrigger_$unitName_$triggerName_comment",
        meters = 0,
        predicate = Predicate.Action.MarkCoalition,
        readonly = false,
        text = "DynamicTrigger_$unitName_$triggerName_text",
        value = 10,
        zone = 0,
    },
    rule = {
        _max = 0,
        _min = 0,
        argument = 0,
        predicate = Predicate.Condition.UnitInZone,
        unit = 0,
        zone = 0
    },
  },
  trig = {
    action = [[$trigrules.action.predicate($trigrules.action.value, getValueDictByKey(\"$trigrules.action.KeyDict_text\"), $trigrules.action.zone, \"$trigrules.action.coalitionlist\", $trigrules.action.readonly, getValueDictByKey(\"$trigrules.action.KeyDict_comment\")); mission.trig.func[$index]=nil;]],
    condition = "return($trigrules.rule.predicate($trigrules.rule.unit, $trigrules.rule.zone) )",
    func = "if mission.trig.conditions[$index]() then mission.trig.actions[$index]() end"
  },
  UnitName = "",
  TriggerName = "",
  TriggerIndex = 999
}

function Trigger:New()
 self = routines.utils.deepCopy(Trigger)
 return self
end

function Trigger:SetUnitName(_unitName)
  self.UnitName = _unitName
  return self
end

function Trigger:SetTriggerName(_triggerName)
  self.TriggerName = _triggerName
  return self
end

function Trigger:SetCoalition(_coalition)
  local unitCoalition = UNIT:FindByName(self.UnitName):GetGroup():GetCoalition()
  self.trigrules.action.coalitionlist = string.lower(UtilitiesService:GetEnumKeyByValue(coalition.side, unitCoalition))
  return self
end

function Trigger:SetActivationMeter(_meters)
  self.trigrules.action.meters = _meters 
  return self
end

function Trigger:SetActionPredicate(_predicate)
  self.trigrules.action.predicate = _predicate
  return self
end

function Trigger:SetConditionPredicate(_predicate)
  self.trigrules.rule.predicate = _predicate
  return self
end

function Trigger:_Prepare() 
  self.TriggerIndex = UtilitiesService:Lenght(env.mission.trig.actions) + 1
  local unitID = UNIT:FindByName(self.UnitName):GetID()
  local triggerID = nil
  for i,t in pairs(env.mission.triggers.zones) do
    if t.name == self.TriggerName then
      triggerID = t.zoneId
      break
    end
  end
  
  self.trigrules.action.KeyDict_comment = self.trigrules.action.KeyDict_comment:gsub("$unitName", self.UnitName)
  self.trigrules.action.KeyDict_comment = self.trigrules.action.KeyDict_comment:gsub("$triggerName", self.TriggerName)
  self.trigrules.action.KeyDict_text = self.trigrules.action.KeyDict_text:gsub("$unitName", self.UnitName)
  self.trigrules.action.KeyDict_text = self.trigrules.action.KeyDict_text:gsub("$triggerName", self.TriggerName)
  self.trigrules.action.comment = self.trigrules.action.comment:gsub("$unitName", self.UnitName)
  self.trigrules.action.comment = self.trigrules.action.comment:gsub("$triggerName", self.TriggerName)
  self.trigrules.action.text = self.trigrules.action.text:gsub("$unitName", self.UnitName)
  self.trigrules.action.text = self.trigrules.action.text:gsub("$triggerName", self.TriggerName)
  
  self.trigrules.action.zone = triggerID
  self.trigrules.rule.zone = triggerID
  self.trigrules.rule.unit = unitID
  
  self.trig.action = self.trig.action:gsub("$trigrules.action.predicate",self.trigrules.action.predicate)
  self.trig.action = self.trig.action:gsub("$trigrules.action.value",self.trigrules.action.value)
  self.trig.action = self.trig.action:gsub("$trigrules.action.KeyDict_text",self.trigrules.action.KeyDict_text)
  self.trig.action = self.trig.action:gsub("$trigrules.action.zone",self.trigrules.action.zone)
  self.trig.action = self.trig.action:gsub("$trigrules.action.coalitionlist",self.trigrules.action.coalitionlist)
  self.trig.action = self.trig.action:gsub("$trigrules.action.readonly", tostring(self.trigrules.action.readonly))
  self.trig.action = self.trig.action:gsub("$trigrules.action.KeyDict_comment",self.trigrules.action.KeyDict_comment)
  self.trig.action = self.trig.action:gsub("$index", self.TriggerIndex)
  
  
  self.trig.condition = self.trig.condition:gsub("$trigrules.rule.predicate",self.trigrules.rule.predicate)
  self.trig.condition = self.trig.condition:gsub("$trigrules.rule.unit",self.trigrules.rule.unit)
  self.trig.condition = self.trig.condition:gsub("$trigrules.rule.zone", self.trigrules.rule.zone)
  
  
  self.trig.func = self.trig.func:gsub("$index", self.TriggerIndex)
  self.Prepared = true
  return self  
end

function Trigger:AddToMission()
  if not self.Prepared then
    self:_Prepare()
  end  
  
  env.mission.trig.actions[self.TriggerIndex] = self.trig.action
  env.mission.trig.conditions[self.TriggerIndex] = self.trig.condition
  env.mission.trig.flag[self.TriggerIndex] = true
  env.mission.trig.func[self.TriggerIndex] = self.trig.func
  
  env.mission.trigrules[self.TriggerIndex] = {}
  env.mission.trigrules[self.TriggerIndex].actions= {}
  env.mission.trigrules[self.TriggerIndex].rules = {}
  
  env.mission.trigrules[self.TriggerIndex].actions[1] = self.trigrules.action
  env.mission.trigrules[self.TriggerIndex].comment = self.trigrules.action.text
  env.mission.trigrules[self.TriggerIndex].predicate = Predicate.TriggerOnce
  env.mission.trigrules[self.TriggerIndex].rules[1] = self.trigrules.rule
end



