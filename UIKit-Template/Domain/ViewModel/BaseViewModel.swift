import Foundation

protocol BaseViewModelProtocol {
  func loadData() async throws
}

final class BaseViewModel: BaseViewModelProtocol {
  
  private let repository: BaseRepositoryProtocol
  
  init(repository: BaseRepositoryProtocol = BaseRepository()) {
    self.repository = repository
  }
  
  func loadData() async throws {
    
  }
}
