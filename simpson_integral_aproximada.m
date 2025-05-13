% Datos iniciales
a = 0;
b = 0.8;
n = 2; % Número de segmentos (debe ser par para Simpson 1/3)
h = (b - a) / n;

% Definir la función original
f = @(x) 0.2 + 25*x - 200*x.^2 + 675*x.^3 - 900*x.^4 + 400*x.^5;

% Puntos para Simpson 1/3 con dos segmentos
x0 = a;
x1 = a + h;
x2 = b;

% Aplicar la regla de Simpson 1/3
I_simpson = (h/3) * (f(x0) + 4*f(x1) + f(x2));

% Calcular la cuarta derivada simbólicamente
syms xs;
f_sym = 0.2 + 25*xs - 200*xs^2 + 675*xs^3 - 900*xs^4 + 400*xs^5;
f4_sym = diff(f_sym, xs, 4); % cuarta derivada

% Convertir a función anónima
f4 = matlabFunction(f4_sym);

% Valor medio de la cuarta derivada
media_f4 = integral(f4, a, b) / (b - a);

% Estimar el error de truncamiento de Simpson 1/3 (n = 2 segmentos)
% Fórmula del error: E <= -((b-a)^5 / 180n^4) * f^(4)(ξ)
error_trunc = -((b - a)^5 / (180 * n^4)) * media_f4;

% Valor exacto dado
valor_exacto = 1.640533;

% Error relativo porcentual
error_relativo = abs((valor_exacto - I_simpson) / valor_exacto) * 100;

% Mostrar resultados
fprintf('Integral aproximada (Simpson 1/3): %.6f\n', I_simpson);
fprintf('Valor medio de la cuarta derivada: %.6f\n', media_f4);
fprintf('Error de truncamiento estimado: %.6f\n', error_trunc);
fprintf('Error relativo porcentual: %.6f %%\n', error_relativo);
