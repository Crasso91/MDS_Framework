UtilitiesService = {
	ClassName = "UtilitiesService"
}

function UtilitiesService:ArrayHasValue (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function UtilitiesService:GetEnumKeyByValue(_enum, _id) 
  for k,v in pairs(_enum) do
    if k == _id then return v end 
  end
  return nil
end

function UtilitiesService:GetRandomOfUnsequncialTable(_table)
  local _random = math.random(1, UtilitiesService:Lenght(_table))
  local _count = 1
  
  for i,row in pairs(_table) do
    if _count == _random then
      return row
    else
      _count = _count + 1
    end
  end
  return nil
end

function UtilitiesService:Lenght(_table)
  local count = 0
  for k,v in pairs(_table) do
    count = count + 1
  end    
  return count
end

function UtilitiesService:LoadDependecies() 
  for k,v in pairs(Configuration.Settings.Dependecies) do
    assert(loadfile(v))()
  end
end



