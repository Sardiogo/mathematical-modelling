function [time, x] = EulerMethod(x0, t0, h, final_time, f)
    %[ time, x] = EulerMethod(x0, t0, h, final_time, f(x))

    % Set time vector
    time = (t0:h:final_time);

    % Initialize solution vector
    x = zeros(size(time));
    x(1) = x0;

    % Euler integration cycle
    for counter = 1:length(time)-1
        x(counter+1) = x(counter) + h * f(x(counter));
    end

end