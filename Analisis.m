clc; clear all; close all;

experimento = 4;

 for q=1:1:15
     fprintf('Cargando los datos del experimento %d \n',q);    
     reglas(q,:) = load(['Data\data_',num2str(experimento),'\exp',num2str(q),'.mat'],'M');
     Nit(q,:) = load(['Data\data_',num2str(experimento),'\exp',num2str(q),'.mat'],'epoch');
     tasa(q,:) = load(['Data\data_',num2str(experimento),'\exp',num2str(q),'.mat'],'tasa');
     nrun(q,:) = load(['Data\data_',num2str(experimento),'\exp',num2str(q),'.mat'],'nrun');
     semax(q,:) = load(['Data\data_',num2str(experimento),'\exp',num2str(q),'.mat'],'semax');
     Vs0(q,:) = load(['Data\data_',num2str(experimento),'\exp',num2str(q),'.mat'],'vs0');
     Vsf(q,:) = load(['Data\data_',num2str(experimento),'\exp',num2str(q),'.mat'],'vsf');     
      % curvas_error_entre(i,:) = trainError;
 end 
  
  for q=17:1:21
     fprintf('Cargando los datos del experimento %d \n',q);
     reglas(q,:) = load(['Data\data_',num2str(experimento),'\exp',num2str(q),'.mat'],'M');
     Nit(q,:) = load(['Data\data_',num2str(experimento),'\exp',num2str(q),'.mat'],'epoch');
     tasa(q,:) = load(['Data\data_',num2str(experimento),'\exp',num2str(q),'.mat'],'tasa');
     nrun(q,:) = load(['Data\data_',num2str(experimento),'\exp',num2str(q),'.mat'],'nrun');
     semax(q,:) = load(['Data\data_',num2str(experimento),'\exp',num2str(q),'.mat'],'semax');
     Vs0(q,:) = load(['Data\data_',num2str(experimento),'\exp',num2str(q),'.mat'],'vs0');
     Vsf(q,:) = load(['Data\data_',num2str(experimento),'\exp',num2str(q),'.mat'],'vsf');     
  end 

reglas = cell2mat( struct2cell( reglas) );
semax  = cell2mat( struct2cell( semax) ) ;
Nit    = cell2mat( struct2cell( Nit) )   ;
tasa   = cell2mat( struct2cell( tasa) )  ;
nrun   = cell2mat( struct2cell( nrun) )  ;
Vs0    = cell2mat( struct2cell( Vs0) )   ;
Vsf    = cell2mat( struct2cell( Vsf) )   ;


save(['data_',num2str(experimento),'_exp'],...
    'reglas','semax','Nit','tasa','nrun','Vs0','Vsf');

%%
min

%semax=min(data); 
%semax=max(max(curvas_error)); % máximo error de validación S