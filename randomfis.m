function [myfix] = randomfis(m,n)

myfix=newfis('fis1','FISType','sugeno','AndMethod','prod','OrMethod','probor','ImplicationMethod','prod','AggregationMethod','sum','DefuzzificationMethod','wtaver');

%n=4; % numero de entradas
%varran=[ 0 245; -60 4; 0 1; 0 1; 0 100]; % rangos de las entradas y salida ( última fila )
varran=[ 0 1; 0 1; 0 1; 0 1; 0 1]; % rangos de las entradas y salida ( última fila )
%m=8; % numero de reglas


%Generación de parametros aleatorios segun las escalas
md1=rand(m,n);
dv1=rand(m,n);
yo1=rand(m,1);

%Escalado entradas
for k=1:n
    md(:,k)=md1(:,k) .* (varran(k,2)-varran(k,1)) + varran(k,1);
    dv(:,k)=dv1(:,k) .* (varran(k,2)-varran(k,1)) + varran(k,1);
end

%Escalado salida
yo=yo1 .* (varran(n+1,2)-varran(n+1,1)) + varran(n+1,1);


%Agregación de entradas

for j=1:n
    myfix = addvar(myfix,'input',['inpt' num2str(j)],varran(j,:));
    for i=1:m
        %agregación de funciones de pertenencia por entrada
        myfix=addmf(myfix,'input',j,['mfu' num2str(i)],'gaussmf',[dv(i,j) md(i,j)]);
    end 
end

% Agregación de salida
myfix=addvar(myfix,'output','fisopt',varran(n+1,:));


% agergación de conjuntos de salida
for i=1:m
        myfix=addmf(myfix,'output',1,['mfo' num2str(i)],'constant',yo(i,1));
end


% Creación de la base de reglas
id=ones(1,n+1);

for i=1:m
    rule=i*id;
    rulelist=[ rule 1 1]; 
    myfix=addrule(myfix,rulelist);
end

end






