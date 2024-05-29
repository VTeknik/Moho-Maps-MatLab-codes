clear all
clc
close all

%--Reads all Data types in the template of the TrainingDatain.oO of Geosoft
flist = (struct2cell(dir('D:\V\MEdata\ML\*.XYZ'))); % list of the files of data with .shp format
disp('List of Data input names:');
% Lists all availble files to choose
for i =1:length(flist(1,1:end))
disp(flist(1,i));
end
%--------------------------------------------------------------------------

%---------------select a input and import it-------------------------------
inputfilename = input('input the name from above list(fullname with.XYZ):  ', 's');
PathName = 'D:\V\MEdata\ML\';
fnm = fullfile(PathName,inputfilename);
% If you change the format iof input file you may nead to 
% create sperate import function
TrainingDatain  = importfile_CTtrainingv20220713(fnm);
% Removes unexpected last column
% TrainingDatain = removevars(TrainingDatain, 'VarName13');
%--------------------------------------------------------------------------






% following codes try to convert number to labels based on introduced range
% of step_dnir
min_moho= min(TrainingDatain.moho);max_moho = max(TrainingDatain.moho);
step_moho = linspace(min_moho,max_moho,16);
moho_lable = table(cell(size(TrainingDatain.moho)),'VariableName',{'lbl'});
% combine the lable table with original table
TrainingDatain = [TrainingDatain,moho_lable];

% Create lable to moho value from min to max  lable L1, L2,....
for i =1:length(step_moho)-1
if (i == length(step_moho)-1)
LablesArray(i) = cellstr(['L' int2str(100+i)]); % Creats lable array
else
LablesArray(i) = cellstr(['L' int2str(100+i)]); % Creats lable array
end
end

% Assiign labal to density value from min to max in 9 lable L1, L2,....
for i =1:length(LablesArray)
if (i == length(LablesArray))
TrainingDatain.lbl...
    (step_moho(i)<TrainingDatain.moho )= LablesArray(i);
else
  TrainingDatain.lbl...
    (step_moho(i)<=TrainingDatain.moho & TrainingDatain.moho<step_moho(i+1))=LablesArray(i); 
end
end
% convert lable to categorical type

TrainingDatain_moho =TrainingDatain; %Keep this version to be used in the ApplyTrainedModel script
TrainingDatain = removevars(TrainingDatain, 'moho');
TrainingDatain.lbl = cellstr(TrainingDatain.lbl);
TrainingDatain.lbl = categorical(TrainingDatain.lbl);
%-------------------------------------------------------------------------------------

% below codee for check lable and value of Moho to see is correct or not
TrainingDatain_moho.moho(strcmp(TrainingDatain_moho.lbl,'L110' ))
