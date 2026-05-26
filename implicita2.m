syms y t
disp('--- Calculadora de Valores para Soluciones Implícitas ---')

% 1. Ingresas tu ecuación directamente (¡recuerda el ==!)
eqn = input('Ingrese la ecuación implícita (ej. y^2+sin(t*y)-log(t/y) == 5): ');

intervalo = input('Ingrese el intervalo [a,b]: ');
y0 = input('Ingrese el valor inicial y(a): ');
h = input('Ingrese el valor de h: ');

% 2. Generamos el vector de tiempo
T = intervalo(1):h:intervalo(2);
y_actual = double(y0); % Usaremos el valor anterior como "semilla" de búsqueda

% 3. Encabezado de la tabla
fprintf('\n ti\t\t\t\t\t ||  Y exacta\n');
fprintf('%.15f\t ||  %.15f\n', T(1), y_actual);

% 4. Bucle para despejar Y en cada paso
for i = 2:length(T)
    % Sustituimos el valor de 't' de esta iteración en la ecuación
    eqn_evaluada = subs(eqn, t, T(i));
    
    % vpasolve despeja numéricamente la 'y', buscando cerca de nuestro y_actual
    y_actual = double(vpasolve(eqn_evaluada, y, y_actual));
    
    % Mostramos el resultado
    fprintf('%.15f\t ||  %.15f\n', T(i), y_actual);
end