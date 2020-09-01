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
  if Configuration.Settings.DatabasePath ~= nil and Configuration.Settings.DatabasePath ~= "" then
    dbDirectory = Configuration.Settings.DatabasePath
  end
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
  local _result = {}
  for i,t in ipairs(templates) do  
    if      (self.Coalition == nil or self.Coalition == t.Coalition)
        and (table.getn(self.Factions) == 0 or UtilitiesService:ArrayHasValue(self.Factions, t.Faction))
        and (table.getn(self.Types) == 0 or UtilitiesService:ArrayHasValue(self.Types,t.VehicleType))
        and (table.getn(self.UnitNames) == 0 or UtilitiesService:ArrayHasValue(self.UnitNames,t.VehicleName))
        and (table.getn(self.Categories) == 0 or UtilitiesService:ArrayHasValue(self.Categories,t.Category))
        and (table.getn(self.Missions) == 0 or UtilitiesService:ArrayHasValue(self.Missions,t.Mission))
        and (self.Era == nil or (self.Era >= t.Era[1] and self.Era <= t.Era[2]))
        then
      _result[i] = t
    end
  end
  self.FilterResult = _result
  return self
end

function MDSDatabase:save() 

  self.db:save()
  
end
