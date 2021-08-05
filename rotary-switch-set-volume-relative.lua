--
-- Use rotary switch to adjust volume of the selected tracks.
-- The rotary switch needs to be configured 'relative' mode,
-- to send a value <= 64 when turned counter-clock wise,
-- and a value > 64 when turned clock wise.
--

function getDirection ()
    is_new_value, filename, sectionID, cmdID, mode, resolution, val = reaper.get_action_context()
    return (val - 64 > 0) and 1 or -1
end
  
function VAL2DB (x)
    if (x < 2.9802322387695e-008) then
        return -150.0;
    end
    v = math.log(x) * 20 / math.log(10);
    return (v < -150.0) and -150.0 or v;
end

function DB2VAL (x)
  return math.exp(x * math.log(10) / 20);
end

countSelected = reaper.CountSelectedTracks(0);

for i = 0,(countSelected - 1) do

    current = reaper.GetSelectedTrack(0, i);

    vol = reaper.GetMediaTrackInfo_Value(current, "D_VOL");
    db = VAL2DB(vol);
    slider = math.floor(reaper.DB2SLIDER(db)) + getDirection() * 5;
    slider = (slider < 0.0) and 0.0 or ((slider > 1000.0 and 1000.0 or slider));
    db = reaper.SLIDER2DB(slider);
    vol = DB2VAL(db);

    reaper.SetMediaTrackInfo_Value(current, "D_VOL", vol);

end

