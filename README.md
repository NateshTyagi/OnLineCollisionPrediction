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
* Change the value of verify_trajectory to true to check for collisions between traffic participants. 

      verify_trajectory = false;
