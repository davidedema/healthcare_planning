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

    example_node = Node(
        package='problem_5',
        executable='example_node',
        name='example_node',
        namespace=namespace,
        output='screen',
        parameters=[{
            "duration": MOVE_DURATION,
        }])

    ld = LaunchDescription()

    ld.add_action(declare_namespace_cmd)
    # Declare the launch options
    ld.add_action(plansys2_cmd)

    # Add nodes for robot1
    ld.add_action(example_node)

    return ld