import Foundation

protocol HomeViewModelProtocol: BaseViewModelProtocol {
  var item: BaseDTOModel { get }
}

final class HomeViewModel: HomeViewModelProtocol {
  @Published var item: BaseDTOModel = BaseDTOModel()
  
  private let repository: BaseRepositoryProtocol
  
  init(repository: BaseRepositoryProtocol = BaseRepository()) {
    self.repository = repository
  }
  
  func loadData() async throws {
    do {
      let dto = try await repository.fetchBaseModel()
    } catch let err {
      throw err
    }
  }
}
