%Segundo proyecto 
%Inteligencia Computacional I

clear all;close all; clc;
warning('off','all');

load('spotify_pro.mat'); % Datos tomados del sistema dinámico no lineal SI
data=data(:,2:6);

L=length(data)+1; % ventana de la dinámica SI
sg=data;   %señal S(k)


Tt=0.7;          % de entrenamiento
Tv=0.3;          % de validación

x = 32; %x número de reglas
y = 4; %y Número de entradas


tasa = 0.01;%0.01
m=32; % Tamaño de la base de reglas (plasticidad)
epoch_n = 10; % iteraciones (Necesidad)
nrun=20; %cantidad de corridas independientes (chance)

Ctrai=ceil((L-1)*Tt); % longitud conjunto de entrenamiento
Cvali=ceil((L-1)*Tv); % longitud conjunto de validación

datast=data(1:Ctrai,:);   % conjunto de entrenamiento señal S
datasv=data(Ctrai+1:Ctrai+Cvali-1,:); %conjunto de validación señal S


 datast = normalize(datast,'range'); 
 datasv = normalize(datasv,'range'); 
 
%tset = normalize(tset,'range');
%vset = normalize(vset,'range');
%pset = normalize(pset,'range');

for i = 1:1:nrun
    i
    tic
    %Generación de un sistema difuso con parámetros aleatorios, por defecto
    %funciones gaussianas  y el número de cluster es igual al numero de reglas
    fisinicial = randomfis(x,y);
        
    
    %Cuadrar los parámetros de entrenamiento, paso el sistema difuso anterior,
    %el número de epoca y cuadra la tasa de aprendizaje
    %normalizamos la base de datos
%     tset = tset./(max(max(abs(tset))));
%     vset = vset./(max(max(abs(vset))));
    
    %Entrenamiento ANFIS del sistema difuso 
    anfisopt = anfisOptions ('InitialFIS', fisinicial, 'EpochNumber', epoch_n);
    anfisopt.InitialStepSize = tasa;
    anfisopt.ValidationData = datasv;
    
    anfisopt.DisplayANFISInformation = 0;
    anfisopt.DisplayErrorValues = 0;
    anfisopt.DisplayStepSize = 0;
    anfisopt.DisplayFinalResults = 0;
    
    [fis,trainError,stepSize,chkFIS,chkError] = anfis(datast, anfisopt);
    
    mejor_FIS_validacion(i) = chkFIS;
    curvas_error(i,:) = chkError;
    curvas_error_entre(i,:) = trainError;
    toc
end

%%
%GRAFICAS

% semax=max(max(curvas_error)); % máximo error de validación S
% vs0=var(curvas_error(1,:)); % varianza error de validación S , epoch inicial
% vsf=var(curvas_error(end,:));% varianza error de validación S, epoch final
% 
% semax_2=max(max(curvas_error_2)); % máximo error de validación S
% vs0_2=var(curvas_error_2(1,:)); % varianza error de validación S , epoch inicial
% vsf_2=var(curvas_error_2(end,:));% varianza error de validación S, epoch final
close all;

figure(1)
hold on;
for i = 1:1:length(curvas_error)
    plot(curvas_error(i,:))
end

figure(4),
hold on;

for i = 1:1:length(curvas_error)
    plot(curvas_error_entre(i,:))
end

% 
figure(7)
subplot(1,2,1)
histogram(curvas_error(1,:));
set(gca,'fontsize',14);
xlabel('Ev_0');
ylabel('Conteo');
title('Histograma Ev_0 (S)');
text(0.6*semax,0.8*nrun,['Var=' num2str(vs0)]);

figure(7)
subplot(1,2,2)
histogram(curvas_error(end,:));
set(gca,'fontsize',14);
xlabel('Ev_f');
ylabel('Conteo');
title('Histograma Ev_f (S)');
text(0.6*semax,0.8*nrun,['Var=' num2str(vsf)]);

% [max_pset,w] = sort(yv);
% yoo = pset(w);
% yhh = max_pset(w);
% 
% 
% figure(9)
% plot(yyv,'b+','linewidth',2.0); hold on
% plot(yhh,'r*','markersize',6.0);
% axis([1 length(pset) 0 4]);