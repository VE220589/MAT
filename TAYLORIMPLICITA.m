syms y t
disp('======================================================================')
disp('   Método de Taylor Orden 4 - Solución Implícita Directa              ')
disp('======================================================================')

% 1. Ingreso de las derivadas individuales para Taylor
f  = input('Ingrese la 1ra derivada ( dy/dt ): ');
f1 = input('Ingrese la 2da derivada ( f'' ): ');
f2 = input('Ingrese la 3ra derivada ( f'''' ): ');
f3 = input('Ingrese la 4ta derivada ( f'''''' ): ');

% 2. Ingreso de la solución implícita
disp(' ');
eqn = input('Ingrese la ecuación implícita completa (ej. y^2+sin(t*y)-log(t/y) == 5): ');

intervalo = input('Ingrese el intervalo [a,b]: ');
y0 = input('Ingrese el valor inicial y(a): ');
h = input('Ingrese el valor de h: ');

% 3. Inicialización de los vectores
a = intervalo(1);
b = intervalo(2);
T = a:h:b;
n = length(T) - 1;
Y(1) = y0;

% 4. Encabezado de la tabla e iteración inicial
fprintf('\ni\t ti\t\t\t\t\t ||  Yi (Taylor)\t\t\t\t ||  F(ti) Exacta\t\t\t\t ||  error\n');
fprintf('0\t %.15f\t ||  %.15f\t ||  %.15f\t ||  0\n', T(1), double(Y(1)), double(Y(1)));

% 5. Bucle iterativo del método numérico
for i=1:n
    % --- PARTE A: Cálculo de la aproximación de Taylor ---
    k1 = subs(f,  {t,y}, {T(i), Y(i)});
    k2 = subs(f1, {t,y}, {T(i), Y(i)});
    k3 = subs(f2, {t,y}, {T(i), Y(i)});
    k4 = subs(f3, {t,y}, {T(i), Y(i)});
    
    Y(i+1) = Y(i) + h*k1 + (h^2/2)*k2 + (h^3/6)*k3 + (h^4/24)*k4;
    
    % --- PARTE B: Cálculo de la solución exacta implícita ---
    % Sustituimos la 't' actual en tu ecuación completa
    eqn_evaluada = subs(eqn, t, T(i+1));
    
    % vpasolve despeja la 'y'. Usamos el Y(i+1) de Taylor como guía de búsqueda
    exacta_sym = vpasolve(eqn_evaluada, y, double(Y(i+1)));
    
    % Validación por si la ecuación matemática diverge en ese punto
    if isempty(exacta_sym)
        exacta = NaN;
    else
        exacta = double(exacta_sym);
    end
    
    error = abs(exacta - Y(i+1));
    
    % Impresión de la iteración
    fprintf('%d\t %.15f\t ||  %.15f\t ||  %.15f\t ||  %e\n', i, T(i+1), double(Y(i+1)), exacta, double(error));
end

% 6. Resultados finales
disp('---------------------------------------------------------------------------------------------------------');
fprintf('El valor aproximado Y(%.15f) = %.15f \n', b, double(Y(n+1)));
fprintf('El valor exacto F(%.15f) = %.15f \n', b, exacta);
fprintf('Error final: %e \n', double(error));