% Исходные параметры
sigma = 2;
tt = 2;

% Дискретные сигналы
n = 100;
dt = 0.1;
t_max = dt*(n-1)/2;
t = -t_max:dt:t_max;

gauss_discrete = exp(-(t/sigma).^2);
rect_discrete = zeros(size(t));
rect_discrete(abs(t) - tt < 0) = 1;

% Исходные сигналы
x = -t_max:0.005:t_max;
gauss_ref = exp(-(x/sigma).^2);
rect_ref = zeros(size(x));
rect_ref(abs(x) - tt < 0) = 1;

% Восстановленные сигналы
gauss_restored = zeros(1, length(x));
rect_restored = zeros(1, length(x));
for i=1:length(x)
   for j = 1:n
       gauss_restored(i) = gauss_restored(i) + gauss_discrete(j) * sin((x(i)-t(j))/dt * pi) / ((x(i)-t(j))/dt * pi);
       rect_restored(i) = rect_restored(i) + rect_discrete(j) * sin((x(i)-t(j))/dt * pi) / ((x(i)-t(j))/dt * pi);
   end
end

figure;

subplot(2,1,1);
title('Прямоугольный импульс');
hold on;
grid on;
plot(x, rect_ref, 'k');
plot(x, rect_restored, 'r');
plot(t, rect_discrete, '.m');
legend('Исходная', 'Восстановленная', 'Дискретная');

subplot(2,1,2);
title('Гауссовский фильтр');
hold on;
grid on;
plot(x, gauss_ref, 'k');
plot(x, gauss_restored, 'r');
plot(t, gauss_discrete, '.m');
legend('Исходная', 'Восстановленная', 'Дискретная');

print -djpg p2.jpg
