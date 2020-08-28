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