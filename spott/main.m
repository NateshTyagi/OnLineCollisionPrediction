% main - Set-Based Occupancy Prediction
%
% Syntax:
%   main()
%
% Inputs:
%   none
% User input is defined within the code below:
%       inputFile - input file (in XML format)
%       time intervals - time stamps for the prediction and visualization
%
% Outputs:
%   perception - object that contains a map with obstacles and their
%                occupancies
%
% Other m-files required:
% Subfunctions:
% MAT-files required:
%
% See also: M. Koschi and M. Althoff, 2017, SPOT: A Tool for Set-Based
% Prediction of Traffic Participants; and
% M. Althoff and S. Magdici, 2016, Set-Based Prediction of Traffic
% Participants on Arbitrary Road Networks

% Author:       Markus Koschi
% Written:      06-September-2016
% Last update:  08-June-2017
%
% Last revision:---

%------------- BEGIN CODE --------------


%% --- Preliminaries ---

clc;
clear;
close all;
tStart = cputime;

%% --- User Settings ---

% define the input file for the traffic scenario
% scenarios of CommonRoad:
% inputFile = 'scenarios/USA_Lanker-1_1_S-1.xml';
% inputFile = 'scenarios/NGSIM_US101_0.xml';
% inputFile = 'scenarios/ARG_Carcarana-10_4_T-1.xml';
% inputFile = 'spot/scenarios/USA_Peach-4_1_T-1.xml';
% inputFile = 'spot/scenarios/USA_Peach-4_1_T-1.xml'
% inputFile = 'spot/scenarios/road.xml';
% inputFile = 'scenarios/NGSIM_US101_5.xml';
% inputFile = 'scenarios/GER_A9_2a.xml';
% inputFile = 'scenarios/GER_B471_1.xml';
% inputFile = 'spot/scenarios/GER_Ffb_1.xml';
% inputFile = 'spot/scenarios/GER_Gar_1.xml';
inputFile = 'scenarios/GER_Muc_3a.xml';
% inputFile = 'scenarios/GER_Muc_2.xml';
% inputFile = 'scenarios/GER_A9_1a.xml';
% other examples:
% inputFile = 'spot/scenarios/Intersection_Leopold_Hohenzollern_v3.osm';
% inputFile = 'spot/scenarios/Fuerstenfeldbruck_T_junction.osm';
% inputFile = 'spot/scenarios/2lanes_same_merging_1vehicle_egoVehicle.osm';
% inputFile = 'spot/scenarios/2lanes_same_merging_2vehicles.osm';


% time interval of the scenario (step along trajectory of obstacles)
% (if ts == [], scenario will start at its beginning;
% if tf == [], scenario will run only for one time step)
% ToDO: tf to run the scenario until its end
ts_scenario = [];
% (dt_scenario is defined by given trajectory)
tf_scenario = [];

% time interval in seconds for prediction of the occupancy
ts_prediction = 0;
dt_prediction = 0.2;
tf_prediction = 10.0;

% time interval in seconds for visualization
ts_plot = ts_prediction;
dt_plot = dt_prediction;
tf_plot = tf_prediction;

% define whether trajectory shall be verified (i.e. checked for collision)
verify_trajectory = true;

% define output
writeOutput = false;


%% --- Set-up Perception ---

% create perception from input (holding a map with all lanes, adjacency
% graph and all obstacles)
perception = globalPck.Perception(inputFile, ts_scenario);

% create time interval for occupancy calculation
timeInterval_prediction = globalPck.TimeInterval(ts_prediction, dt_prediction, tf_prediction);

% plot initial configuration
if globalPck.PlotProperties.SHOW_INITAL_CONFIGURATION
    figure('Name','Initial configuration')
    perception.plot();
    if globalPck.PlotProperties.PRINT_FIGURE
        saveas(gcf,'Initial configuration','epsc')
    end
end

%% --- Main code ---

% dynamic scenario: for each time step of trajectory, do occupancy prediction
[ts_trajectory, dt_trajectory, tf_trajectory] = perception.map.obstacles(1).trajectory.timeInterval.getTimeInterval();
if isempty(tf_scenario)
    tf = perception.time;
else
    tf = tf_scenario - perception.map.timeStepSize;
end

for time = perception.time:perception.map.timeStepSize:tf
    
    % --- time step forward for all dynamic objects (update perception) ---
    if time ~= perception.time
        perception.update(time);
        %perception.step()
    end
    
%     --- add trajectory of the ego vehicle (if not yet incuded in the
%     scenario) ---
%     perception.map.egoVehicle.trajectory.setTrajectory([0, 0.1, 10.0], 0, 0, 135, 0, 0);   % default values = (t, x, y, theta, v, a);
    
    % --- do occupancy calculation ---
    perception.computeOccupancyGlobal(timeInterval_prediction);
    
    % --- collision check ---
    if verify_trajectory
        [collision_flag, collision_time, collision_obstacle] = perception.checkOccupancyCollision();
        if collision_flag
            disp(['collision at ',num2str(collision_time), ' seconds with obstacle ', num2str(collision_obstacle.id)]);
        else
            disp('Trajectory is collision-free. Formally verified by SPOT.');
        end
    end
    
    % --- Plot the perception (all lanes and all obstacles incl. occupancies) ---
    % create time interval for plot
    timeInterval_plot = globalPck.TimeInterval(ts_plot, dt_plot, tf_plot);
    
    % do plot
    figure('Name', 'Perception and Prediction')
    perception.plot(timeInterval_plot)
    if globalPck.PlotProperties.PRINT_FIGURE
        saveas(gcf,'Perception and Prediction','epsc')
    end
    
    % --- Plot the occupancy step by step (snapshots) ---
    if globalPck.PlotProperties.PLOT_OCC_SNAPSHOTS
        for t = ts_plot:dt_plot:(tf_plot-dt_plot)
            % create time interval for plot
            timeInterval_plot = globalPck.TimeInterval(ts_plot+t, dt_plot, ts_plot+t+dt_plot);
            
            % do plot
            name_plot = ['Occ_Snapshot_at_' num2str(t)]; %['Occ_Snapshot_' num2str(i)];
            figure('Name',name_plot)
            perception.plot(timeInterval_plot)
            
            if globalPck.PlotProperties.PRINT_FIGURE
                saveas(gcf,name_plot,'epsc')
            end
        end
    end
    
end

%% --- Output ---
if writeOutput    
    % save the map in an XML file (polygons are not triangulated)
    % (exportType: 1 = trajectory, 2 = occupancy set, 3 = probabilityDistribution)
    output.writeToXML(perception.map, 'testOutput.xml', 2);
end

tEnd = cputime - tStart
%------------- END CODE --------------