import Foundation

protocol HomeViewModelProtocol: BaseViewModelProtocol {
  var item: BaseDTOModel { get }
  var state: ViewModelState { get }
  
  func openDetailsScreen()
}

final class HomeViewModel: HomeViewModelProtocol {
  @Published var item: BaseDTOModel = BaseDTOModel()
  
  private let repository: BaseRepositoryProtocol
  private let coordinator: AppCoordinator
  private(set) var state: ViewModelState = .idle
  
  init(_ repository: BaseRepositoryProtocol = BaseRepository(),
       _ coordinator: AppCoordinator) {
    self.repository = repository
    self.coordinator = coordinator
  }
  
  func loadData() async throws {
    if state == .loading { return }
    do {
      let dto = try await repository.fetchBaseModel()
      state = .loaded
    } catch let err {
      state = .error(err)
      throw err
    }
  }
  
  func openDetailsScreen() {
    coordinator.handle(route: .details)
  }
}
