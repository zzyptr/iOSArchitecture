import UIKit
import Infra

extension RootController {

    static let urlSession = URLSession(configuration: .default)
}

extension RootController: HTTPClient {

    func request<T: Decodable>(_ message: HTTPRequest) async throws -> T {
        let result = await RootController.urlSession.request(message.toURLRequest())
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

    func handle(_ error: URLError) {
        let ac = UIAlertController(
            title: "URL Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        present(ac, animated: true)
    }
}
