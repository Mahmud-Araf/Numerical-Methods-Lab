time = [0, 6, 12, 18, 24];
temperature = [15, 10, 20, 25, 18];

n = length(time);
divided_diff = zeros(n, n);
divided_diff(:, 1) = temperature';

%Divided-Difference Table
for j=2:n
    for i = 1:(n-j+1)
        divided_diff(i,j) = (divided_diff(i+1, j-1) - divided_diff(i, j-1)) / (time(i+j-1) - time(i));
    end
end
disp('')
disp('Divided-Difference Table:');
disp(divided_diff);

%Function to calculate the interpolation
function val = newton_polynomial(x, time, divided_diff, n)
    val = divided_diff(1, 1);
    term = 1;
    for k = 1:(n-1)
        term = term * (x - time(k));
        val = val + divided_diff(1, k+1) * term;
    end
end

disp('')

% Function to display the polynomial
function display_polynomial(divided_diff, time, n)
    polynomial_str = sprintf('%.6f', divided_diff(1,1));
    for k = 1:(n-1)
        term_str = sprintf('(x - %.6f)', time(k));
        coeff_str = sprintf('%.6f', divided_diff(1, k+1));
        polynomial_str = [polynomial_str, ' + ', coeff_str, ' * ', term_str];
        for j = 1:(k-1)
            term_str = sprintf('(x - %.6f)', time(j));
            polynomial_str = [polynomial_str, ' * ', term_str];
        end
    end
    disp('Interpolating Polynomial:');
    disp(polynomial_str);
    disp('')
end

display_polynomial(divided_diff, time, n);

eval_points = [3, 9, 21];
estimated_temps = arrayfun(@(x) newton_polynomial(x, time, divided_diff, n), eval_points);
disp('')
disp('Estimated Temperatures:');
disp(['At 3 a.m.: ', num2str(estimated_temps(1)), '°C']);
disp(['At 9 a.m.: ', num2str(estimated_temps(2)), '°C']);
disp(['At 21 p.m.: ', num2str(estimated_temps(3)), '°C']);
disp('')
t_range = linspace(0,24,100);
polynomial_vals = arrayfun(@(x) newton_polynomial(x,time,divided_diff,n), t_range);

figure;
%Plot for the polynomial
plot(t_range, polynomial_vals, 'b-', 'LineWidth', 2);
hold on;
%Plot for original data points
plot(time, temperature, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
plot(eval_points,estimated_temps,'go','MarkerSize', 8, 'MarkerFaceColor', 'g')
grid on;
xlabel('Time (hrs)');
ylabel('Temperature (°C)');
title('Newton Divided-Difference Interpolation');
legend('Interpolating Polynomial','Original Data Points','Estimated Data Points');
hold off;
waitfor(gcf);




