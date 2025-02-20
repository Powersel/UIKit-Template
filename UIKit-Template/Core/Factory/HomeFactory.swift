import UIKit

struct HomeFactory {
  static func makeHomeScreen(_ coordinator: AppCoordinator) -> UIViewController {
    let viewModel = HomeViewModel(BaseRepository(), coordinator)
    return HomeViewController(viewModel)
  }
}

