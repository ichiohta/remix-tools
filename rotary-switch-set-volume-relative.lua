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

current = reaper.GetSelectedTrack(0, 0);

if (current) then

    vol = reaper.GetMediaTrackInfo_Value(current, "D_VOL");
    db = VAL2DB(vol);
    slider = math.floor(reaper.DB2SLIDER(db));

    inc = getDirection() * 5;
    slider = slider + getDirection() * 5;

    slider = (slider < 0.0) and 0.0 or ((slider > 1000.0 and 1000.0 or slider));
    db = reaper.SLIDER2DB(slider);
    vol = DB2VAL(db);

    reaper.SetMediaTrackInfo_Value(current, "D_VOL", vol);

end
