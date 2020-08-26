TemplateManager = {
  ClassName = "TemplateManager",
  LazyGroups = {}
}

function TemplateManager:New()
  self.db = MDSDatabase:New()
  self.LazyGroups = {}
  return self
end

function TemplateManager:GetLazyGroups()
  return self.LazyGroups
end

function TemplateManager:GetLazyGroupsNames()
  local _result = {}
  for i,g in pairs(self.LazyGroups) do
    table.insert(_result, g.GroupName)
  end
  return _result
end

function TemplateManager:InitLazyGroupsByFilters(_coalition, _faction, _category, _mission, _unitType)
  --local _templates = self.db:GetTemplatesBy(_coalition, _faction, _category, _mission, _unitType)
  local _templates = self.db:FilterCoalition(_coalition)
    :FilterFactions({ _faction })
    :FilterCategories({ _category })
    :FilterMissions({ _mission })
    :FilterUnitTypes({ _unitType })
    :FilterStart()
    :GetFilterResult()
    
  self:InitLazyGroupsByTemplates(_templates)
  return self
end

function TemplateManager:InitLazyConovyGroupByFilters(_unitNumber, _coalition, _faction, _category, _mission, _unitType)
  --local _templates = self.db:GetTemplatesBy(_coalition, _faction, _category, _mission, _unitType)
  local _templates = self.db:FilterCoalition(_coalition)
    :FilterFactions({ _faction })
    :FilterCategories({ _category })
    :FilterMissions({ _mission })
    :FilterUnitTypes({ _unitType })
    :FilterStart()
    :GetFilterResult()
  
  local convoy = _templates[math.random(1, table.getn(_templates))]
  convoy.Group.name = "Dynamic Generated Conovy"
  for i = 2, _unitNumber - 1 do
    local _unit = _templates[math.random(1, table.getn(_templates))]
    convoy.Group.units[i] = _unit.Group.units[1]
    convoy.Group.units[i].x = convoy.Group.units[1].x + math.random(1, 1000) + (i * 100)
    convoy.Group.units[i].y = convoy.Group.units[1].y + math.random(1, 1000) + (i * 100)
  end
  
  self:InitLazyGroupByTemplate(convoy)
  return self
end


function TemplateManager:InitLazyGroupByTemplate(_template)
  local group = GROUP:NewTemplate(_template.Group, _template.Group.CoalitionID, _template.Group.CategoryID, _template.Group.CountryID)
    
  local _templateGroup = SPAWN:New(_template.Group.name)
    :InitLateActivated(true)
    :_Prepare( _template.Group.name, math.random(1,10000) )
    
  local _templateGroup = SPAWN:NewFromTemplate(_templateGroup, _template.Group.name, _template.Group.name)
    :InitLateActivated(true)
    :SpawnFromVec2({x=0,y=0})
    
  _DATABASE.GROUPS[_template.Group.name] = nil
  _DATABASE.Templates.Groups[_template.Group.name] = nil
  
  table.insert(self.LazyGroups, _templateGroup)
  return self
end

function TemplateManager:InitLazyGroupsByTemplates(_templates)
  local _result = {}
  for i,t in pairs(_templates) do
    local group = GROUP:NewTemplate(t.Group, t.Group.CoalitionID, t.Group.CategoryID, t.Group.CountryID)
      
    local _templateGroup = SPAWN:New(t.Group.name)
      :InitLateActivated(true)
      :_Prepare( t.Group.name, math.random(1,10000) )
      
    local _templateGroup = SPAWN:NewFromTemplate(_templateGroup, t.Group.name, t.Group.name)
      :InitLateActivated(true)
      :SpawnFromVec2({x=0,y=0})
      
    _DATABASE.GROUPS[t.Group.name] = nil
    _DATABASE.Templates.Groups[t.Group.name] = nil
    
    table.insert(self.LazyGroups, _templateGroup)
  end
  return self
end


