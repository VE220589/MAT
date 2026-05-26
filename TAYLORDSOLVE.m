syms y t
disp('======================================================================')
disp('  Método de Taylor Orden 4 - Solución Exacta Automática (dsolve)      ')
disp('======================================================================')

% 1. Ingreso de las derivadas individuales para Taylor
f  = input('Ingrese la 1ra derivada ( dy/dt ): ');
f1 = input('Ingrese la 2da derivada ( f'' ): ');
f2 = input('Ingrese la 3ra derivada ( f'''' ): ');
f3 = input('Ingrese la 4ta derivada ( f'''''' ): ');

intervalo = input('Ingrese el intervalo [a,b]: ');
y0 = input('Ingrese el valor inicial y(a): ');
h = input('Ingrese el valor de h: ');

% 2. Inicialización de los vectores
a = intervalo(1);
b = intervalo(2);
T = a:h:b;
n = length(T) - 1;
Y(1) = y0;

% 3. Cálculo AUTOMÁTICO de la solución exacta usando dsolve
disp(' ');
disp('Calculando solución exacta internamente...');
syms y_func(t)

% Preparamos la ecuación y resolvemos
f_ode = subs(f, y, y_func(t));          
ode = diff(y_func(t), t) == f_ode;      
cond = y_func(a) == y0;                 
F = dsolve(ode, cond);                  

% Imprime la función exacta analítica que MATLAB encontró
fprintf('La solución exacta encontrada es: F(t) = %s\n', char(F));

% 4. Encabezado de la tabla e iteración inicial
fprintf('\ni\t ti\t\t\t\t\t ||  Yi (Taylor)\t\t\t\t ||  F(ti) Exacta\t\t\t\t ||  error\n');

exacta_inicial = double(subs(F, t, T(1)));
fprintf('0\t %.15f\t ||  %.15f\t ||  %.15f\t ||  0\n', T(1), double(Y(1)), exacta_inicial);

% 5. Bucle iterativo del método numérico
for i=1:n
    % --- PARTE A: Cálculo de la aproximación de Taylor ---
    k1 = double(subs(f,  {t,y}, {T(i), Y(i)}));
    k2 = double(subs(f1, {t,y}, {T(i), Y(i)}));
    k3 = double(subs(f2, {t,y}, {T(i), Y(i)}));
    k4 = double(subs(f3, {t,y}, {T(i), Y(i)}));
    
    Y(i+1) = Y(i) + h*k1 + (h^2/2)*k2 + (h^3/6)*k3 + (h^4/24)*k4;
    
    % --- PARTE B: Evaluación de la solución exacta automática ---
    exacta = double(subs(F, t, T(i+1)));
    
    error = abs(exacta - Y(i+1));
    
    % Impresión de la iteración
    fprintf('%d\t %.15f\t ||  %.15f\t ||  %.15f\t ||  %e\n', i, T(i+1), double(Y(i+1)), exacta, double(error));
end

% 6. Resultados finales
disp('---------------------------------------------------------------------------------------------------------');
fprintf('El valor aproximado Y(%.15f) = %.15f \n', b, double(Y(n+1)));
fprintf('El valor exacto F(%.15f) = %.15f \n', b, exacta);
fprintf('Error final: %e \n', double(error));