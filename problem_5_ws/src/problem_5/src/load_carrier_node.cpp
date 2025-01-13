#include <algorithm>
#include <memory>

#include "plansys2_executor/ActionExecutorClient.hpp"
#include "rclcpp/rclcpp.hpp"
#include "rclcpp_action/rclcpp_action.hpp"

using namespace std::chrono_literals;

class LoadCarrier : public plansys2::ActionExecutorClient {
 public:
  double duration;
  
  LoadCarrier()
      : plansys2::ActionExecutorClient(
            "load_carrier",
            100ms) {
    progress_ = 0.0;
  }

 private:
  void do_work() {
    if (progress_ < 1.0) {
      progress_ += 1 / (duration * 1000 / 100);
      send_feedback(progress_, "load carrier running");
    } else {
      finish(true, 1.0, "load carrier completed");

      progress_ = 0.0;
      std::cout << std::endl;
    }

    std::cout << "\r\e[K" << std::flush;
    std::cout << "Requesting for load carrier ... ["
              << std::min(100.0, progress_ * 100.0) << "%]  " << std::flush;
  }

  float progress_;
};

int main(int argc, char** argv) {
  rclcpp::init(argc, argv);
  auto node = std::make_shared<LoadCarrier>();
  node->declare_parameter("duration", 3.0);
  node->duration = node->get_parameter("duration").as_double();
  node->set_parameter(rclcpp::Parameter("action_name", "load_carrier"));
  node->trigger_transition(
      lifecycle_msgs::msg::Transition::TRANSITION_CONFIGURE);

  rclcpp::spin(node->get_node_base_interface());

  rclcpp::shutdown();

  return 0;
}