clc; clear all; close all;

experimento = 2;

for q=1:1:15
    fprintf('Cargando los datos del experimento %d \n',q);
    data(q) = load(['Data\data_',num2str(experimento),'\exp',num2str(q),'.mat'],'semax','vs0','vsf');
end 
 
 for q=17:1:21
    fprintf('Cargando los datos del experimento %d \n',q);
    data(q) = load(['Data\data_',num2str(experimento),'\exp',num2str(q),'.mat'],'semax','vs0','vsf');
 end 
 
 
 %data_min =cell2mat (struct2cell(data));
 
 %semax=min(data); 
 
 %semax=max(max(curvas_error)); % máximo error de validación S