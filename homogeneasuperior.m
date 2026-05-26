syms t u1 u2 u3 u4
disp('ECUACIONES DIFERENCIALES DE ORDEN 4')
fu1=input('Ingrese du1:');
fu2=input('Ingrese du2:');
fu3=input('Ingrese du3:');
fu4=input('Ingrese du4:');
intervalo=input('Ingrese el intervalo [a,b]:');
u10=input('Ingrese el valor inicial u1:');
u20=input('Ingrese el valor inicial u2:');
u30=input('Ingrese el valor inicial u3:');
u40=input('Ingrese el valor inicial u4:');
h=input('Ingrese el valor de h:');
a=intervalo(1);
b=intervalo(2);
T=[a:h:b];
n=length(T)-1;
U1=zeros(1,n);
U2=zeros(1,n);
U3=zeros(1,n);
U4=zeros(1,n);
U1(1)=u10;
U2(1)=u20;
U3(1)=u30;
U4(1)=u40;

for i=1:n
    fprintf('PARA i=%2.0f\n',i)
    fprintf('t=%.15f\n',T(i+1))
    
    % Calculo de k1
    k11=double(subs(fu1,{t,u1,u2,u3,u4},{T(i),U1(i),U2(i),U3(i),U4(i)}));
    k12=double(subs(fu2,{t,u1,u2,u3,u4},{T(i),U1(i),U2(i),U3(i),U4(i)}));
    k13=double(subs(fu3,{t,u1,u2,u3,u4},{T(i),U1(i),U2(i),U3(i),U4(i)}));
    k14=double(subs(fu4,{t,u1,u2,u3,u4},{T(i),U1(i),U2(i),U3(i),U4(i)}));
    
    % Calculo de k2
    k21=double(subs(fu1,{t,u1,u2,u3,u4},{T(i)+h/2,U1(i)+(h/2)*k11,U2(i)+(h/2)*k12,U3(i)+(h/2)*k13,U4(i)+(h/2)*k14}));
    k22=double(subs(fu2,{t,u1,u2,u3,u4},{T(i)+h/2,U1(i)+(h/2)*k11,U2(i)+(h/2)*k12,U3(i)+(h/2)*k13,U4(i)+(h/2)*k14}));
    k23=double(subs(fu3,{t,u1,u2,u3,u4},{T(i)+h/2,U1(i)+(h/2)*k11,U2(i)+(h/2)*k12,U3(i)+(h/2)*k13,U4(i)+(h/2)*k14}));
    k24=double(subs(fu4,{t,u1,u2,u3,u4},{T(i)+h/2,U1(i)+(h/2)*k11,U2(i)+(h/2)*k12,U3(i)+(h/2)*k13,U4(i)+(h/2)*k14}));
    
    % Calculo de k3
    k31=double(subs(fu1,{t,u1,u2,u3,u4},{T(i)+h/2,U1(i)+(h/2)*k21,U2(i)+(h/2)*k22,U3(i)+(h/2)*k23,U4(i)+(h/2)*k24}));
    k32=double(subs(fu2,{t,u1,u2,u3,u4},{T(i)+h/2,U1(i)+(h/2)*k21,U2(i)+(h/2)*k22,U3(i)+(h/2)*k23,U4(i)+(h/2)*k24}));
    k33=double(subs(fu3,{t,u1,u2,u3,u4},{T(i)+h/2,U1(i)+(h/2)*k21,U2(i)+(h/2)*k22,U3(i)+(h/2)*k23,U4(i)+(h/2)*k24}));
    k34=double(subs(fu4,{t,u1,u2,u3,u4},{T(i)+h/2,U1(i)+(h/2)*k21,U2(i)+(h/2)*k22,U3(i)+(h/2)*k23,U4(i)+(h/2)*k24}));
    
    % Calculo de k4
    k41=double(subs(fu1,{t,u1,u2,u3,u4},{T(i)+h,U1(i)+h*k31,U2(i)+h*k32,U3(i)+h*k33,U4(i)+h*k34}));
    k42=double(subs(fu2,{t,u1,u2,u3,u4},{T(i)+h,U1(i)+h*k31,U2(i)+h*k32,U3(i)+h*k33,U4(i)+h*k34}));
    k43=double(subs(fu3,{t,u1,u2,u3,u4},{T(i)+h,U1(i)+h*k31,U2(i)+h*k32,U3(i)+h*k33,U4(i)+h*k34}));
    k44=double(subs(fu4,{t,u1,u2,u3,u4},{T(i)+h,U1(i)+h*k31,U2(i)+h*k32,U3(i)+h*k33,U4(i)+h*k34}));
    
    % Actualizacion de variables
    U1(i+1)=double(U1(i)+(h/6)*(k11+2*k21+2*k31+k41));
    U2(i+1)=double(U2(i)+(h/6)*(k12+2*k22+2*k32+k42));
    U3(i+1)=double(U3(i)+(h/6)*(k13+2*k23+2*k33+k43));
    U4(i+1)=double(U4(i)+(h/6)*(k14+2*k24+2*k34+k44));
    
    % Impresion de resultados
    fprintf('u1(t)=y(t)=%.15f\n',U1(i+1))
    fprintf('u2(t)=Dy(t)=%.15f\n',U2(i+1))
    fprintf('u3(t)=D2y(t)=%.15f\n',U3(i+1))
    fprintf('u4(t)=D3y(t)=%.15f\n',U4(i+1))
    fprintf('--------------------------\n')
end


% =========================================================
% ECUACIONES DIFERENCIALES HOMOGENEAS
% =========================================================
%
% Forma general:
%
% M(x,y)dx + N(x,y)dy = 0
%
% o
%
% dy/dx = f(x,y)
%
% ---------------------------------------------------------
% COMO IDENTIFICAR SI ES HOMOGENEA
% ---------------------------------------------------------
%
% Todos los términos deben tener el mismo grado.
%
% Ejemplos:
%
% x^2 + xy + y^2     --> grado 2
%
% x^3 + x^2y + y^3  --> grado 3
%
% Si todos tienen el mismo grado:
%
% ==> la ecuación es homogénea.
%
% =========================================================
% CASO 1: USAR y = ux
% =========================================================
%
% Se utiliza cuando:
%
% N(x,y) es la parte más sencilla
% (menos términos o algebra más simple)
%
% ---------------------------------------------------------
% PASOS
% ---------------------------------------------------------
%
% 1) Hacer la sustitución:
%
%    y = ux
%
% 2) Derivar:
%
%    dy/dx = u + x(du/dx)
%
% 3) Sustituir todo en la ecuación diferencial.
%
% 4) Simplificar hasta que quede:
%
%    dy/dx = f(u)
%
% 5) Igualar:
%
%    u + x(du/dx) = f(u)
%
% 6) Despejar:
%
%    x(du/dx) = f(u) - u
%
% 7) Separar variables:
%
%    du/(f(u)-u) = dx/x
%
% 8) Integrar ambos lados.
%
% 9) Sustituir nuevamente:
%
%    u = y/x
%
% 10) Obtener la solución final.
%
% =========================================================
% CASO 2: USAR x = vy
% =========================================================
%
% Se utiliza cuando:
%
% M(x,y) es la parte más sencilla
% (menos términos o algebra más simple)
%
% ---------------------------------------------------------
% PASOS
% ---------------------------------------------------------
%
% 1) Hacer la sustitución:
%
%    x = vy
%
% 2) Derivar:
%
%    dx/dy = v + y(dv/dy)
%
% 3) Sustituir todo en la ecuación diferencial.
%
% 4) Simplificar hasta que quede:
%
%    dx/dy = f(v)
%
% 5) Igualar:
%
%    v + y(dv/dy) = f(v)
%
% 6) Despejar:
%
%    y(dv/dy) = f(v) - v
%
% 7) Separar variables:
%
%    dv/(f(v)-v) = dy/y
%
% 8) Integrar ambos lados.
%
% 9) Sustituir nuevamente:
%
%    v = x/y
%
% 10) Obtener la solución final.
%
% ---------------------------------------------------------
% IDEA CLAVE
% ---------------------------------------------------------
%
% Si aparece:
%
%    y/x
%
% o
%
%    x/y
%
% y todos los términos tienen el mismo grado,
%
% entonces probablemente es homogénea.
%
% El objetivo de la sustitución es convertir
% la ecuación en una separable.
%
% =========================================================