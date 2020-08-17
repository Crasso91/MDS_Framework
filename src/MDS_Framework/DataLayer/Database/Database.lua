local flatdb = require 'flatdb'

MDSDatabase = {
  templates = {}
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

function MDSDatabase:save() 

  self.db:save()
  
end
