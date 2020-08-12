-- This routine is called from the LDT environment to create the MDS_Framework.lua file stub for use in .miz files.

local MDS_FrameworkDevelopmentPath = arg[1]
local MDS_FrameworkSetupPath = arg[2]
local MDS_FrameworkTargetPath = arg[3]

print( "MDS_Framework development path    : " .. MDS_FrameworkDevelopmentPath )
print( "MDS_Framework setup path          : " .. MDS_FrameworkSetupPath )
print( "MDS_Framework target path         : " .. MDS_FrameworkTargetPath )

local MDS_FrameworkModulesFilePath =  MDS_FrameworkDevelopmentPath .. "/Modules.lua"
local LoaderFilePath = MDS_FrameworkTargetPath .. "/MDS_Framework.lua"

print( "Reading MDS_Framework source list : " .. MDS_FrameworkModulesFilePath )

local LoaderFile = io.open( LoaderFilePath, "w" )

local MDS_FrameworkSourcesFile = io.open( MDS_FrameworkModulesFilePath, "r" )
local MDS_FrameworkSource = MDS_FrameworkSourcesFile:read("*l")

while( MDS_FrameworkSource ) do
  if MDS_FrameworkSource ~= "" then
    MDS_FrameworkSource = string.match( MDS_FrameworkSource, "Scripts/(.+)'" )
    local MDS_FrameworkFilePath = MDS_FrameworkDevelopmentPath .. "/" .. MDS_FrameworkSource
      print( "MDS_FrameworkSource : " .. MDS_FrameworkFilePath )
      local MDS_FrameworkSourceFile = io.open( MDS_FrameworkFilePath, "r" )
      local MDS_FrameworkSourceFileText = MDS_FrameworkSourceFile:read( "*a" )
      MDS_FrameworkSourceFile:close()
      
      LoaderFile:write( MDS_FrameworkSourceFileText )
  end
  
  MDS_FrameworkSource = MDS_FrameworkSourcesFile:read("*l")
end

MDS_FrameworkSourcesFile:close()
LoaderFile:close()
