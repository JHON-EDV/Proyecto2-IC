clear all,
close all,
clc
warning('off','all')
load('validacion1_one_hot.mat')
load('postValidacion_one_hot.mat')
load('entrenamiento1_one_hot.mat')

%n Número de entradas
%m número de reglas

n = 11;
m = 32;
tasa = 0.01;
epocas = 100; %Puntos de curva
iteraciones = 100; % Curva completa
 
tset = normalize(tset,'range');
vset = normalize(vset,'range');
pset = normalize(pset,'range');

for i = 1:1:iteraciones
    i
    %Generación de un sistema difuso con parámetros aleatorios, por defecto
    %funciones gaussianas  y el número de cluster es igual al numero de reglas
    fisinicial = FIS_aleatorio(m,n);
    fisinicial_2 = FIS_aleatorio(m,n);
    fisinicial_3 = FIS_aleatorio(m,n);
    
    %Cuadrar los parámetros de entrenamiento, paso el sistema difuso anterior,
    %el número de epoca y cuadra la tasa de aprendizaje
    %normalizamos la base de datos
%     tset = tset./(max(max(abs(tset))));
%     vset = vset./(max(max(abs(vset))));
    
    %Cuadramos el anfis 
    anfisopt = anfisOptions ('InitialFIS', fisinicial, 'EpochNumber', epocas);
    anfisopt.InitialStepSize = tasa;
    anfisopt.ValidationData = vset(:,1:12);
    
    anfisopt.DisplayANFISInformation = 0;
    anfisopt.DisplayErrorValues = 0;
    anfisopt.DisplayStepSize = 0;
    anfisopt.DisplayFinalResults = 0;
    
    [fis,trainError,stepSize,chkFIS,chkError] = anfis(tset(:,1:12), anfisopt);
    
    mejor_FIS_validacion(i) = chkFIS;
    curvas_error(i,:) = chkError;
    curvas_error_entre(i,:) = trainError;
    
end

%%
%GRAFICAS

semax=max(max(curvas_error)); % máximo error de validación S
vs0=var(curvas_error(1,:)); % varianza error de validación S , epoch inicial
vsf=var(curvas_error(end,:));% varianza error de validación S, epoch final

semax_2=max(max(curvas_error_2)); % máximo error de validación S
vs0_2=var(curvas_error_2(1,:)); % varianza error de validación S , epoch inicial
vsf_2=var(curvas_error_2(end,:));% varianza error de validación S, epoch final

% figure(1)
% hold on;
% for i = 1:1:length(curvas_error)
%     plot(curvas_error(i,:))
% end
% 
% figure(4),
% hold on;
% for i = 1:1:length(curvas_error)
%     plot(curvas_error_entre(i,:))
% end
% 
% figure(7)
% subplot(1,2,1)
% histogram(curvas_error(1,:));
% set(gca,'fontsize',14);
% xlabel('Ev_0');
% ylabel('Conteo');
% title('Histograma Ev_0 (S)');
% text(0.6*semax,0.8*iteraciones,['Var=' num2str(vs0)]);
% 
% figure(7)
% subplot(1,2,2)
% histogram(curvas_error(end,:));
% set(gca,'fontsize',14);
% xlabel('Ev_f');
% ylabel('Conteo');
% title('Histograma Ev_f (S)');
% text(0.6*semax,0.8*iteraciones,['Var=' num2str(vsf)]);
% 
% [max_pset,w] = sort(yv);
% yoo = pset(w);
% yhh = max_pset(w);
% 
% 
% figure(9)
% plot(yyv,'b+','linewidth',2.0); hold on
% plot(yhh,'r*','markersize',6.0);
% axis([1 length(pset) 0 4]);