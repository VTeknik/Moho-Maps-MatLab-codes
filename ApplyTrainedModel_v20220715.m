

%---------------loads all dataset of prediction files----------------------
PPDatain = importfile_CTpredictionv20220713('D:\V\MEdata\ML\CT_prediction_v20220713.XYZ');
% PPDatain = removevars(PPDatain, 'm_mohobg');
% PPDatain = removevars(PPDatain, 'i_mohobg');


%------------------Output the prediction iron----------------------------
Predictions  = trainedModel_v20220715.predictFcn(PPDatain);
xm = PPDatain(:,1); ym = PPDatain(:,2);  
name = table(Predictions);
% ========convert lablls to Moho values
for i =1:length(step_moho)-1
avg_moho(i) = mean([step_moho(i) step_moho(i+1)]);
end

u_per = (unique(name)); %List L1 t0 L9

u_per =table(LablesArray');
dataout = [];
for i = 1:length(u_per.Var1)
   ind = find(name.Predictions ==  u_per.Var1(i));
  A = xm.long(ind);
  B = ym.lat(ind);
  C = string(name.Predictions(ind));
  D = repmat(avg_moho(i),length(ind),1);
  
   avg_moho_ind = [A B C D];
  dataout = [avg_moho_ind;dataout];
end


%==========================================
%-------------- to already expoted results
flist = (struct2cell(dir('D:\V\MEdata\ML\DataoutML\*.txt'))); % list of the files of data with .shp format
disp('List of exported predictions:');
% Lists all availble files to choose
for i =1:length(flist(1,1:end))
disp(flist(1,i));
end


%--------------Export the prediction model
dataout_tbl = array2table(dataout,'VariableNames',{'long','lat','lbl','pred_moho'});
PathName = 'D:\V\MEdata\ML\DataoutML\';
outfilename= input('input the name of output file:  ', 's');
fnm = fullfile(PathName,outfilename);
writetable(dataout_tbl,fnm ,'Delimiter','tab')



