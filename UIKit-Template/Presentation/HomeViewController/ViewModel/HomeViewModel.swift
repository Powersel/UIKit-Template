import Foundation

protocol HomeViewModelProtocol: BaseViewModelProtocol {
  var item: BaseDTOModel { get }
  
  func openDetailsScreen()
}

final class HomeViewModel: HomeViewModelProtocol {
  @Published var item: BaseDTOModel = BaseDTOModel()
  
  private let repository: BaseRepositoryProtocol
  private let coordinator: AppCoordinator
  
  init(_ repository: BaseRepositoryProtocol = BaseRepository(),
       _ coordinator: AppCoordinator) {
    self.repository = repository
    self.coordinator = coordinator
  }
  
  func loadData() async throws {
    do {
      let dto = try await repository.fetchBaseModel()
    } catch let err {
      throw err
    }
  }
  
  func openDetailsScreen() {
    coordinator.handle(route: .details)
  }
}
