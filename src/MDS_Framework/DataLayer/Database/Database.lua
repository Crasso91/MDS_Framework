local flatdb = require 'flatdb'

MDSDatabase = {
  templates = {},
  Coalition = nil,
  Factions = {},
  Categories = {},
  Types = {},
  UnitNames = {},
  Missions = {},
  Era = nil,
  FilterResult = {}
}

function MDSDatabase:New() 
  local self = BASE:Inherit( self, BASE:New() )
  local dbDirectory = lfs.writedir() .. [[databases]]
  self.db = flatdb(dbDirectory) 
  return self
end

function MDSDatabase:GetTemplates() 
  return self.db.templates.Factions
end

function MDSDatabase:SetTemplates(_templates) 
  if self.db.templates == nil then self.db.templates = {} end
  self.db.templates.Factions = _templates
  return self
end

function MDSDatabase:FilterCoalition(_in)
  self.Coalition = _in
  return self
end

function MDSDatabase:FilterFactions(_in)
  self.Factions = _in
  return self
end

function MDSDatabase:FilterCategories(_in)
  self.Categories = _in
  return self
end

function MDSDatabase:FilterUnitTypes(_in)
  self.Types = _in
  return self
end

function MDSDatabase:FilterUnitNames(_in)
  self.UnitNames = _in
  return self
end

function MDSDatabase:FilterMissions(_in)
  self.Missions = _in
  return self
end

function MDSDatabase:FilterEra(_in)
  self.Era = _in
  return self
end

function MDSDatabase:GetFilterResult()
  return self.FilterResult
end

function MDSDatabase:FilterStart()
  local templates = self:GetTemplates()
  if self.Coalition then
     for cId,c in pairs(templates) do  
      if cId ~= self.Coalition then
        templates[cId] = nil
      end
    end
  end
  
  if table.getn(self.Factions) >0 then
    for cId,c in pairs(templates) do  
      for fId, f in pairs(templates[cId].Factions) do
        if not self:ArrayHasValue(self.Factions, fId) then
          c.Factions[fId] = nil
        end
      end
    end
  end
  
  if table.getn(self.UnitNames) > 0 then
    for cId,c in pairs(templates) do  
      for fId, f in pairs(templates[cId].Factions) do
        for uId,u in pairs(templates[cId].Factions[fId].Units) do
          if not self:ArrayHasValue(self.UnitNames,uId) then
            f.Units[uId] = nil
          end
        end
      end
    end
  end
   
  if table.getn(self.Missions) > 0 then
    for cId,c in pairs(templates) do  
      for fId, f in pairs(templates[cId].Factions) do
        for uId,u in pairs(templates[cId].Factions[fId].Units) do
          for mId,m in pairs(u.Missions) do
            if not self:ArrayHasValue(self.Missions,mId) then
              u.Missions[mId] = nil
            elseif (self.Era ~= nil and self.Era < tonumber(u.Era[1]) and self.Era > tonumber(u.Era[2])) then
              u.Missions[mId] = nil
            end
          end
        end
      end
    end
  end
  
  if table.getn(self.Categories) > 0 then
    for cId,c in pairs(templates) do  
      for fId, f in pairs(templates[cId].Factions) do
        for uId,u in pairs(templates[cId].Factions[fId].Units) do
          for mId,m in pairs(u.Missions) do
            for tId,t in pairs(m.Templates) do
                if not self:ArrayHasValue(self.Categories,t.Group.CategoryID )
                 then
                  m.Templates[tId] = nil
                end
              end
          end
        end
      end
    end
  end
  
  if table.getn(self.Types) > 0 then
    for cId,c in pairs(templates) do  
      for fId, f in pairs(templates[cId].Factions) do
        for uId,u in pairs(templates[cId].Factions[fId].Units) do
          for mId,m in pairs(u.Missions) do
            for tId,t in pairs(m.Templates) do
                if not self:ArrayHasValue(self.Types,t.Group.units[1].type )
                 then
                  m.Templates[tId] = nil
                end
              end
          end
        end
      end
    end
  end
  
  for cId,c in pairs(templates) do  
      for fId, f in pairs(templates[cId].Factions) do
        for uId,u in pairs(templates[cId].Factions[fId].Units) do
          for mId,m in pairs(u.Missions) do
            for tId,t in pairs(m.Templates) do
                table.insert(self.FilterResult, t)
              end
          end
        end
      end
    end
  
  --return templates
  return self
end

function MDSDatabase:GetTemplatesBy(_coalition, _faction, _category, _mission, _type)
  local templates = self:GetTemplates()[_coalition].Factions[_faction]
  local _result = {}
  local template = nil
  
  for i,u in pairs(templates.Units) do
    if u.Missions[_mission] ~= nil then
      for y,t in pairs(u.Missions[_mission].Templates) do
        if   t.Group.units[1].type == _type  or (_type == nil and t.Group.CategoryID == _category)  then
--          template = t
          table.insert(_result, t)
        end
      end
    end
  end
  
  return _result
end

function MDSDatabase:save() 

  self.db:save()
  
end

function MDSDatabase:ArrayHasValue (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end