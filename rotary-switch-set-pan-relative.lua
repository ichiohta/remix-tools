--
-- Use rotary switch to adjust pan of the selected tracks.
-- The rotary switch needs to be configured 'relative' mode,
-- to send a value <= 64 when turned counter-clock wise,
-- and a value > 64 when turned clock wise.
--

function getDirection ()
    is_new_value, filename, sectionID, cmdID, mode, resolution, val = reaper.get_action_context()
    return (val - 64 > 0) and 1 or -1
end
  
countSelected = reaper.CountSelectedTracks(0);

for i = 0,(countSelected - 1) do

    current = reaper.GetSelectedTrack(0, i);

    pan = reaper.GetMediaTrackInfo_Value(current, "D_PAN");
    pan = pan + getDirection() * 0.01;
    pan = (pan < -1.0) and -1.0 or ((pan > 1.0) and 1.0 or pan);

    reaper.SetMediaTrackInfo_Value(current, "D_PAN", pan);

end

