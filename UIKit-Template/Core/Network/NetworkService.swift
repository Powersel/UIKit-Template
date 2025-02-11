import Foundation

enum NetworkError: Error {
  case missingURL
  case invalidURLComponents
  case invalidStatusCode(Int)
  
  /// Localizations for each error.
  var localizedDescription: String {
    switch self {
    case .invalidURLComponents:
      return "Invalid URL components"
    case .missingURL:
      return "Missing URL."
    case .invalidStatusCode(let statusCode):
      return "Request was not successfull. Finished with: \(statusCode) code."
    }
  }
}

protocol NetworkServiceProtocol {
  // Simple "GET" request, without extra parameters
  func fetchData(_ urlStr: String) async throws -> Data
  
  // "GET" request, with extra parameters
  func fetchData(_ urlStr: String, parameters: [String: String]) async throws -> Data
  
  // "POST" request, with extra parameters
  func postData(_ urlStr: String, parameters: [String: String]) async throws -> Data
  
  // "POST" request, with extra parameters and Void responce
  func postData(_ urlStr: String, parameters: [String: String]) async throws
}

final class NetworkService {
  private let urlSession: URLSession
  private let defaultSessionInterval: TimeInterval = 15
  
  private var showRawDataStructure: Bool = false
  
  init() {
    let sessionConfig = URLSessionConfiguration.default
    sessionConfig.timeoutIntervalForRequest = defaultSessionInterval
    
    self.urlSession = URLSession(configuration: sessionConfig)
  }
  
  private func constructURL(_ urlStr: String, _ parameters: [String: String] = [:]) throws -> URL {
    guard var components = URLComponents(string: urlStr) else {
      throw NetworkError.missingURL
    }
    
    components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    
    guard let url = components.url else {
      throw NetworkError.invalidURLComponents
    }
    
    return url
  }
  
  private func processRequest(_ request: URLRequest) async throws -> Data {
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
      throw NetworkError.invalidStatusCode((response as? HTTPURLResponse)?.statusCode ?? -1)
    }
    
    printRawData(data)
    
    return data
  }
  
  private func printRawData(_ data: Data) {
    if !showRawDataStructure { return }
    print(String(data: data, encoding: .utf8)!)
  }
}

extension NetworkService: NetworkServiceProtocol {
  
  func fetchData(_ urlStr: String) async throws -> Data {
    guard let url = URL(string: urlStr) else { throw NetworkError.missingURL }
    
    do {
      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "GET"
      let data = try await processRequest(urlRequest)
      
      return data
    } catch {
      throw NetworkError.invalidStatusCode(400)
    }
  }
  
  func fetchData(_ urlStr: String, parameters: [String: String]) async throws -> Data {
    do {
      let url = try constructURL(urlStr, parameters)
      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "GET"
      let data = try await processRequest(urlRequest)
      
      return data
    } catch {
      throw NetworkError.invalidStatusCode(400)
    }
  }
  
  func postData(_ urlStr: String, parameters: [String : String]) async throws -> Data {
    do {
      let url = try constructURL(urlStr, parameters)
      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "POST"
      let data = try await processRequest(urlRequest)
      return data
    } catch {
      throw NetworkError.invalidStatusCode(400)
    }
  }
  
  func postData(_ urlStr: String, parameters: [String: String]) async throws {
    do {
      let url = try constructURL(urlStr, parameters)
      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "POST"
      _ = try await processRequest(urlRequest)
    } catch {
      throw NetworkError.invalidStatusCode(400)
    }
  }
}
