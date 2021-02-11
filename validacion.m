close all; clc; clear all;

experimento = 4;%,4,5
q = 13; %13, 9;


ClassHitF = load(['Data\data_',num2str(experimento),'\exp',num2str(q),'.mat'],'mejor_FIS_validacion');
ClassHitF = ClassHitF.mejor_FIS_validacion(1,q);
%parcial = readfis('ClassHITF');

inputs = readtable(['Base de datos\spotify_pro_4.csv']);
%inputs = readtable(['spotify_pro.csv']);
inputs2 = inputs(:,2:5);
inputs2 = inputs2{:,:};
inputs2 = normalize(inputs2,'range'); 

fprintf('Experimentos ok \n');  
%%
s = evalfis(ClassHitF,inputs2);
fprintf('Evalfis ok \n');  
%%
x = linspace(1,length(s(:,1)),length(s(:,1)));
y = s(:,1);
plot(x,y,'.');
hold on
legend('no hit','hit')  
axis([0 length(s(:,1)) 0 1])
csvwrite(['Salida.csv'],s);
fprintf('csv ok \n');    
%%
