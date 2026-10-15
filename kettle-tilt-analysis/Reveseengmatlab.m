% Torque and Force Analysis for Tilt Mechanism in our redesigned electric kettle
% Calculates the torque required to tilt the kettle and compares grip force
% requirements between traditional and our redesigned kettle

clear; clc; close all; % removes all vairbales from workspace, clears command window and closes any old open figures 
%% 1. Define System Parameters
% Kettle specifications
kettle_mass = 0.5;              % Empty kettle mass (kg)
water_mass = 1.5;               % Full water mass (kg)
total_mass = kettle_mass + water_mass;  % Total mass (kg)

% Geometric parameters
kettle_height = 0.25;           % Kettle height (m)
kettle_radius = 0.10;           % Kettle base radius (m)
handle_distance = 0.15;         % Distance from pivot to handle (m)
base_tilt_angle = 15;           % Base slant angle (degrees)

% Physical constants
g = 9.81;                       % Acceleration due to gravity (m/s^2)

%% 2. Traditional Kettle - Lifting Force Calculation
% Calculates weight force
weight_force_traditional = total_mass * g;  % Force in Newtons

% Grip force required (making an assumption for an aditional 20% for stability and handling)
grip_force_traditional = weight_force_traditional * 1.2;
%prints each result
fprintf('Traditional Kettle Analysis \n');
fprintf('Total weight: %.2f N\n', weight_force_traditional);
fprintf('Required grip force: %.2f N\n', grip_force_traditional);
% Assume 10N is max force a elderly can generate without pain or discomfort
fprintf('This exceeds safe limits for elderly with arthritis (typically < 10 N)\n\n');

%% 3. Redesigned Kettle with Tilt Mechanism calculation
% Calculate center of mass
com_height = kettle_height / 2; % Simplified Center of mass(COM) at mid-height
com_horizontal = 0.05;          % COM offset from pivot (m)

% Tilt angle range for pouring from 0 to 45 by increamrnting by 5 each time
tilt_angles = 0:5:45;           % Degrees
% Assigns the number of elements in the tilt_angles array 
% to num_angles so the loop can iterate through each angle and do the
% calculations 
num_angles = length(tilt_angles);

% Pre-allocate arrays so that when it itterates for each different angle it
% doesnt change the size of the array and storing values will be useful
% for ploting, when we need to recall values stored in arrays
torque_required = zeros(1, num_angles);
force_at_handle = zeros(1, num_angles);

% Loops through each tilt angle using num_angles as the count(runs through
% 10 total calculations for each num angle)
for i = 1:num_angles
    % Converts each angle from degrees to radians for calculations of torque and force
    theta = deg2rad(tilt_angles(i));
    
    % Torque due to weight (opposing rotation)
    torque_weight = total_mass * g * com_horizontal * cos(theta);
    
    % Required torque to maintain position
    torque_required(i) = torque_weight;
    
    % Force required at handle
    force_at_handle(i) = torque_required(i) / handle_distance;
end

% Maximum force needed to maintain constant angle while pouring
max_force_redesigned = max(force_at_handle);
%prints each result
fprintf('Redesigned Kettle with Tilt Mechanism \n');
fprintf('Maximum force at handle: %.2f N\n', max_force_redesigned);
% Calculates the force reduction and then prints the result of it, we find this by subtracting the our kettle's maximum force from the traditional
% force, dividing by the traditional force, and then multiplying by 100 to get a percent.
fprintf('Force reduction: %.1f%%\n', ...
    (grip_force_traditional - max_force_redesigned) / grip_force_traditional * 100);

%% 4. Ergonomic Handle Design - Wrist Moment calculation
% Traditional kettle moment arm calulation
wrist_distance = 0.30;          % Distance from wrist to kettles Center Of Mass (m)
wrist_moment_traditional = weight_force_traditional * wrist_distance;

% our kettle should have a reduced moment due to the built in tilt mechanism
wrist_moment_redesigned = max_force_redesigned * 0.10;  % Reduced moment arm
%prints each result
fprintf('\n=== Wrist Moment Comparison ===\n');
fprintf('Traditional wrist moment: %.2f N·m\n', wrist_moment_traditional);
fprintf('Redesigned wrist moment: %.2f N·m\n', wrist_moment_redesigned);
% Calculates the moment arm reduction and then prints the result of it, we find this by subtracting the our kettle's moment arm from the traditional
% moment arm, dividing by the traditional moment arm, and then multiplying by 100 to get a percent.
fprintf('Moment reduction: %.1f%%\n\n', ...
    (wrist_moment_traditional - wrist_moment_redesigned) / wrist_moment_traditional * 100);

%% 5. Visualization - Force vs. Tilt Angle
% Creates a figure window 100 pixels from the left and bottom edges of the screen,
% with an window size of 800 pixels wide by 600 pixels tall.
% This determines where the figure appears as well as the dimensions
figure('Position', [100, 100, 800, 600]);
%makes sure the plot appears in the top half of the screen allwoing space for second plot
subplot(2,1,1)
%plots stored values in the arrays from the force required at the handle calcultion in blue 
plot(tilt_angles, force_at_handle, 'b-', 'LineWidth', 2);
hold on;
%shows regualr grip force curve in a red dotted line
yline(grip_force_traditional, 'r--', 'Traditional Lifting Force', 'LineWidth', 1.5);
%shows the assusmed safe limit in a green dotted line
yline(10, 'g--', 'Safe Force Limit (Elderly)', 'LineWidth', 1.5);
xlabel('Tilt Angle (degrees)');%label for x axis
ylabel('Force Required (N)');%label for y axis
title('Force Required at Handle vs. Tilt Angle');%title for graph 1
grid on;
legend('Redesigned Kettle', 'Traditional Kettle', 'Safe Limit'); %legend showing what each line on the graph is for
% makes sure plot appears in the bottom half of the figure window
subplot(2,1,2)
%plots stored values in the arrays from the torque required caculation
plot(tilt_angles, torque_required, 'b-', 'LineWidth', 2);
xlabel('Tilt Angle (degrees)');%label for x axis
ylabel('Torque Required (N·m)');%label for y axis
title('Torque Required to Maintain Position vs. Tilt Angle');%title for graph 2
grid on;

%% 6. Safety Factor calculation
safety_limit_elderly = 10;      % Assumed maximum safe force for elderly (N)
%if the saftey factor is more then 1 that means the max force from the
%redesign is less then the assumed force an elderly can generate before
%discomfort so if true makes our redesign safer then the traditional
%kettles
safety_factor_redesigned = safety_limit_elderly / max_force_redesigned;

fprintf('Safety Analysis \n');
fprintf('Safety factor for redesigned kettle: %.2f\n', safety_factor_redesigned);
if safety_factor_redesigned > 1 % if our saftey factor calculation outputs more then 1 then it prints the the first statement since its true 
    % otherwise prints the other statement sicne its false
    fprintf('Design is SAFE for elderly users\n');
else
    fprintf('Design needs improvement\n');
end

%% 7. sumaary of results
fprintf('\n Summary \n');
fprintf('Force reduction: %.1f%%\n', ...
    (grip_force_traditional - max_force_redesigned) / grip_force_traditional * 100);
fprintf('Wrist moment reduction: %.1f%%\n', ...
    (wrist_moment_traditional - wrist_moment_redesigned) / wrist_moment_traditional * 100);
fprintf('Design meets accessibility requirements: %s\n', ...
    string(max_force_redesigned < safety_limit_elderly));
%prints all previous results in one section