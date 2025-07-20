% Parameters
Kp = 1;
tau = 1;
theta = 10;  % delay in seconds
xis = [0.1 0.5 0.707 1 2];  % different damping ratios
colors = lines(length(xis));

% Time vector
t = 0:0.1:60;
figure; hold on
for xi = xis
    den = [tau^2, 2*xi*tau, 1];
    sys = tf(Kp, den, 'InputDelay', theta);
    [y, t_out] = step(sys, t);
    plot(t_out, y, 'DisplayName', sprintf('\\xi = %.3g', xi));
end
legend show
