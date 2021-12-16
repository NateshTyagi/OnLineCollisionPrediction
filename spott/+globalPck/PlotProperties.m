classdef (Abstract) PlotProperties < handle
    % PlotProperties - abstract class that globally defines properties for
    % plotting class objects
    %
    % Syntax:
    %   no object constructor
    %
    % Other m-files required: none
    % Subfunctions: none
    % MAT-files required: none
    
    % Author:       Markus Koschi
    % Written:      15-November-2016
    % Last update:  16-August-2017
    %
    % Last revision:---
    
    %------------- BEGIN CODE --------------
    
    properties (Constant, GetAccess = public)
        % general plot
        SHOW_GRID = false;   % default value is false
        SHOW_AXIS = true;
        SHOW_INITAL_CONFIGURATION = true;
        PLOT_OCC_SNAPSHOTS = false;     % default value = false
        PLOT_DYNAMIC = false;        % default value = false
        PRINT_FIGURE = false;        % default value = false
        FACE_TRANSPARENCY = 0.1;%1;%0.2;%0;  % (of occupancies)
        
        % lanes and lanelets
        SHOW_LANES = true;
        SHOW_LANE_NAMES = false;
        SHOW_LANE_BORDER_VERTICES = false;       % default value = false
        SHOW_LANE_BORDER_VERTICES_NUMBERS = false;
        SHOW_LANE_CENTER_VERTICES = false;
        SHOW_LANE_FACES = false;         % default value = false
        
        % obstacles
        SHOW_OBJECT_NAMES = true;
        SHOW_OBSTACLES = true;
        SHOW_TRAJECTORY_OCCUPANCIES = false;
        SHOW_PREDICTED_OCCUPANCIES = true;
        SHOW_OBSTACLES_CENTER = true;           % default value = false
        SHOW_TRAJECTORIES = true;       % default value = false
        COLOR_OBSTACLES = ['c', 'b', 'r', 'g', 'y', 'm'];
        COLOR_OBSTACLES_STATIC = [0.5 0.5 0.5];
        
        % ego vehicle
        SHOW_EGO_VEHICLE = true;
        SHOW_TRAJECTORIES_EGO = true;
        SHOW_TRAJECTORY_OCCUPANCIES_EGO = true;     % default value = false
        SHOW_PREDICTED_OCCUPANCIES_EGO = true;      % default value = false
        SHOW_GOALREGION = true;
        COLOR_EGO_VEHICLE = [0 0 0];
        COLOR_TRAJECTORY_OCCUPANCIES_EGO = [1 1 0];
    end
end

%------------- END CODE --------------