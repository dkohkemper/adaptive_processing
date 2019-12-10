% Solucion al problema
m=10; iter=500; tol=10^-5;
% Matrices F1 y F2
F1=rand(m); F2=rand(m);
% Matrices de Covarianza
Rxx=constant_cm(m,0.5); Rv1v1=0.2*eye(m); Rv2v2=0.3*eye(m); 
Rxy1=Rxx; Rxy2=Rxx;
Ry1y1=Rxx+Rv1v1; Ry2y2=Rxx+Rv2v2; 
Ry2y1=Rxx; Ry1y2=Rxx;
% Iteraciones
error=[]; minimo=[];
for k=1:iter
    %Paso 1: Actualizar F1
    Rx1y1=Rxy1-F2*Ry2y1;
    F1_n=Rx1y1*Ry1y1^-1;
    e1=norm(F1-F1_n); %Guardando error para F1;
    F1=F1_n;
    %Paso 2: Actualizar F2
    Rx2y2=Rxy2-F1*Ry1y2;
    F2_n=Rx2y2*Ry2y2^-1;
    e2=norm(F2-F2_n); %Guardando error para F1;
    F2=F2_n;
    error_total=(e1+e2)/2;
    % Calculo del Error
    error=[error error_total];
    % Calculo del mínimo
    A=Rxx-Rxy1*F1'-Rxy2*F2'-F1*(Rxy1)'+F1*Ry1y1*F1'+F1*Ry1y2*F2'-F2*(Rxy2)'+F2*Ry2y1*F1'+F2*Ry2y2*F2';
    minimo=[minimo trace(A)];
    if error_total<tol
        break
    end        
end

plot(1:k,error)
title('Error vrs iteraciones')
figure
plot(1:k,minimo)
title('Minimo vrs iteraciones')

trace(A)
error_total