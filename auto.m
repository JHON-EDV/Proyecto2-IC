%Auto de entranamiento con datos de entrada en .mat
%rng('shuffle');

clear all;close all; clc;
warning('off','all');

load('entrada.mat');
L = length(data);

 for q=17:1:L
    fprintf('El numero del experimento es %d',q)
    M =data(q,1);
    epoch =data(q,2);
    tasa =data(q,3);
    nrun =data(q,4);
    
    [mejor_FIS_validacion,curvas_error, curvas_error_entre, semax, vs0, vsf]=...
        Proyecto2_Spotify_v(data(q,1),data(q,2),data(q,3),data(q,4));
    
    save(['data/exp',num2str(q),'.mat'])
 end