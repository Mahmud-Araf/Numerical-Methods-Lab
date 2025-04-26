% differential equation dy/dt = -2y + 4
df = @(t, y) -2*y + 4;

% initial conditions
t0=0;
y0=1;
h=0.1;
tn=5;

% number of steps
n = round((tn-t0)/h);
h = (tn-t0)/n;

% arrays to store values
t = zeros(1,n+1);
y = zeros(1,n+1);

t(1) = t0;
y(1) = y0;

for i = 1:n
    t(i+1) = t(i) + h;
    y(i+1) = y(i)+h*df(t(i), y(i));
end

% analytical solution
t_analytical = linspace(t0, tn, 100);
%Given analytical solution y(t) = 2-(2-y0)*exp(-2*t)
y_analytical = 2 - (2 - y0)*exp(-2*t_analytical);

% values to evaluate
eval_values = [1, 2, 3, 4, 5];

% Get estimated values at evaluation points
estimated_values = zeros(size(eval_values));
for i = 1:length(eval_values)
    idx = round(eval_values(i)/h) + 1;
    estimated_values(i) = y(idx);
end

% Get analytical values
analytical_values = 2 - (2 - y0)*exp(-2*eval_values);

disp('Estimated values using Euler''s method:');
for i = 1:length(eval_values)
    disp(['At t = ',num2str(eval_values(i)),' : y = ',num2str(estimated_values(i))]);
end

% error calculation
absolute_error = abs(analytical_values - estimated_values);
percentage_error = (absolute_error ./ abs(analytical_values)) * 100;

disp(' ');
disp('Absolute Error:');
for i = 1:length(eval_values)
    disp(['At t = ',num2str(eval_values(i)),' : ',num2str(absolute_error(i))]);
end

disp(' ');
disp('Percentage Error:');
for i = 1:length(eval_values)
    disp(['At t = ',num2str(eval_values(i)),' : ',num2str(percentage_error(i)),'%']);
end

% plot all three step sizes in one figure
figure;
plot(t_analytical, y_analytical, 'b-', 'LineWidth', 2, 'DisplayName', 'Analytical');
hold on;

% plot h = 0.1 solution
plot(t, y, 'ro-', 'MarkerSize', 4, 'MarkerFaceColor', 'r', 'DisplayName', 'h = 0.1');

% plot additional step sizes
step_sizes = [0.05, 0.4];
colors = {'g', 'y'};  
for i = 1:length(step_sizes)
    h_new = step_sizes(i);
    n_new = round((tn - t0) / h_new);
    h_new = (tn - t0) / n_new;
    t_new = zeros(1, n_new+1);
    y_new = zeros(1, n_new+1);

    t_new(1) = t0;
    y_new(1) = y0;

    for j = 1:n_new
        t_new(j+1) = t_new(j) + h_new;
        y_new(j+1) = y_new(j) + h_new * df(t_new(j), y_new(j));
    end

    plot(t_new, y_new, [colors{i} 'o-'], 'MarkerSize', 4, ...
        'MarkerFaceColor', colors{i}, 'DisplayName', sprintf('h = %.3f', h_new));
end

grid on;
xlabel('t');
ylabel('y');
title('Euler''s Method with Different Step Sizes', 'FontSize', 14);
legend('Location','northeast');
hold off;
waitfor(gcf);







