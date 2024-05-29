

%---------------loads all dataset of prediction files----------------------
PPDatain = importfile_CTpredictionv20220713('D:\V\MEdata\ML\CT_prediction_v20220713.XYZ');
% PPDatain = removevars(PPDatain, 'm_mohobg');
% PPDatain = removevars(PPDatain, 'i_mohobg');


%------------------Output the prediction iron----------------------------
Predictions  = trainedModel_v20220720_reg.predictFcn(PPDatain);
xm = PPDatain(:,1); ym = PPDatain(:,2);  
moho_pred = table(Predictions);
% ========convert lablls to Moho values



%==========================================
%-------------- to already expoted results
flist = (struct2cell(dir('D:\V\MEdata\ML\DataoutML\*.txt'))); % list of the files of data with .shp format
disp('List of exported predictions:');
% Lists all availble files to choose
for i =1:length(flist(1,1:end))
disp(flist(1,i));
end


xm = table2array(xm);ym = table2array(ym);moho_pred = table2array(moho_pred);

ind =isnan(moho_pred);
xm(ind)=[];ym(ind)=[];moho_pred(ind)=[];
dataout= [xm ym moho_pred];

%--------------Export the prediction model
dataout_tbl = array2table(dataout,'VariableNames',{'long','lat','pred_moho'});
PathName = 'D:\V\MEdata\ML\DataoutML\';
outfilename= input('input the name of output file:  ', 's');
fnm = fullfile(PathName,outfilename);
writetable(dataout_tbl,fnm ,'Delimiter','tab')



