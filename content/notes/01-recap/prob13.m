x = [0 1 2 4 6 10];
y = [1 7 23 109 307 1231];

% Fit a 3rd-degree polynomial
p = polyfit(x, y, 3)

% Generate fitted values
x_fit = linspace(min(x), max(x), 200); 
y_fit = polyval(p, x_fit);

% Plot original data and fitted curve
figure;
scatter(x, y, 100, 'filled', 'r', 'DisplayName', 'Data'); hold on;
plot(x_fit, y_fit, 'b-', 'LineWidth', 2, 'DisplayName', '3rd-order Fit');
grid on;
xlabel('x');
ylabel('y');
title('3rd-order Polynomial Fit');
legend show;
