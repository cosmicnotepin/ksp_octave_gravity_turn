function toKOSJson(filename, numbers)
    fid = fopen(filename, "w"); 
    fdisp(fid, "{");
    fdisp(fid, "\"items\": [");
    tnumbers = numbers';
    for number = tnumbers(1:end-1)
        fdisp(fid, "{"); 
        fdisp(fid, ["\"value\": " num2str(number) ","]);
        fdisp(fid, "\"$type\": \"kOS.Safe.Encapsulation.ScalarDoubleValue\"");
        fdisp(fid, "},"); 
    end
    fdisp(fid, "{"); 
    fdisp(fid, ["\"value\": " num2str(tnumbers(end)) ","]);
    fdisp(fid, "\"$type\": \"kOS.Safe.Encapsulation.ScalarDoubleValue\"");
    fdisp(fid, "}"); 

    fdisp(fid, "],");
    fdisp(fid, "\"$type\": \"kOS.Safe.Encapsulation.ListValue\"");
    fdisp(fid, "}");
    fclose(fid);
