--
-- This script sets up hit detection with ReaGate to transcribe hits into MIDI notes
-- 

-- The track to detect hits needs to be selected
selected = reaper.GetSelectedTrack(0, 0)

if selected then

  -- Insert a new track to record MIDI notes
  indexToInsert = reaper.GetMediaTrackInfo_Value(selected, "IP_TRACKNUMBER")
  reaper.InsertTrackAtIndex(indexToInsert, false)
  inserted = reaper.GetTrack(indexToInsert, indexToInsert)

  -- Name the new track as "MIDI <original track name>"
  success, selectedName = reaper.GetSetMediaTrackInfo_String(selected, "P_NAME", "", false)
  insertedName = "MIDI " .. selectedName
  reaper.GetSetMediaTrackInfo_String(inserted, "P_NAME", insertedName, true)

  -- Insert ReaGate to the selected track
  fxIndex = reaper.TrackFX_AddByName(selected, "ReaGate", false, -1)
  -- Check "Send MIDI on open/close"
  reaper.TrackFX_SetParam(selected, fxIndex, 15, 1.0)

  -- Set up a send from the selected track to the newly created track
  sendIndex = reaper.CreateTrackSend(selected, inserted)
  -- Send no audio
  reaper.SetTrackSendInfo_Value(selected, 0, sendIndex, "I_SRCCHAN", -1)

  -- Record the output MIDI and arm the track for recording
  reaper.SetMediaTrackInfo_Value(inserted, "I_RECMODE", 4.0)
  reaper.SetMediaTrackInfo_Value(inserted, "I_RECARM", 1.0)

end

-- The following was to used to find the parameter name and index
-- reaper.TrackFX_GetParamName(selected, fxIndex, 15, "")
-- {true, "Usemidi"}

