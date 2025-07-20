%% 
% Read the data from the CSV file 

data = readtable('discrete_time_response.csv');

%% 
% Define additional input changes (delta_u) at specified time steps
% 
% Δu at t = 0, 1, 2, 3, 4 respectively

delta_u_changes = [1, 0, 1, 0, -1]; 
%% 
% 
% 
% *Model horizon* – the number of steps required to reach the steady-state value 
% after subjected to an input change at step = 0, e.g., 7 steps required to reach 
% 0.89, thus the model horizon is m = 7.

% Max time steps 
% (we want the results for y9)
max_t = 9; 
%% 
% Initialize an array for calculated y(t)

y_calculated = zeros(max_t+1, 1);
%% 
% *Prediction horizon* – the number of steps required to reach the steady-state  
% after subjected to a series of input changes, therefore the process output will 
% a longer time to reach the steady state value, e.g., rule of thumb specify $n\le 
% 1\ldotp 5m$. If the prediction horizon is too short, then the optimization solution 
% is not accurate and can cause poor MPC performance. On the contrary, if the 
% prediction horizon is too long, the solution can be more accurate and reliable 
% but this can lead to long computational time.
% 
% Compute y(t) for each time step
% 
% $${\mathit{\mathbf{y}}}_{\mathit{\mathbf{n}}} -{\mathit{\mathbf{y}}}_0 =\sum_{\mathit{\mathbf{i}}=1}^{\mathit{\mathbf{n}}} 
% {\mathit{\mathbf{a}}}_{\mathit{\mathbf{i}}} ∆\mathit{\mathbf{u}}{\left({\mathit{\mathbf{t}}}_{\mathit{\mathbf{n}}-\mathit{\mathbf{i}}} 
% \right)}$$
% 
% Thus,
% 
% $$y_5 =a_1 {∆u}_4 +a_2 {∆u}_3 +a_3 {∆u}_2 +a_4 {∆u}_1 +a_5 {∆u}_0$$
% 
% since $y_0$ is 0. 

% Compute y(t) for each time step
for t = 0:max_t
    y_t = 0; % Initialize y(t)
    
    % Calculate y(t) as the weighted sum of past 
    % step response coefficients
    for k = 0:min(t, length(data.a_i)-1)
      
        % Make sure the index for delta_u_changes is 
        % within its length
        if (t-k+1) > 0 && (t-k+1) <= length(delta_u_changes)
            y_t = y_t + data.a_i(k+1) * delta_u_changes(t-k+1); 
        end
    end
    y_calculated(t+1) = y_t;
end

%% 
% Display the results

y5 = y_calculated(6); % y at t = 5

disp(['y(5) = ', num2str(y5)]);