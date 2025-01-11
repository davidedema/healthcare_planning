import os

from ament_index_python.packages import get_package_share_directory

from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node

MOVE_DURATION = 1.0

def generate_launch_description():
    # Get the launch directory
    example_dir = get_package_share_directory('problem_5')
    namespace = LaunchConfiguration('namespace')

    declare_namespace_cmd = DeclareLaunchArgument(
        'namespace',
        default_value='',
        description='Namespace')

    plansys2_cmd = IncludeLaunchDescription(
        PythonLaunchDescriptionSource(os.path.join(
            get_package_share_directory('plansys2_bringup'),
            'launch',
            'plansys2_bringup_launch_monolithic.py')),
        launch_arguments={
            'model_file': example_dir + '/pddl/domain.pddl',
            'namespace': namespace,
        }.items())

    move_cmd = Node(
        package='problem_5',
        executable='move_node',
        name='move_node',
        namespace=namespace,
        output='screen',
        parameters=[{
            "duration": MOVE_DURATION,
        }]
        )
    
    move_carrier_cmd = Node(
        package='problem_5',
        executable='move_carrier_node',
        name='move_carrier_node',
        namespace=namespace,
        output='screen',
        # parameters=[{
        #     "duration": MOVE_DURATION,
        # }]
        )
    
    fly_carrier_cmd = Node(
        package='problem_5',
        executable='fly_carrier_node',
        name='fly_carrier_node',
        namespace=namespace,
        output='screen',
        # parameters=[{
        #     "duration": MOVE_DURATION,
        # }]
        )
    
    move_shield_cmd = Node(
        package='problem_5',
        executable='move_shield_node',
        name='move_shield_node',
        namespace=namespace,
        output='screen',
        # parameters=[{
        #     "duration": MOVE_DURATION,
        # }]
        )
    
    move_carrier_shield_cmd = Node(
        package='problem_5',
        executable='move_carrier_shield_node',
        name='move_carrier_shield_node',
        namespace=namespace,
        output='screen',
        # parameters=[{
        #     "duration": MOVE_DURATION,
        # }]
        )
    
    load_carrier_cmd = Node(
        package='problem_5',
        executable='load_carrier_node',
        name='load_carrier_node',
        namespace=namespace,
        output='screen',
        # parameters=[{
        #     "duration": MOVE_DURATION,
        # }]
        )
    
    unload_carrier_cmd = Node(
        package='problem_5',
        executable='unload_carrier_node',
        name='unload_carrier_node',
        namespace=namespace,
        output='screen',
        # parameters=[{
        #     "duration": MOVE_DURATION,
        # }]
        )
    
    start_accompany_cmd = Node(
        package='problem_5',
        executable='start_accompany_node',
        name='start_accompany_node',
        namespace=namespace,
        output='screen',
        # parameters=[{
        #     "duration": MOVE_DURATION,
        # }]
        )
    
    accompany_cmd = Node(
        package='problem_5',
        executable='accompany_node',
        name='accompany_node',
        namespace=namespace,
        output='screen',
        # parameters=[{
        #     "duration": MOVE_DURATION,
        # }]
        )

    ld = LaunchDescription()

    ld.add_action(declare_namespace_cmd)
    # Declare the launch options
    ld.add_action(plansys2_cmd)

    # Add nodes for robot1
    ld.add_action(move_cmd)
    ld.add_action(move_carrier_cmd)
    ld.add_action(fly_carrier_cmd)
    ld.add_action(move_shield_cmd)
    ld.add_action(move_carrier_shield_cmd)
    ld.add_action(load_carrier_cmd)
    ld.add_action(unload_carrier_cmd)
    ld.add_action(start_accompany_cmd)
    ld.add_action(accompany_cmd)

    return ld