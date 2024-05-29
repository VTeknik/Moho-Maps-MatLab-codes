
a = TrainingDatain;


mdl = fscnca(table2array(a(:,1:11)),table2array(a(:,14)));
figure(1)
plot(mdl.FeatureWeights,'ro')
xlabel('Feature Index')
ylabel('Feature Weight')
grid on

% For algoritim see help of Matlab
[idx,weights] = relieff( table2array(a(:,1:11)),table2array(a(:,14)),10,...
 'method','classification');
figure(2)
bar(weights(idx))
xlabel('Predictor rank')
ylabel('Predictor importance weight')
names ={'long','lat','topo','fa','bg','gxx','gxy','gxz','gyy','gyz','gzz'};
xticklabels(names(idx))


% num of each lable
for i = 1:length(LablesArray)
num(i) =length(find(TrainingDatain.lbl==LablesArray(i)));
end
lablenumber =[LablesArray' num2cell(num)'];