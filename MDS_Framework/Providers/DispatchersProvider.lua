--Based on Configuration.lua and pre-generated Database
DispatchersProvider = {
  ClassName = "DispatchersProvider"
}


function DispatchersProvider:Init() 
  local dispatchers = Configuration.Dispatchers
  
  for coalitionId, coalition in pairs(dispatchers) do
    if Configuration.Settings.Flags.Dispatchers[coalitionId] then
      for nationId, nation in pairs(coalition) do
        if Configuration.Settings.Flags.Dispatchers[coalitionId .. "_" .. nationId] then
          for dispatcherId, dispatcher in ipairs(nation) do
            if Configuration.Settings.Flags.Dispatchers[coalitionId .. "_" .. nationId .. "_" .. dispatcher.DispatcherType] and dispatcher.DispatcherType == Dispatcher.AG then  
              local prefix = coalitionId .. "_" .. nationId .. "_"
              local dispatcherOptions = DispatchersProvider:InitA2GDispatcherOptions(prefix,dispatcher)
              
              local MissionsOptions = {} 
              for unitId, unit in pairs(dispatcher.Units) do
                local option = DispatchersProvider:InitAGSquadronOption(coalitionId, nationId, dispatcher.DispatcherType, unitId, unit)
                
                if option ~= nil then
                  option:SetTakeoffMode(dispatcher.TakeoffMode)
                    :SetLandMode(dispatcher.LandMode)
                    :SetTakeoffIntervall(dispatcher.TakeoffIntervall)
                    
                  table.insert(MissionsOptions, option)
                end
              end
              
              local A2GDispatcherInitializator = A2GDispatcherInitializator:New(dispatcherOptions)
                :SetSquadronsOptions(MissionsOptions)
                :Init()
            elseif Configuration.Settings.Flags.Dispatchers[coalitionId .. "_" .. nationId .. "_" .. dispatcher.DispatcherType] and dispatcher.DispatcherType == Dispatcher.AA then
              local prefix = coalitionId .. "_" .. nationId .. "_"
              local dispatcherOptions = DispatchersProvider:InitA2ADispatcherOptions(prefix,dispatcher)
              
              local MissionsOptions = {} 
              for unitId, unit in pairs(dispatcher.Units) do
                local option = DispatchersProvider:InitAASquadronOption(coalitionId, nationId, dispatcher.DispatcherType, unitId, unit)
                
                if option ~= nil then
                  option:SetTakeoffMode(dispatcher.TakeoffMode)
                    :SetLandMode(dispatcher.LandMode)
                    :SetTakeoffIntervall(dispatcher.TakeoffIntervall)
                    
                  table.insert(MissionsOptions, option)
                end
              end
              
              local A2ADispatcherInitializator = A2ADispatcherInitializator:New(dispatcherOptions)
                :SetSquadronsOptions(MissionsOptions)
                :Init()
            end
          end
        end
      end
    end
  end
  
  
end

function DispatchersProvider:InitA2GDispatcherOptions(prefix, dispatcher)
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


function DispatchersProvider:InitA2ADispatcherOptions(prefix, dispatcher)
  local _result = A2ADispatcherOptions:New()
            :SetEngageRadius(dispatcher.EngageRadius)
            :SetInterceptDelay(dispatcher.InterceptDelay)
            :SetTacticalDisplay(dispatcher.TacticalDisplay)
  for i, group in ipairs(dispatcher.DetectionGroups) do
    _result:SetDetectionGroups(prefix .. group.Name, group.isPrefix)
  end
  for i, group in ipairs(dispatcher.CAPZones) do
    _result:SetCAPZones(prefix .. group.Name, group.isPrefix)
  end
  return _result
end

function DispatchersProvider:InitAGSquadronOption(_coalition, faction,  _dispatcherType, unitId, unit)
  --recupero i template in base all'unita ed alla missione
--  local template = MDSDatabase:New():GetTemplates()[_coalition].Factions[faction].Units[unitId]

--  if template ~= nil and Configuration.Settings.Era >= tonumber(template.Era[1]) and Configuration.Settings.Era <= tonumber(template.Era[2]) then
    for missionId, mission in pairs(unit.Missions) do
      if  Configuration.Settings.Flags.Dispatchers[_coalition .. "_" .. faction .. "_" .. _dispatcherType .. "_" .. unitId .. "_" .. missionId]  then
        local templates = MDSDatabase:New()
          :FilterCoalition(coalition.side[_coalition])
          :FilterFactions({ country.name[faction] })
          :FilterUnitNames({ unitId })
          :FilterMissions({ missionId })
          :FilterEra(Configuration.Settings.Era)
          :FilterStart()
          :GetFilterResult()
        local option =  SquadronsOptions:New()
                :SetAttackAltitude(mission.AttackAltitude)
                :SetAttackSpeed(mission.AttackSpeed)
                :SetOverhead(mission.Overhead)
                :SetAirbaseResourceMode(mission.AirbaseResourceMode)
                :SetMissions(missionId)
                :SetResourceCount(mission.ResourceCount)
                :SetTemplates(templates)
                
          for i, group in ipairs(unit.Airbases) do
            option:SetAirbases( _coalition .. "_" .. faction .. "_" .. group.Name, group.isPrefix)
          end  
          
         
                
          return option
        end
      end
--    end
  return nil
end

function DispatchersProvider:InitAASquadronOption(_coalition, faction, _dispatcherType, unitId, unit)
  --recupero i template in base all'unita ed alla missione
--  local template = MDSDatabase:New():GetTemplates()[_coalition].Factions[faction].Units[unitId]
    
--  if template ~= nil and Configuration.Settings.Era >= tonumber(template.Era[1]) and Configuration.Settings.Era <= tonumber(template.Era[2]) then   
  for missionId, mission in pairs(unit.Missions) do
    if  Configuration.Settings.Flags.Dispatchers[_coalition .. "_" .. faction .. "_" .. _dispatcherType .. "_" .. unitId .. "_" .. missionId]  then
      local templates = MDSDatabase:New()
          :FilterCoalition(coalition.side[_coalition])
          :FilterFactions({ country.name[faction] })
          :FilterUnitNames({ unitId })
          :FilterMissions({ missionId })
          :FilterEra(Configuration.Settings.Era)
          :FilterStart()
          :GetFilterResult()
      local option =  SquadronsOptions:New()
              :SetAttackAltitude(mission.AttackAltitude)
              :SetAttackSpeed(mission.AttackSpeed)
              :SetOverhead(mission.Overhead)
              :SetAirbaseResourceMode(mission.AirbaseResourceMode)
              :SetMissions(missionId)
              :SetResourceCount(mission.ResourceCount)
              :SetTemplates(templates)
              :SetCapLimit(mission.CapLimit)
              :SetLowInterval(mission.LowInterval)
              :SetHighInterval(mission.HighInterval)
              :SetProbability(mission.Probability)
              :SetFuelThreshold(mission.FuelThreshold)
              
        for i, group in ipairs(unit.Airbases) do
          option:SetAirbases(  _coalition .. "_" .. faction .. "_" .. group.Name, group.isPrefix)
        end    
        return option
      end
    end
  --end
  return nil
end