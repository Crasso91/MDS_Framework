
ConvoyService = {
  ClassName = "ConvoyService",
  Configuration = Configuration.Settings,
  SendMessageOnSpawn = false,
  Message = "Enemy convoy at $cordinates moving to $compassDirection Heading ($heading)",
  StartZones = {},
  EndZones = {},
  Groups = {},
  GroupType = nil,
  Faction = nil,
  MenuCoalition = nil,
  ConvoyCoalition = nil,
  Type = nil,
  SpawnOnMenuAction = false,
  Menu = "Convoy",
  Command = "Spawn Convoy",
  MenuCoalitionObject = nil,
  MenuIntelObject = nil,
  MenuConvoyObject = nil,
  UnitNumber = 3,
  RequestableIntel = true
}

function ConvoyService:New()
  self = ConvoyService
  return self
end

function ConvoyService:SetGroup(_group) 
  self.Groups  = { GROUP:FindByName(_group).GroupName }
  return self
end

function ConvoyService:SetGroupType(_type)
  self.GroupType = _type
  return self
end

function ConvoyService:SetFaction(_faction) 
  self.Faction = _faction
  return self
end

function ConvoyService:SetCoalition(_coalition) 
  self.Coalition = _coalition
  return self
end

function ConvoyService:SetCategory(_category) 
  self.Category = _category
  return self
end

function ConvoyService:SetUnitNumber(_unitNumber)
  self.UnitNumber = _unitNumber
  return self
end

function ConvoyService:SetStartZones(_startZones, _isPrefix)
  self.StartZones = { Zones = _startZones, isPrefix = _isPrefix } 
  return self
end

function ConvoyService:SetEndZones(_endZones, _isPrefix) 
  self.EndZones = { Zones = _endZones, isPrefix = _isPrefix } 
  
  return self
end

function ConvoyService:SetMessageOnSpawn(_message)
  self.SendMessageOnSpawn = true
  if _message ~= nil then self.Message = _message end
  return self
end

function ConvoyService:SetRequestableIntel(_in)
  self.RequestableIntel = _in
  return self
end

function ConvoyService:AssignTask()
  self.AssignTask = true
  return self
end

function ConvoyService:InitGroupByFilters()
  if table.getn(self.Groups) ~= 0 then return self.Groups  end
  self.Groups = TemplateManager:New()
    --:InitLazyGroupsByFilters(self.Coalition, self.Faction, self.Category, Mission.GROUND, self.GroupType)
    :InitLazyConovyGroupByFilters(self.UnitNumber, self.Coalition, self.Faction, self.Category, Mission.GROUND, self.GroupType)
    :GetLazyGroupsNames()
end

function ConvoyService:SetMenuAction(_menu, _command, _coalition)
  self.SpawnOnMenuAction = true
  self.Command = _command 
  self.MenuCoalition = _coalition 
  self.MenuCoalitionObject =  MENU_COALITION:New(_coalition, _menu)
  
  return self
end

function ConvoyService:GetRandomizedSpawn()
  self:InitGroupByFilters()
  local SpawnConvoy = self:GetSpawnObject()
  return SpawnConvoy
end

function ConvoyService:Spawn()
  
  if self.SpawnOnMenuAction then
    MENU_COALITION_COMMAND:New(self.MenuCoalition, self.Command, self.MenuCoalitionObject, 
      function () 
        self.Groups = {}
        self:InitGroupByFilters()
        local SpawnConvoy = self:GetSpawnObject()
        SpawnConvoy:Spawn() 
      end
    )
  else
  self:InitGroupByFilters()
  local SpawnConvoy = self:GetSpawnObject()
  SpawnConvoy:Spawn() 
  end
end 

function ConvoyService:GetSpawnObject()
  local GroundOrgZones = {}
  local startZones = {}
  local endZone = {}
  
  if self.StartZones.isPrefix then
    startZones = ZonesManagerService:GetZonesByPrefix(self.StartZones.Zones)
  else
    for zoneId, zone in pairs(self.StartZones) do
      table.insert(startZones, zone)
    end
  end
  
  if self.EndZones.isPrefix then
    endZone = ZonesManagerService:GetRandomZoneByPrefix(self.EndZones.Zones)
  else
    local randomZone = self.EndZones.Zones[math.random(1, UtilitiesService:Lenght(self.EndZones.Zones))]
    endZone = ZONE:New(self.EndZones.Zones)
  end
  
  for zoneId, zone in pairs(startZones) do
     table.insert(GroundOrgZones, zone)
  end
  
  local unitSpawn = SPAWN:New( self.Groups[1] )
    :InitLimit(self.UnitNumber,1)
    --:InitGrouping(self.UnitNumber)
  
  if table.getn(self.Groups) > 1 then
    unitSpawn:InitRandomizeTemplate(self.Groups)
  end
  
  unitSpawn
    :InitRandomizeRoute( 1, 1, 200 ) 
    :InitRandomizePosition(500, 50)
    :InitRandomizeUnits(true,500,50)
    :InitRandomizeZones( GroundOrgZones )
    :OnSpawnGroup(
      function(SpawnGroup)
        env.info("Convoy " .. SpawnGroup.GroupName .. " Spawned")
        SpawnGroup:TaskRouteToZone(endZone,true,150,"On Road")
        
        if self.SendMessageOnSpawn then
          
          self:SendIntelMessage(SpawnGroup, endZone)
          
          if self.SpawnOnMenuAction then
          
            self.MenuConvoyObject =  MENU_COALITION:New(self.MenuCoalition, SpawnGroup.GroupName, self.MenuCoalitionObject)
             SpawnGroup:HandleEvent(EVENTS.Dead, function ()
                if table.getn(SpawnGroup:GetUnits()) == 1 then
                  self:RemoveMenu(SpawnGroup.GroupName)
                end 
              end
              )
            
            if self.RequestableIntel then
              MENU_COALITION_COMMAND:New(self.MenuCoalition, "Intel",self.MenuConvoyObject, function() self:SendIntelMessage(SpawnGroup, endZone) end)
            end
            
            MENU_COALITION_COMMAND:New(self.MenuCoalition, "Delete convoy", self.MenuConvoyObject, 
              function(removeMenu)
                SpawnGroup:Destroy(true)
                env.info("Convoy " .. SpawnGroup.GroupName .. " Removed")
              end
            )
          end
        end
      end
  )
  return unitSpawn
end

function ConvoyService:SendIntelMessage(_SpawnGroup, _endZone)
  local message = "" 
  local vec2Start = _SpawnGroup:GetPointVec2()
  local direction = _SpawnGroup:GetPointVec3():GetDirectionVec3(_endZone:GetCoordinate())
  local azimuth = _SpawnGroup:GetPointVec3():GetAngleDegrees(direction)
  local compass_brackets = {"N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"}
  local compass_lookup = math.floor(azimuth / 45) + 1
  local compass_direction = compass_brackets[compass_lookup]
  if compass_direction == nil then compass_direction = "" end
  azimuth = math.floor(azimuth)
  if string.len(azimuth) == 2 then azimuth = "0" .. azimuth end
  if string.len(azimuth) == 1 then azimuth = "00" .. azimuth end
  
  --local message = "Enemy convoy at " .. vec2Start:ToStringLLDDM(nil) .. " moving to " .. compass_direction .. " Heading (" .. azimuth .. ")"
  
  message = self.Message:gsub( "$cordinates", vec2Start:ToStringLLDDM(nil) )
  message = self.Message:gsub( "$compassDirection", compass_direction )
  message = self.Message:gsub( "$heading", azimuth )
  message = self.Message
  local aaAlert = false;
  for i,u in pairs(_SpawnGroup:GetUnits()) do
    if u:GetDCSObject():getAttributes()["Air Defence"] ~= nil then
      aaAlert = true
    end
  end
        
  if aaAlert then
    message = message .. " - Possible anti-aircraft threat in the area"
  end
  
  MESSAGE:New(message, 10):ToCoalition(self.MenuCoalition)
end

function ConvoyService:RemoveMenu(_menuId) 
  local masterObject = SCHEDULER:New(self.MenuCoalitionObject:GetMenu(_menuId))
  masterObject:Schedule(nil,
    function (commandMenu) 
      commandMenu:Remove()
      env.info("Remove command deleted")
    end
  , {self.MenuCoalitionObject:GetMenu(_menuId)}, .5)
end

