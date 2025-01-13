cmake_minimum_required(VERSION 3.5)
project(problem_5)


find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(rclcpp_action REQUIRED)
find_package(plansys2_msgs REQUIRED)
find_package(plansys2_executor REQUIRED)

set(CMAKE_CXX_STANDARD 17)

set(dependencies
    rclcpp
    rclcpp_action
    plansys2_msgs
    plansys2_executor
)

add_executable(move_node src/move_node.cpp)
ament_target_dependencies(move_node ${dependencies})

add_executable(move_carrier_node src/move_carrier_node.cpp)
ament_target_dependencies(move_carrier_node ${dependencies})

add_executable(fly_carrier_node src/fly_carrier_node.cpp)
ament_target_dependencies(fly_carrier_node ${dependencies})

add_executable(load_carrier_node src/load_carrier_node.cpp)
ament_target_dependencies(load_carrier_node ${dependencies})

add_executable(accompany_node src/accompany_node.cpp)
ament_target_dependencies(accompany_node ${dependencies})

add_executable(move_carrier_shield_node src/move_carrier_shield_node.cpp)
ament_target_dependencies(move_carrier_shield_node ${dependencies})

add_executable(move_shield_node src/move_shield_node.cpp)
ament_target_dependencies(move_shield_node ${dependencies})

add_executable(start_accompany_node src/start_accompany_node.cpp)
ament_target_dependencies(start_accompany_node ${dependencies})

add_executable(unload_carrier_node src/unload_carrier_node.cpp)
ament_target_dependencies(unload_carrier_node ${dependencies})

install(DIRECTORY launch pddl DESTINATION share/${PROJECT_NAME})

install(TARGETS
  move_node
  move_carrier_node
  fly_carrier_node
  load_carrier_node
  accompany_node
  move_carrier_shield_node
  move_shield_node
  start_accompany_node
  unload_carrier_node
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION lib/${PROJECT_NAME}
)

ament_export_dependencies(${dependencies})

ament_package()