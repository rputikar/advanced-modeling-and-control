% FOPDT Parameters
K = 2;      
tau = 5;    
theta = 2;  
Ts = 1;     
n = 10;     

% Calculate step response coefficients

% Initialize coefficients
a = zeros(1, n); 
for i = 1:n
    t = (i-1) * Ts; 
    if t > theta
        y_t = K * (1 - exp(-(t - theta) / tau));
        a(i) = y_t;
    else
        a(i) = 0;
    end
end

% Display coefficients
disp('Step response coefficients a_i:');
disp(a);