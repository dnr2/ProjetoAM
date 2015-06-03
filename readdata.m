function data = readdata(filename)

if strcmp(filename, 'att_faces')
    data = readattfaces;
elseif strcmp(filename, 'mnistdigits')
    % data = readmnistdigits; % Coding it now
elseif strcmp(filename, 'binaryalphabet')
    data = readbinaryalphabet;
elseif strcmp(filename, 'coil20')
    data = readcoil20;
else
    data = [];
    display('Invalid file name!');
end

end