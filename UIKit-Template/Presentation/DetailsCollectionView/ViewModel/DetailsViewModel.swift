import Foundation

protocol DetailsViewModelProtocol: BaseViewModelProtocol {
  
}

final class DetailsViewModel: DetailsViewModelProtocol {
  private(set) var state: ViewModelState
  
  private let coordinator: AppCoordinator
  private let repository: DetailsRepositoryProtocol
  
  init(_ state: ViewModelState = .idle,
       _ coordinator: AppCoordinator,
       _ repository: DetailsRepositoryProtocol) {
    self.state = state
    self.coordinator = coordinator
    self.repository = repository
  }
  
  func loadData() async throws {
    do {
      try await repository.fetchDetailsModel()
    } catch {
      
    }
  }
}
