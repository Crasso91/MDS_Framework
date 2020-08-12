-- Service per la gestione delle zone predefinite nella mappa attraverso i Trigger
-- Per poter essere gestiti da questo service i trigger devono avere la segunte nomenclatura:
-- Nome_Tipo_Sottotipo ex. Trigger112_0_0 = Trigger112_AG_CONVOY

--Elenco delle numerazioni: 
--Tipi:
--AG = 0,
--AA = 1,
--Sottotipi:
--CONVOY = 0,
--CAP = 1,
--CAS = 2,
--STATIC = 3

ZonesManagerService = {
  ClassName = "ZonesManagerService",
--  Zones = {},
--  ZonesCount = 0
}

function ZonesManagerService:New()
--  for ZoneID, ZoneData in pairs(DATABASE.ZONES) do
--    local zoneNameSplitted = split(ZoneData.ZoneName, "_")
--    local zoneName = zoneNameSplitted[0]
--    local type = zoneNameSplitted[1]
--    local subtype = zoneNameSplitted[2]
--    
--    local zoneEnriched = ZONE_ENRICHED:NEW(ZoneData, zoneName, type, subtype)
--    
--    if zoneName ~= nil then
--      self.Zones[zoneName] = zoneEnriched
--      self.ZonesCount = self.ZonesCount + 1;
--    end 
--  end
return self
end

function ZonesManagerService:GetZonesByPrefix(_prefix)
  env.info("GetZonesByPrefix")
  return SET_ZONE:New()
    :FilterPrefixes(_prefix)
    :FilterStart().Set
end

function ZonesManagerService:GetSetZonesByPrefix(_prefix)
  env.info("GetZonesByPrefix")
  return SET_ZONE:New()
    :FilterPrefixes(_prefix)
    :FilterStart()
end

function ZonesManagerService:GetZoneByName(_name)
  return ZONE:New(_name)
end

function ZonesManagerService:GetRandomZone()
  local zones = SET_ZONE:New()
    :FilterPrefixes()
    :FilterStart()
  local count = 0
  
  for zoneId, zone in pairs(zones) do
    count = count + 1  
  end
  
  local random = math.random(0, count)
  
  return zones[random]
end

function ZonesManagerService:GetRandomZoneByPrefix(_prefix)
  env.info("GetRandomZoneByPrefix")
  local set_zone = self:GetSetZonesByPrefix(_prefix)
  local count = 0
  
  for zoneId, zone in pairs(set_zone.Set) do
    count = count + 1  
  end
  
  local random = math.random(1, count)
  
  return set_zone.Set[set_zone.Index[random]]:GetZoneMaybe() 
end

--function ZonesManagerService:GetZoneByName(_zoneName)
--  local zoneFound = self.AG[_zoneName]
--  
--  if zoneFound == nil then
--    zoneFound = self.AA[_zoneName]
--  end
--  
--  return zoneFound;
--end
--
--function ZonesManagerService:GetZonesByType(_zoneType)
--  local _return = {}
--  for zoneId, zone in pairs(self.Zones) do
--    if zone.Type == _zoneType then
--      _return[zone.ZoneName] = zone
--    end
--  end
--  return _return
-- end
--
--function ZonesManagerService:GetZonesBySubType(_zoneSubType)
--  local _return = {}
--  for zoneId, zone in pairs(self.Zones) do
--    if zone.SubType == _zoneSubType then
--      _return[zone.ZoneName] = zone
--    end
--  end
--  return _return 
--end
--
--function ZonesManagerService:GetRandomZone()
--  local _return = {}
--  local random = math.random(0, self.ZonesCount)
--  
--  return self.zones[random]
--    
--end
--
--function ZonesManagerService:GetRandomZoneByType(_zoneType)
--  local zones = self:GetZonesByType(_zoneType)
--  local zonesCount = 0
--  for zoneis, zone in pairs(zones) do
--    zonesCount = zonesCount + 1
--  end
--  local random = math.random(0, zonesCount)
--  return zones[random]
--end
--
--function ZonesManagerService:GetRandomZoneBySubType(_zoneType)
--  local zones = self:GetZonesBySubType(_zoneType)
--  local zonesCount = 0
--  for zoneis, zone in pairs(zones) do
--    zonesCount = zonesCount + 1
--  end
--  local random = math.random(0, zonesCount)
--  return zones[random]
--end

