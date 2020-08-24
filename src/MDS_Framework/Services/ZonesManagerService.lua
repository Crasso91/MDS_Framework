ZonesManagerService = {
  ClassName = "ZonesManagerService",
}

function ZonesManagerService:New()
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

