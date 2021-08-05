--
-- Use rotary switch to select a track.
-- The rotary switch needs to be configured 'relative' mode,
-- to send a value <= 64 when turned counter-clock wise,
-- and a value > 64 when turned clock wise.
--

function getDirection ()
  is_new_value, filename, sectionID, cmdID, mode, resolution, val = reaper.get_action_context()
  return (val - 64 > 0) and 1 or -1
end

direction = getDirection()
tracks = reaper.CountTracks()
current = reaper.GetSelectedTrack(0, 0);

if (tracks > 0) then

  if (current) then
    reaper.SetTrackSelected(current, false);
    currentIndex = reaper.GetMediaTrackInfo_Value(current, "IP_TRACKNUMBER") - 1;
    selectedIndex = (tracks + currentIndex + direction) % tracks;
  else
    selectedIndex = (direction > 0) and 0 or (tracks - 1)
  end

  selected = reaper.GetTrack(0, selectedIndex);

  if (selected) then
    if (current) then
        reaper.SetTrackSelected(current, false);
    end
    reaper.SetTrackSelected(selected, true);
  end
  
end

