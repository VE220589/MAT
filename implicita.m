clc;
clear;

% Intervalo y paso
h = 0.5;
t = 1:h:3;

% Vector para guardar soluciones
y = zeros(size(t));

% Valor inicial aproximado
y0 = 2;

for i = 1:length(t)

    ti = t(i);

    % Funcion implicita
    f = @(y) y.^2 + sin(ti*y) - log(ti./y) - 5;

    % Resolver ecuacion no lineal
    y(i) = fzero(f, y0);

    % Usar la solucion encontrada como nueva aproximacion
    y0 = y(i);

end

% Mostrar resultados
tabla = table(t', y', 'VariableNames', {'t','y'});
disp(tabla);