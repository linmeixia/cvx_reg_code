function Installmex(recompile)
if (nargin == 0); recompile = 0; end
computer_model = computer;
matlabversion = sscanf(version,'%f');
matlabversion = matlabversion(1);
tmp = version('-release');
matlabrelease = str2num(tmp(1:4));
%%
mexcmd = 'mex -O  -largeArrayDims  -output ';
%%
if (matlabversion < 9.5)  && (matlabrelease <= 2017)
    error(' needs MATLAB version 9.5 and above');
end
fsp = filesep;
libstr = [];
%%
curdir = pwd;
fprintf(' current directory is:  %s\n',curdir);
%%
%% generate mex files in mexfun
%%
clear fname
scr = [curdir,fsp,'mexfun'];
eval(['cd ','solvers']);
eval(['cd ','mexfun']);
fprintf('\n Now compiling the mexFunctions in:\n');
fprintf(' %s\n',scr);
%%
fname{1} = 'mexbwsolve';
fname{2} = 'mexfwsolve';
fname{3} = 'mextriang';
fname{4} = 'mexsumsum';

existfile = zeros(1,length(fname));
for k = 1:length(fname)
    existfile(k) = exist([fname{k},'.',mexext]);
end
for k = 1:length(fname)
    if recompile || ~existfile(k)
        cmd([mexcmd,fname{k},'  ',fname{k},'.c  ',libstr]);
    end
end
fprintf ('\n Compilation of mexFunctions completed.\n');
cd ..
cd ..
end

function cmd(s)
fprintf(' %s\n',s);
eval(s);
end
