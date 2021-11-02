import UIKit
import Infra

extension RootController {

    static let urlSession = URLSession(configuration: .default)
}

extension RootController: HTTPClient {

    func request<T: Decodable>(_ message: HTTPRequest) async throws -> T {
        let result = await request(message.toURLRequest())
        switch result {
        case let .success(data):
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                if let response = try? JSONDecoder().decode(HTTPResponse.self, from: data) {
                    throw response
                } else {
                    throw error
                }
            }
        case let .failure(error):
            handle(error)
            throw HTTPResponse.ok
        }
    }

    func request(_ message: URLRequest) async -> Result<Data, URLError> {
        return await withCheckedContinuation { continuation in
            RootController.urlSession.dataTask(with: message) { data, _, error in
                if let data = data {
                    continuation.resume(returning: .success(data))
                }
                if let error = error as? URLError {
                    continuation.resume(returning: .failure(error))
                }
            }.resume()
        }
    }

    func handle(_ error: URLError) {
        let ac = UIAlertController(
            title: "URL Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        present(ac, animated: true)
    }
}
