% GameData/RealSolarSystem/RSSKopernicus/Earth/Earth.cfg
function pressure = getAtmoTemp(alt) 
    alts = [ 0     8000  15000 21000 30000 42000 49750 60000 75000 91000 100000 110000 120000 140000];
    temps = [ 282.5 240.5 212   214   228   255.5 268   247.5 209   191.75 206   256   375   560 ];
    
    if (alt > 140000)
        pressure = 560;
        return;
    end
    
    for index = 1:numel(alts)
        if (alts(index) > alt)
            pressure = temps(index);
            return;
        end
    end
end
