import Foundation

protocol DetailsRepositoryProtocol {
  func fetchDetailsModel() async throws
}

final class DetailsRepository: DetailsRepositoryProtocol {
  private let dtoParsingService: DTOParsingServiceProtocol
  private let networkService: NetworkServiceProtocol
  private let fakeNetworkService: FakeNetworkServiceProtocol
  
  init(dtoParsingService: DTOParsingServiceProtocol = DTOParsingService(), networkService: NetworkServiceProtocol = NetworkService(),
       fakeNetworkService: FakeNetworkServiceProtocol = FakeNetworkService()) {
    self.dtoParsingService = dtoParsingService
    self.networkService = networkService
    self.fakeNetworkService = fakeNetworkService
  }
  
  func fetchDetailsModel() async throws {
    do {
      let urlStr = APIEndpoint.base.path
      let data = try await networkService.fetchData(urlStr)
      let model = try dtoParsingService.parseData(data, BaseDTOModel.self)
    } catch let err {
      throw err
    }
  }
}
