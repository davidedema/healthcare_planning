<p align='center'>
    <h1 align="center">Healthcare planning</h1>
    <p align="center">
    Project for Automated Planning at the University of Trento A.Y.2024/2025
    </p>
    <p align='center'>
    Developed by:<br>
    De Martini Davide <br>
    Steyn Mulder <br>
    </p>   
</p>

----------

- [Project Description](#project-description)
- [Installation](#installation)
  - [Remarks for problem 5](#remarks-for-problem-5)
- [Running the project](#running-the-project)
  - [Problem 1/2](#problem-12)
  - [Problem 3](#problem-3)
  - [Problem 4](#problem-4)
  - [Problem 5](#problem-5)


## Project Description
The aim of this project is twofold. First to model an healtcare
planning problems in PDDL/HDDL to then invoke a state
of the art planner as those provided by planutils. Second, to see how a temporal planning model
could be integrated within a robotic setting leveraging
the PlanSys2.

## Installation

Clone the repository
```
git clone https://github.com/davidedema/automated_planning.git
```
In order to run the project you'll need to clone it and install planutils. For this sake we suggest to use the Dockerfile provided in the repository
```
docker build . -t healthcare_planning:v1
```
Then for running it just use
```
docker run -it --privileged healthcare_planning:v1
```
When in, clone the repository and commit the docker image 
```
docker ps
```
copy container_id
```
docker commit <container_id> healthcare_planning:v1
```
### Remarks for problem 5
In order to run problem 5 you will need to have [ROS2](https://docs.ros.org/en/humble/Installation.html) humble and [PlanSys2](https://plansys2.github.io/) installed (use the official instruction for installing them). 
## Running the project

For running the project different planners are used:
### Problem 1/2
Enter the docker container and activate the planutils environment
```
planutils activate
```
Then run 
```
ff domain.pddl problem <1−4>.pddl
```
```
downward --alias seq-sat-fdss-2023 --overall-time-limit 60s domain.pddl problem<1-4>.pddl
```
```
scorpion --alias seq-sat-fdss-2023 --overall-time-limit 60s domain.pddl problem<1-4>.pddl
```
### Problem 3
```
java -jar PANDA.jar -parser hddl domain.hddl problem<1-4>.hddl
```
### Problem 4
```
tfd domain.pddl problem<1-4>.pddl 
optic domain.pddl problem<1-4>.pddl 
```
### Problem 5
Build the ROS2 workspace and source it
```
colcon build && source instal/setup.bash
```
Launch the infrastructure
```
ros2 launch problem_5 start.launch.py 
```
On a new terminal open an instance of plansys2 terminal
```
ros2 run plansys2_terminal plansys2_terminal
```
Source the problem in the terminal
```
source /path/to/problem
```
Then for retriving the plan and running it
```
run
```