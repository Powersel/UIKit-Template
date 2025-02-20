import Foundation

protocol BaseViewModelProtocol {
  func loadData() async throws
  
  var state: ViewModelState { get }
}

final class BaseViewModel: BaseViewModelProtocol {
  
  private let repository: BaseRepositoryProtocol
  private(set) var state: ViewModelState = .idle
  
  init(repository: BaseRepositoryProtocol = BaseRepository()) {
    self.repository = repository
  }
  
  func loadData() async throws {
    
  }
}
