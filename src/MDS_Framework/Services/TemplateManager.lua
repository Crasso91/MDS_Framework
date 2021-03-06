TemplateManager = {
  ClassName = "TemplateManager",
  LazyGroups = {},
  InitializedGroups = {}
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
  
  local convoy = routines.utils.deepCopy(UtilitiesService:GetRandomOfUnsequncialTable(_templates))
  convoy.Group.name = convoy.Group.name .. "_Dynamic"
  for i = 2, _unitNumber do
    local _unit =  routines.utils.deepCopy(UtilitiesService:GetRandomOfUnsequncialTable(_templates))
--    local _unit = routines.utils.deepCopy(_templates[2])
    convoy.Group.units[i] = _unit.Group.units[1]
    convoy.Group.units[i].x = convoy.Group.units[1].x + math.random(1, 1000) + (i * 100)
    convoy.Group.units[i].y = convoy.Group.units[1].y + math.random(1, 1000) + (i * 100)
  end
  
  self:InitLazyGroupByTemplate(convoy.Group.name .. "_Dynamic",convoy)
  return self
end


function TemplateManager:InitLazyGroupByTemplate(id, _template)
  local initializedTemplate = self.InitializedGroups[i]
    if not initializedTemplate then
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
      self.InitializedGroups[id] = _templateGroup
    else    
      table.insert(self.LazyGroups, initializedTemplate)
    end
  return self
end

function TemplateManager:InitLazyGroupsByTemplates(_templates)
  local _result = {}
  for i,t in pairs(_templates) do
    local initializedTemplate = self.InitializedGroups[i]
    if not initializedTemplate then
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
      self.InitializedGroups[i] = _templateGroup
    else    
      table.insert(self.LazyGroups, initializedTemplate)
    end
  end
  return self
end


