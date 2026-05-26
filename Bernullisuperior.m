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
% ECUACIONES DIFERENCIALES DE BERNOULLI
% =========================================================
%
% Forma general:
%
% dy/dx + P(x)y = Q(x)y^n
%
% donde:
% n ~= 0 y n ~= 1
%
% ---------------------------------------------------------
% PASOS PARA RESOLVER
% ---------------------------------------------------------
%
% 1) Llevar la ecuación a la forma:
%
%    dy/dx + P(x)y = Q(x)y^n
%
% 2) Multiplicar toda la ecuación por:
%
%    y^(-n)
%
% 3) Hacer la sustitución:
%
%    v = y^(1-n)
%
% 4) Derivar:
%
%    dv/dx = (1-n)y^(-n)dy/dx
%
% 5) Sustituir en la ecuación.
%
%    La ecuación se convierte en una lineal:
%
%    dv/dx + P1(x)v = Q1(x)
%
% 6) Resolver la ecuación lineal usando
%    factor integrante:
%
%    mu(x) = e^( integral(P1(x)dx) )
%
% 7) Multiplicar toda la ecuación por mu(x)
%
% 8) Integrar:
%
%    d(mu*v)/dx = lado derecho
%
% 9) Sustituir nuevamente:
%
%    v = y^(1-n)
%
% 10) Despejar y
%
% ---------------------------------------------------------
% IDEA CLAVE
% ---------------------------------------------------------
%
% Si aparece:
%
%    y^2, y^3, y^-1, etc.
%
% junto con:
%
%    dy/dx + P(x)y
%
% probablemente es Bernoulli.
%
% =========================================================
% FACTOR INTEGRANTE
% =========================================================
%
% Forma general:
%
% M(x,y)dx + N(x,y)dy = 0
%
% ---------------------------------------------------------
% PASO 1: VERIFICAR SI ES EXACTA
% ---------------------------------------------------------
%
% Calcular:
%
%    dM/dy
%
% y
%
%    dN/dx
%
% Si:
%
%    dM/dy = dN/dx
%
% entonces ES exacta.
%
% Si NO son iguales:
%
%    probar factor integrante.
%
% ---------------------------------------------------------
% CASO 1: FACTOR INTEGRANTE EN x
% ---------------------------------------------------------
%
% Calcular:
%
% (1/N)*(dM/dy - dN/dx)
%
% Si depende SOLO de x:
%
%    mu(x) = e^( integral(f(x)dx) )
%
% Multiplicar TODA la ecuación por mu(x)
%
% Luego resolver como exacta.
%
% ---------------------------------------------------------
% CASO 2: FACTOR INTEGRANTE EN y
% ---------------------------------------------------------
%
% Calcular:
%
% (1/M)*(dN/dx - dM/dy)
%
% Si depende SOLO de y:
%
%    mu(y) = e^( integral(f(y)dy) )
%
% Multiplicar TODA la ecuación por mu(y)
%
% Luego resolver como exacta.
%
% ---------------------------------------------------------
% IDEA CLAVE
% ---------------------------------------------------------
%
% Si la ecuación:
%
%    Mdx + Ndy = 0
%
% NO es exacta,
%
% entonces buscar:
%
%    mu(x) o mu(y)
%
% para volverla exacta.
%
% =========================================================