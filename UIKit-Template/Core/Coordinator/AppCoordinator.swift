import UIKit

protocol AppCoordinator {
  func start()
  func handle(route: AppRoute)
  func handleBackAction()
}

final class MainCoordinator: AppCoordinator {
  private let window: UIWindow
  private let navigationController: UINavigationController
  
  init(window: UIWindow) {
    self.window = window
    self.navigationController = UINavigationController()
  }
  
  func start() {
    let homeViewController = HomeFactory.makeHomeScreen(self)
    navigationController.viewControllers = [homeViewController]
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
  
  func handle(route: AppRoute) {
    switch route {
    case .home:
      break
    case .details:
      let detailsScreen = DetailsFactory.makeDetailsScreen(self)
      navigationController.pushViewController(detailsScreen, animated: true)
    }
  }
  
  func handleBackAction() {
    navigationController.popViewController(animated: true)
  }
}
