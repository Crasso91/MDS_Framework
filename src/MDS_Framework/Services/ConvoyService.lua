
ConvoyService = {
  ClassName = "ConvoyService",
  Configuration = Configuration.Settings,
  SendMessageOnSpawn = false,
  Message = "Enemy convoy at $cordinates moving to $compassDirection Heading ($heading)",
  StartZones = {},
  EndZone = {},
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
  UnitNumber = 3
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
  if _isPrefix then
    self.StartZones = ZonesManagerService:GetZonesByPrefix(_startZones)
    --self.StartZones = { ZonesManagerService:GetRandomZoneByPrefix(_startZones) }
  else
    self.StartZones = { ZONE:New(_startZones) }
  end
  return self
end

function ConvoyService:SetRandomEndZone(_endZones, _isPrefix) 
  if _isPrefix then
    self.EndZone = ZonesManagerService:GetRandomZoneByPrefix(_endZones)
  else
    self.EndZone = { ZONE:New(_endZones) }
  end
  return self
end

function ConvoyService:SetMessageOnSpawn(_message)
  self.SendMessageOnSpawn = true
  if _message ~= nil then self.Message = _message end
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
  
  if self.SpawnOnMenuAction then
    MENU_COALITION_COMMAND:New(self.MenuCoalition, self.Command, self.MenuCoalitionObject, 
      function () 
        --SpawnConvoy:SpawnScheduled(5, 0.5)
        SpawnConvoy:Spawn() 
      end
    )
  end
  return SpawnConvoy
end

function ConvoyService:Spawn()
  self:InitGroupByFilters()
  local SpawnConvoy = self:GetSpawnObject()
  
  if self.SpawnOnMenuAction then
    MENU_COALITION_COMMAND:New(self.MenuCoalition, self.Command, self.MenuCoalitionObject, 
      function () 
        --SpawnConvoy:SpawnScheduled(5, 0.5)
        SpawnConvoy:Spawn() 
      end
    )
  else
        --SpawnConvoy:SpawnScheduled(5, 0.5)
  SpawnConvoy:Spawn() 
  end
end 

function ConvoyService:GetSpawnObject()
  local GroundOrgZones = {}
  
  for zoneId, zone in pairs(self.StartZones) do
     table.insert(GroundOrgZones, zone)
  end
  
  local unitSpawn = SPAWN:New( self.Groups[1] )
    :InitLimit(self.UnitNumber,self.UnitNumber)
    --:InitGrouping(self.UnitNumber)
  
  if table.getn(self.Groups) > 1 then
    unitSpawn:InitRandomizeTemplate(self.Groups)
  end
  
  unitSpawn
    :InitRandomizeRoute( 1, 1, 200 ) 
    --:InitRandomizePosition(1000, 10)
    :InitRandomizeUnits(true, 2000, 300)
    :InitRandomizeZones( GroundOrgZones )
    :OnSpawnGroup(
      function(SpawnGroup)
        env.info("Convoy " .. SpawnGroup.GroupName .. " Spawned")
        SpawnGroup:TaskRouteToZone(self.EndZone,true,150,"On Road")
        local aaAlert = false;
        for i,u in pairs(SpawnGroup:GetUnits()) do
          if u:GetDCSObject():getAttributes()["Air Defence"] ~= nil then
            aaAlert = true
          end
        end
        
        if self.SendMessageOnSpawn then
          local vec2Start = SpawnGroup:GetPointVec2()
          local direction = SpawnGroup:GetPointVec3():GetDirectionVec3(self.EndZone:GetCoordinate())
          local azimuth = SpawnGroup:GetPointVec3():GetAngleDegrees(direction)
          local compass_brackets = {"N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"}
          local compass_lookup = math.floor(azimuth / 45) + 1
          local compass_direction = compass_brackets[compass_lookup]
          if compass_direction == nil then compass_direction = "" end
          azimuth = math.floor(azimuth)
          if string.len(azimuth) == 2 then azimuth = "0" .. azimuth end
          if string.len(azimuth) == 1 then azimuth = "00" .. azimuth end
          
          --local message = "Enemy convoy at " .. vec2Start:ToStringLLDDM(nil) .. " moving to " .. compass_direction .. " Heading (" .. azimuth .. ")"
          
          self.Message = self.Message:gsub( "$cordinates", vec2Start:ToStringLLDDM(nil) )
          self.Message = self.Message:gsub( "$compassDirection", compass_direction )
          self.Message = self.Message:gsub( "$heading", azimuth )
          
          if aaAlert then
            self.Message = self.Message .. " - Possible anti-aircraft threat in the area"
          end
          
          MESSAGE:New(self.Message, 10):ToBlue()
          
          if self.SpawnOnMenuAction then
           
            MENU_COALITION_COMMAND:New(self.MenuCoalition, "Delete convoy " .. SpawnGroup.GroupName, self.MenuCoalitionObject, 
              function(removeMenu)
                SpawnGroup:Destroy(true)
                env.info("Convoy " .. self.Groups.GroupName .. " Removed")
                local masterObject = SCHEDULER:New(self.MenuCoalitionObject:GetMenu("Delete convoy " .. SpawnGroup.GroupName))
                masterObject:Schedule(self.MenuCoalitionObject:GetMenu("Delete convoy " .. SpawnGroup.GroupName),
                  function (mo, commandMenu) 
                    commandMenu:Remove()
                  end
                , {self.MenuCoalitionObject:GetMenu("Delete convoy " .. SpawnGroup.GroupName)}, .5)
                env.info("Remove command deleted")
              end)
          end
        end
      end
  )
  return unitSpawn
end
