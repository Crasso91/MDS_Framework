-- Zona arricchita di informazioni per eseguire filtri dinamici

ZONE_ENRICHED = {
  ClassName = "ZoneEnriched",
}

function ZONE_ENRICHED:NEW(_Zone, _ZoneName, _Type, _SubType) 
  local self = BASE:Inherit(self, ZONE_BASE:New(Zone.GetName()))
  self = _Zone
  self.F({_ZoneName, _Type, _SubType })
  self.ZoneNameSimply = _ZoneName
  self.Type = _Type
  self.SubType = _SubType
end 

--function ZONE_ENRICHED:GetType() 
--  return self.Type
--end
--
--function ZONE_ENRICHED:SetType(_type) 
--  self.Type = _type
--end
--
--function ZONE_ENRICHED:GetSubType() 
--  return self.SubType
--end
--
--function ZONE_ENRICHED:SetSubType(_subType) 
--  self.SubType = _subType
--end
--
--function ZONE_ENRICHED:IsStart() 
--  return self.isStart
--end
--
--function ZONE_ENRICHED:IsStart(_isStart) 
--  self.isStart = _isStart
--end