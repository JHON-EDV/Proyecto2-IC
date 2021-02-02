%Pipe Line convert .csv to .mat 
%by jhon vargas
clc;close all;clear all;
M=readtable(['spotify_pro.csv']);
data = table2array(M);
save('spotify_pro.mat','data');