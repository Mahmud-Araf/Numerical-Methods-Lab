time = [0, 4, 8, 12, 16, 20, 24];
energy = [1.2, 2.8, 3.5, 4.0, 3.2, 2.5, 1.0];

n = length(time);

% Function to calculate the Lagrange interpolation polynomial

function val = lagrange_polynomial(x, time, energy, n)
    val = 0;
    for i = 1:n
        L = 1;
        for j = 1:n
            if i ~= j
                L = L * (x - time(j)) / (time(i) - time(j));
            end
        end
        val = val + L * energy(i);
    end
end

% Cubic Spline
spline_coeffs = spline(time, energy);

% Function to evaluate the cubic spline at a given point
function val = evaluate_spline(x, spline_coeffs)
    val = ppval(spline_coeffs, x);
end


%Points to evaluate
eval_points = [2, 7, 10, 22];

% Lagrange Interpolation For the given points
estimated_energy_lagrange = arrayfun(@(x) lagrange_polynomial(x, time, energy, n), eval_points);

disp('Estimated Energy using Lagrange Interpolation:');
disp(['At ', num2str(eval_points(1)), ' : ', num2str(estimated_energy_lagrange(1)), ' kWh']);
disp(['At ', num2str(eval_points(2)), ' : ', num2str(estimated_energy_lagrange(2)), ' kWh']);
disp(['At ', num2str(eval_points(3)), ' : ', num2str(estimated_energy_lagrange(3)), ' kWh']);
disp(['At ', num2str(eval_points(4)), ' : ', num2str(estimated_energy_lagrange(4)), ' kWh']);
disp('')



t_range = linspace(0, 24, 100);
spline_vals = arrayfun(@(x) evaluate_spline(x, spline_coeffs), t_range);

% Cubic Spline For points from 0 to 24
estimated_energy_spline = arrayfun(@(x) evaluate_spline(x, spline_coeffs), eval_points);

disp('Estimated Energy using Cubic Spline:');
disp(['At ', num2str(eval_points(1)), ' : ', num2str(estimated_energy_spline(1)), ' kWh']);
disp(['At ', num2str(eval_points(2)), ' : ', num2str(estimated_energy_spline(2)), ' kWh']);
disp(['At ', num2str(eval_points(3)), ' : ', num2str(estimated_energy_spline(3)), ' kWh']);
disp(['At ', num2str(eval_points(4)), ' : ', num2str(estimated_energy_spline(4)), ' kWh']);
disp('')

%Error Calculation
absolute_error = abs(estimated_energy_spline - estimated_energy_lagrange);
percentage_error = (absolute_error ./ estimated_energy_spline) * 100;

disp('Absolute Error:');
disp(['At ', num2str(eval_points(1)), ' : ', num2str(absolute_error(1)), ' kWh']);
disp(['At ', num2str(eval_points(2)), ' : ', num2str(absolute_error(2)), ' kWh']);
disp(['At ', num2str(eval_points(3)), ' : ', num2str(absolute_error(3)), ' kWh']);
disp(['At ', num2str(eval_points(4)), ' : ', num2str(absolute_error(4)), ' kWh']);
disp('')
disp('Percentage Error:');
disp(['At ', num2str(eval_points(1)), ' : ', num2str(percentage_error(1)), '%']);
disp(['At ', num2str(eval_points(2)), ' : ', num2str(percentage_error(2)), '%']);
disp(['At ', num2str(eval_points(3)), ' : ', num2str(percentage_error(3)), '%']);
disp(['At ', num2str(eval_points(4)), ' : ', num2str(percentage_error(4)), '%']);
disp('')

%Plot For Lagrange vs Cubic Spline
figure;
plot(t_range, spline_vals, 'b-', 'LineWidth', 2);
hold on;
plot(eval_points, estimated_energy_lagrange, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
grid on;
xlabel('Time (hrs)');
ylabel('Energy (kWh)');
title('Lagrange vs Cubic Spline', 'FontSize', 14);
legend('Cubic Spline', 'Lagrange');
hold off;
waitfor(gcf);


