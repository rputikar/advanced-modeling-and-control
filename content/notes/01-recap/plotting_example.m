%% Demonstration of plotting functions in MATLAB

% Sample data
x = linspace(0, 2*pi, 100);
y1 = sin(x);
y2 = cos(x);

%% Basic Plot
% Various line types, plot symbols and colors may be obtained with
% plot(X,Y,S) where S is a character string made from one element from
% any or all the following 3 columns:
%
% Color       | Marker              | Line Style
% ------------|---------------------|--------------------
% b = blue    | . = point           | -   = solid
% g = green   | o = circle          | :   = dotted
% r = red     | x = x-mark          | -.  = dashdot
% c = cyan    | + = plus            | --  = dashed
% m = magenta | * = star            | (none) = no line
% y = yellow  | s = square          |
% k = black   | d = diamond         |
% w = white   | v = triangle (down) |
%             | ^ = triangle (up)   |
%             | < = triangle (left) |
%             | > = triangle (right)|
%             | p = pentagram       |
%             | h = hexagram        |

figure
plot(x, y1, 'b-', 'LineWidth', 2);     % plot sin(x)
hold on                                % retain the plot

%% Add another plot
plot(x, y2, 'r--', 'LineWidth', 2);    % plot cos(x)
hold off

%% Customize appearance
axis([0 2*pi -1.5 1.5]);               % set axis limits
grid on;                               % add grid
xlabel('x (radians)');                 % label x-axis
ylabel('Amplitude');                   % label y-axis
title('Sine and Cosine Waves');        % title
legend('sin(x)', 'cos(x)');            % add legend

%% Annotate the Plot
text(pi, 0, 'Zero Crossing');          % add text at (pi, 0)
% gtext('Click to place this label');  % interactive placement
