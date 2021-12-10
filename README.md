# On-line collision prediction for AV

### How to run
* Open a terminal
* Clone SPOT's repository in your local workstation:

      git clone https://gitlab.com/koschi/spot.git
* Download the following two scenarios:

      https://gitlab.lrz.de/tum-cps/commonroad-scenarios/-/blob/Release_2017a/hand-crafted/GER_A9_1a.xml
      https://gitlab.lrz.de/tum-cps/commonroad-scenarios/-/blob/Release_2017a/hand-crafted/GER_Muc_3a.xml

* Navigate to the scenarios folder inside of SPOT repository from root directory

      cd ~/spot/scenarios/
* Move the two downloaded scenarios inside this folder
* In your terminal

      matlab
* Open main.m file
* In the user settings section of the main.m file, put this command:

      inputFile = 'scenarios/GER_A9_1a.xml';
      inputFile = 'scenarios/GER_A9_1a.xml';
* Run one at a time, commenting out the other.
* Change the value of verify_trajectory to _**true**_ to check for collisions between traffic participants. 

      verify_trajectory = false;
* Uncomment this line

      perception.map.egoVehicle.trajectory.setTrajectory(t, x, y, theta, v, a);
* The parameter _t_ is an array consisting of three values: [ts, dt, tf]
  - ts : Initial time to start occupancy prediction (better to start from 0)
  - dt : Time step-size (0.1 is a good value for accuracy)
  - tf : Time upto which predicition is to be done.
  - x, y : Initial coordinates of the egoVehicle
  - v : Initialize this 53.33
  - a : Initialize this as 2
* Navigate to the **_globalPck_** folder of SPOT, open **_PlotProperties.m_**
* Change the value of these parameters of these variables to _**true**_

        SHOW_INITAL_CONFIGURATION = true;
        PLOT_DYNAMIC = false;        
        SHOW_LANES = false;
        SHOW_OBJECT_NAMES = false;
        SHOW_OBSTACLES = false;
        SHOW_TRAJECTORY_OCCUPANCIES = false;
        SHOW_PREDICTED_OCCUPANCIES = false;
        SHOW_OBSTACLES_CENTER = false;          
        SHOW_TRAJECTORIES = false;      
        SHOW_EGO_VEHICLE = false;
        SHOW_TRAJECTORIES_EGO = false;
        SHOW_TRAJECTORY_OCCUPANCIES_EGO = false;     
        SHOW_PREDICTED_OCCUPANCIES_EGO = false;      
        SHOW_GOALREGION = false;
