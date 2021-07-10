
selected = reaper.GetSelectedTrack(0, 0)

if selected then

  selectedIndex = reaper.GetMediaTrackInfo_Value(selected, "IP_TRACKNUMBER")
  reaper.InsertTrackAtIndex(selectedIndex, false)
  inserted = reaper.GetTrack(selectedIndex, selectedIndex)
  success, selectedName = reaper.GetSetMediaTrackInfo_String(selected, "P_NAME", "", false)
  insertedName = "MIDI " .. selectedName
  reaper.GetSetMediaTrackInfo_String(inserted, "P_NAME", insertedName, true)

-- reaper.TrackFX_GetParamName(selected, fxIndex, 15, "")
-- {true, "Usemidi"}

  fxIndex = reaper.TrackFX_AddByName(selected, "ReaGate", false, -1)
  reaper.TrackFX_SetParam(selected, fxIndex, 15, 1.0)
  sendIndex = reaper.CreateTrackSend(selected, inserted)
  reaper.SetTrackSendInfo_Value(selected, 0, sendIndex, "I_SRCCHAN", -1)
  reaper.SetMediaTrackInfo_Value(inserted, "I_RECMODE", 4.0)
  reaper.SetMediaTrackInfo_Value(inserted, "I_RECARM", 1.0)

end



