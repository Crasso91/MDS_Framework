--- Will spawn a group with a specified index number.
-- Method overrided to chek coordinates assigned to previous units to prevent overlapping
-- Uses @{DATABASE} global object defined in MOOSE.
-- @param #SPAWN self
-- @param #string SpawnIndex The index of the group to be spawned.
-- @return Wrapper.Group#GROUP The group that was spawned. You can use this group for further actions.
function SPAWN:SpawnWithIndex( SpawnIndex, NoBirth )
  self:F2( { SpawnTemplatePrefix = self.SpawnTemplatePrefix, SpawnIndex = SpawnIndex, AliveUnits = self.AliveUnits, SpawnMaxGroups = self.SpawnMaxGroups } )
  
  if self:_GetSpawnIndex( SpawnIndex ) then
    
    if self.SpawnGroups[self.SpawnIndex].Visible then
      self.SpawnGroups[self.SpawnIndex].Group:Activate()
    else

      local SpawnTemplate = self.SpawnGroups[self.SpawnIndex].SpawnTemplate
      self:T( SpawnTemplate.name )

      if SpawnTemplate then

        local PointVec3 = POINT_VEC3:New( SpawnTemplate.route.points[1].x, SpawnTemplate.route.points[1].alt, SpawnTemplate.route.points[1].y )
        self:T( { "Current point of ", self.SpawnTemplatePrefix, PointVec3 } )

        -- If RandomizePosition, then Randomize the formation in the zone band, keeping the template.
        if self.SpawnRandomizePosition then
          local RandomVec2 = PointVec3:GetRandomVec2InRadius( self.SpawnRandomizePositionOuterRadius, self.SpawnRandomizePositionInnerRadius )
          local CurrentX = SpawnTemplate.units[1].x
          local CurrentY = SpawnTemplate.units[1].y
          SpawnTemplate.x = RandomVec2.x
          SpawnTemplate.y = RandomVec2.y
          for UnitID = 1, #SpawnTemplate.units do
            SpawnTemplate.units[UnitID].x = SpawnTemplate.units[UnitID].x + ( RandomVec2.x - CurrentX )
            SpawnTemplate.units[UnitID].y = SpawnTemplate.units[UnitID].y + ( RandomVec2.y - CurrentY )
            self:T( 'SpawnTemplate.units['..UnitID..'].x = ' .. SpawnTemplate.units[UnitID].x .. ', SpawnTemplate.units['..UnitID..'].y = ' .. SpawnTemplate.units[UnitID].y )
          end
        end
        
        -- If RandomizeUnits, then Randomize the formation at the start point.
        local _previousAssignedCoordinates = {}
        local _vec2AssignedPreviously = false
        if self.SpawnRandomizeUnits then
          if not self.SpawnOuterRadius or self.SpawnOuterRadius <= 0 then self.SpawnOuterRadius = 150 end 
          if not self.SpawnInnerRadius or self.SpawnInnerRadius <= 0 then self.SpawnInnerRadius = 50 end
          for UnitID = 1, #SpawnTemplate.units do
            --[[ 
              =MDS=Crasso 27/08/2020 - prevent unit overlapping by checking if distance 
              from random vec2 and all previous assigned vec2 is > then 50
            --]]
            local RandomVec2 = PointVec3:GetRandomVec2InRadius( self.SpawnOuterRadius, self.SpawnInnerRadius )
            _vec2AssignedPreviously = table.getn(_previousAssignedCoordinates) > 0
            local _innerCheck = true
            while(_vec2AssignedPreviously) do
              for i,vec in ipairs(_previousAssignedCoordinates) do
                local _previousCoordinate = COORDINATE:NewFromVec2(vec) 
                local _coordinate = COORDINATE:NewFromVec2(RandomVec2)
                local _distance = _previousCoordinate:DistanceFromPointVec2(_coordinate)
                _innerCheck = _innerCheck and _distance > self.SpawnInnerRadius
              end
              if _innerCheck then
                _vec2AssignedPreviously = false
              else
                _innerCheck = true
                RandomVec2 = PointVec3:GetRandomVec2InRadius( self.SpawnOuterRadius, self.SpawnInnerRadius )
              end
            end
            
            SpawnTemplate.units[UnitID].x = RandomVec2.x
            SpawnTemplate.units[UnitID].y = RandomVec2.y
            table.insert(_previousAssignedCoordinates, RandomVec2)
            self:T( 'SpawnTemplate.units['..UnitID..'].x = ' .. SpawnTemplate.units[UnitID].x .. ', SpawnTemplate.units['..UnitID..'].y = ' .. SpawnTemplate.units[UnitID].y )
            
          end
        end
        
        -- Get correct heading in Radians.
        local function _Heading(courseDeg)
          local h
          if courseDeg<=180 then
            h=math.rad(courseDeg)
          else
            h=-math.rad(360-courseDeg)
          end
          return h 
        end        

        local Rad180 = math.rad(180)
        local function _HeadingRad(courseRad)
          if courseRad<=Rad180 then
            return courseRad
          else
            return -((2*Rad180)-courseRad)
          end
        end        

        -- Generate a random value somewhere between two floating point values.
        local function _RandomInRange ( min, max )
          if min and max then
            return min + ( math.random()*(max-min) )
          else
            return min
          end
        end

        -- Apply InitGroupHeading rotation if requested.
        -- We do this before InitHeading unit rotation so that can take precedence
        -- NOTE: Does *not* rotate the groups route; only its initial facing.
        if self.SpawnInitGroupHeadingMin and #SpawnTemplate.units > 0 then

          local pivotX = SpawnTemplate.units[1].x -- unit #1 is the pivot point
          local pivotY = SpawnTemplate.units[1].y

          local headingRad = math.rad(_RandomInRange(self.SpawnInitGroupHeadingMin or 0,self.SpawnInitGroupHeadingMax))
          local cosHeading = math.cos(headingRad)
          local sinHeading = math.sin(headingRad)  
          
          local unitVarRad = math.rad(self.SpawnInitGroupUnitVar or 0)

          for UnitID = 1, #SpawnTemplate.units do
          
            if UnitID > 1 then -- don't rotate position of unit #1
              local unitXOff = SpawnTemplate.units[UnitID].x - pivotX -- rotate position offset around unit #1
              local unitYOff = SpawnTemplate.units[UnitID].y - pivotY

              SpawnTemplate.units[UnitID].x = pivotX + (unitXOff*cosHeading) - (unitYOff*sinHeading)
              SpawnTemplate.units[UnitID].y = pivotY + (unitYOff*cosHeading) + (unitXOff*sinHeading)
            end
            
            -- adjust heading of all units, including unit #1
            local unitHeading = SpawnTemplate.units[UnitID].heading + headingRad -- add group rotation to units default rotation
            SpawnTemplate.units[UnitID].heading = _HeadingRad(_RandomInRange(unitHeading-unitVarRad, unitHeading+unitVarRad))
            SpawnTemplate.units[UnitID].psi = -SpawnTemplate.units[UnitID].heading
            
          end

        end
        
        -- If Heading is given, point all the units towards the given Heading.  Overrides any heading set in InitGroupHeading above.
        if self.SpawnInitHeadingMin then
          for UnitID = 1, #SpawnTemplate.units do
            SpawnTemplate.units[UnitID].heading = _Heading(_RandomInRange(self.SpawnInitHeadingMin, self.SpawnInitHeadingMax))
            SpawnTemplate.units[UnitID].psi = -SpawnTemplate.units[UnitID].heading
          end
        end
        
        -- Set livery.
        if self.SpawnInitLivery then
          for UnitID = 1, #SpawnTemplate.units do
            SpawnTemplate.units[UnitID].livery_id = self.SpawnInitLivery
          end
        end

        -- Set skill.
        if self.SpawnInitSkill then
          for UnitID = 1, #SpawnTemplate.units do
            SpawnTemplate.units[UnitID].skill = self.SpawnInitSkill
          end
        end

        -- Set tail number.
        if self.SpawnInitModex then
          for UnitID = 1, #SpawnTemplate.units do
            SpawnTemplate.units[UnitID].onboard_num = string.format("%03d", self.SpawnInitModex+(UnitID-1))
          end
        end
        
        -- Set radio comms on/off.
        if self.SpawnInitRadio then
          SpawnTemplate.communication=self.SpawnInitRadio
        end        
        
        -- Set radio frequency.
        if self.SpawnInitFreq then
          SpawnTemplate.frequency=self.SpawnInitFreq
        end
        
        -- Set radio modulation.
        if self.SpawnInitModu then
          SpawnTemplate.modulation=self.SpawnInitModu
        end        
        
        -- Set country, coaliton and categroy.
        SpawnTemplate.CategoryID = self.SpawnInitCategory or SpawnTemplate.CategoryID 
        SpawnTemplate.CountryID = self.SpawnInitCountry or SpawnTemplate.CountryID 
        SpawnTemplate.CoalitionID = self.SpawnInitCoalition or SpawnTemplate.CoalitionID 
        
        
--        if SpawnTemplate.CategoryID == Group.Category.HELICOPTER or SpawnTemplate.CategoryID == Group.Category.AIRPLANE then
--          if SpawnTemplate.route.points[1].type == "TakeOffParking" then
--            SpawnTemplate.uncontrolled = self.SpawnUnControlled
--          end
--        end
      end
      
      if not NoBirth then
        self:HandleEvent( EVENTS.Birth, self._OnBirth )
      end
      self:HandleEvent( EVENTS.Dead, self._OnDeadOrCrash )
      self:HandleEvent( EVENTS.Crash, self._OnDeadOrCrash )
      self:HandleEvent( EVENTS.RemoveUnit, self._OnDeadOrCrash )
      if self.Repeat then
        self:HandleEvent( EVENTS.Takeoff, self._OnTakeOff )
        self:HandleEvent( EVENTS.Land, self._OnLand )
      end
      if self.RepeatOnEngineShutDown then
        self:HandleEvent( EVENTS.EngineShutdown, self._OnEngineShutDown )
      end

      self.SpawnGroups[self.SpawnIndex].Group = _DATABASE:Spawn( SpawnTemplate )
      
      local SpawnGroup = self.SpawnGroups[self.SpawnIndex].Group -- Wrapper.Group#GROUP
      
      --TODO: Need to check if this function doesn't need to be scheduled, as the group may not be immediately there!
      if SpawnGroup then
      
        SpawnGroup:SetAIOnOff( self.AIOnOff )
      end

      self:T3( SpawnTemplate.name )
      
      -- If there is a SpawnFunction hook defined, call it.
      if self.SpawnFunctionHook then
        -- delay calling this for .1 seconds so that it hopefully comes after the BIRTH event of the group.
        self.SpawnHookScheduler:Schedule( nil, self.SpawnFunctionHook, { self.SpawnGroups[self.SpawnIndex].Group, unpack( self.SpawnFunctionArguments)}, 0.1 )
      end
      -- TODO: Need to fix this by putting an "R" in the name of the group when the group repeats.
      --if self.Repeat then
      --  _DATABASE:SetStatusGroup( SpawnTemplate.name, "ReSpawn" )
      --end
    end
    
    
    self.SpawnGroups[self.SpawnIndex].Spawned = true
    return self.SpawnGroups[self.SpawnIndex].Group
  else
    --self:E( { self.SpawnTemplatePrefix, "No more Groups to Spawn:", SpawnIndex, self.SpawnMaxGroups } )
  end

  return nil
end
