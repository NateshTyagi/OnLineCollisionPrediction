function plot( varargin )
% plot - plots a Trajectory
%
% Syntax:
%   plot(obj, timeInterval)
%
% Inputs:
%   obj - Trajectory object
%   timeInterval - TimeInterval object
%   color - Color to plot trajectory
%
% Outputs:
%   none
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none

% Author:       Manzinger Stefanie
% Written:      29-November-2016
% Last update:
%
% Last revision:---

%------------- BEGIN CODE --------------

if nargin == 1
    % plot whole trajectory
    obj = varargin{1};
    timeInterval = obj.timeInterval;
    color = [rand, rand, rand];
elseif nargin == 2
    % plot trajectory for given time interval
    obj = varargin{1};
    timeInterval = varargin{2};
    color = [rand, rand, rand];
elseif nargin == 3
    % plot trajectory for the time interval in the obstacle's color
    obj = varargin{1};
    timeInterval = varargin{2};
    color = varargin{3};
end

if(isempty(timeInterval))
    timeInterval = obj.timeInterval;
end

[idx_start, idx_end] = obj.timeInterval.getIndex(timeInterval.ts, timeInterval.tf);
if idx_start >= 1 && idx_end <= size(obj.position,2)
    plot(obj.position(1,idx_start:idx_end), obj.position(2,idx_start:idx_end), 'Color', color)
elseif idx_start >= 1 && idx_start <= size(obj.position,2)
    plot(obj.position(1,idx_start:end), obj.position(2,idx_start:end), 'Color', color)
    %plot(obj.position(1,:), obj.position(2,:), 'Color', color)
end

%------------- END CODE --------------