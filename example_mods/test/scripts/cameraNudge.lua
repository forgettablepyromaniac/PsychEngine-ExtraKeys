--CAMERA NUDGE V3, BY ORSONSTER--
cameraOffsetX = 0
cameraOffsetY = 0

songStarted = false

local intensity = 30

local offsets = {}

function onCreatePost()
   if mania == 3 then
      offsets = {
         { -1,  0 },  -- noteDirection 0
         {  0,  1 },  -- noteDirection 1
         {  0, -1 },  -- noteDirection 2
         {  1,  0 }   -- noteDirection 3
      }
   elseif mania == 5 then
      offsets = {
         { -1,  0 },  -- noteDirection 0
         {  0, -1 },  -- noteDirection 1
         {  1,  0 },  -- noteDirection 2
         { -1,  0 },  -- noteDirection 3
         {  0,  1 },  -- noteDirection 4
         {  1,  0 }   -- noteDirection 5
      }
   elseif mania == 8 then
      offsets = {
         { -1,  0 },  -- noteDirection 0
         {  0,  1 },  -- noteDirection 1
         {  0, -1 },  -- noteDirection 2
         {  1,  0 },  -- noteDirection 3
         {  0,  0 },  -- noteDirection 4
         { -1,  0 },  -- noteDirection 5
         {  0,  1 },  -- noteDirection 6
         {  0, -1 },  -- noteDirection 7
         {  1,  0 }   -- noteDirection 8
      }
   end
end

function goodNoteHit(noteID, noteDirection, noteType, isSustain)
   if offsets[noteDirection + 1] then
      cameraOffsetX = offsets[noteDirection + 1][1] * intensity
      cameraOffsetY = offsets[noteDirection + 1][2] * intensity
   end
end

function opponentNoteHit(noteID, noteDirection, noteType, isSustain)
   if offsets[noteDirection + 1] then
      cameraOffsetX = offsets[noteDirection + 1][1] * intensity
      cameraOffsetY = offsets[noteDirection + 1][2] * intensity
   end
end

function onSongStart()
   songStarted = true
end

function onUpdatePost(elapsed)
   if not songStarted then
      return
   end

   cameraOffsetX = cameraOffsetX + ((0 - cameraOffsetX) / 80)
   cameraOffsetY = cameraOffsetY + ((0 - cameraOffsetY) / 80)
   if mustHitSection then
      setProperty("camFollow.x", (((getMidpointX("boyfriend") - 100) - (getProperty("boyfriend.cameraPosition[0]") - getProperty("boyfriendCameraOffset[0]"))) + cameraOffsetX))
      setProperty("camFollow.y", (((getMidpointY("boyfriend") - 100) + (getProperty("boyfriend.cameraPosition[1]") + getProperty("boyfriendCameraOffset[1]"))) + cameraOffsetY))
   elseif gfSection then
      setProperty("camFollow.x", (getMidpointX("gf")) + getProperty("gf.cameraPosition[0]") + getProperty("gfCameraOffset[0]") + cameraOffsetX)
      setProperty("camFollow.y", (getMidpointY("gf")) + getProperty("gf.cameraPosition[1]") + getProperty("gfCameraOffset[1]") + cameraOffsetY)
   else
      setProperty("camFollow.x", (getMidpointX("dad") + 150) + getProperty("dad.cameraPosition[0]") + getProperty("opponentCameraOffset[0]") + cameraOffsetX)
      setProperty("camFollow.y", (getMidpointY("dad") - 100) + getProperty("dad.cameraPosition[1]") + getProperty("opponentCameraOffset[1]") + cameraOffsetY)
   end
end