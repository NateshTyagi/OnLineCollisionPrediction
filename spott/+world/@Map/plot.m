function plot(varargin)
% plot - plots a Map object
%
% Syntax:
%   plot(obj, timeInterval)
%
% Inputs:
%   obj - Map object
%   timeInterval - TimeInterval object
%
% Outputs:
%   none
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

if nargin == 1
    % plot the map for the current time
    obj = varargin{1};
    timeInterval = globalPck.TimeInterval.empty();
elseif nargin == 2
    % plot the map for the time interval
    obj = varargin{1};
    timeInterval = varargin{2};
end

% plot all obstacles of map object (which are set at the current time)
if globalPck.PlotProperties.SHOW_OBSTACLES
    for i = 1:numel(obj.obstacles)
        if isa(obj.obstacles(i), 'world.StaticObstacle') || ...
                ~isempty(obj.obstacles(i).time)
            obj.obstacles(i).plot(timeInterval);
        end
    end
end

% plot all ego vehicles of map object
if globalPck.PlotProperties.SHOW_EGO_VEHICLE
    obj.egoVehicle(:).plot(timeInterval);
end

% plot all lanes of map object
if globalPck.PlotProperties.SHOW_LANES
    obj.lanes(:).plot();
end
end

%------------- END CODE --------------