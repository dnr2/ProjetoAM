function data = readdata(filename)

switch filename
    case 'att_faces'
        data = readattfaces;
    case 'mnistdigits'
        data = readmnistdigits;
    case 'binaryalphabet'
        data = readbinaryalphabet;
    case 'coil20'
        data = readcoil20;
    otherwise
        data = [];
        display('Invalid file name!')
end

end