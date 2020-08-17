--Based on Configuration.lua and pre-generated Database
AIA2GProvider = {
  ClassName = "AIA2GProvider"
}


function AIA2GProvider:Init() 
  local dispatchers = Configuration.Dispatchers
  
  for coalitionId, coalition in pairs(dispatchers) do
    for nationId, nation in pairs(coalition) do
      if nation.Active and nation.DispatcherType == Dispatcher.AG then  
        local prefix = coalitionId .. "_" .. nationId .. "_"
        local dispatcherOptions = AIA2GProvider:InitA2GDispatcherOptions(prefix,nation)
        
        local MissionsOptions = {} 
        for unitId, unit in pairs(nation.Units) do
          local option = AIA2GProvider:InitSquadronOption(coalitionId, nationId, unitId, unit)
          
          if option ~= nil then
            option:SetTakeoffMode(unit.TakeoffMode)
              :SetLandMode(unit.LandMode)
              :SetTakeoffIntervall(unit.TakeoffIntervall)
              
            table.insert(MissionsOptions, option)
          end
        end
        
        local A2GDispatcherInitializator = A2GDispatcherInitializator:New(dispatcherOptions)
          :SetSquadronsOptions(MissionsOptions)
          :Init()
      end
    end
  end
  
  
end

function AIA2GProvider:InitA2GDispatcherOptions(prefix, dispatcher)
  local _result = A2GDispatcherOptions:New()
            :SetCommandCenter(prefix .. dispatcher.CommandCenter)
            :SetDetectionArea(dispatcher.DetectionArea)
            :SetDefenseRadious(dispatcher.DefenseRadious)
            :SetReactivity(dispatcher.Reactivity)
            :SetTacticalDisplay(dispatcher.TacticalDisplay)
  for i, group in ipairs(dispatcher.DetectionGroups) do
    _result:SetDetectionGroups(prefix .. group.Name, group.isPrefix)
  end
  for i, group in ipairs(dispatcher.DefenceCoordinates) do
    _result:SetDefenceCoordinates(prefix .. group.Name, group.isPrefix)
  end
  return _result
end

function AIA2GProvider:InitSquadronOption(coalition, faction, unitId, unit)
  --recupero i template in base all'unita ed alla missione
  local template = MDSDatabase:New():GetTemplates()[coalition].Factions[faction].Units[unitId]
    
  if template ~= nil and Configuration.Settings.Era >= tonumber(template.Era[1]) and Configuration.Settings.Era <= tonumber(template.Era[2]) then   
  for missionId, mission in pairs(unit.Missions) do
    if mission.Active then
     
      local option =  SquadronsOptions:New()
              :SetAttackAltitude(mission.AttackAltitude)
              :SetAttackSpeed(mission.AttackSpeed)
              :SetOverhead(mission.Overhead)
              :SetAirbaseResourceMode(mission.AirbaseResourceMode)
              :SetMissions(missionId)
              :SetResourceCount(mission.ResourceCount)
              :SetTemplates(template.Missions[missionId].Templates)
              
        for i, group in ipairs(unit.Airbases) do
          option:SetAirbases( coalition .. "_" .. faction .. "_" .. group.Name, group.isPrefix)
        end  
        
       
              
        return option
      end
    end
  end
  return nil
end

