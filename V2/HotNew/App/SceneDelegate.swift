import UIKit
import Infra
import HotNew

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = HotNewBusinessController(businessDelegate: self)
        window.makeKeyAndVisible()
        self.window = window
    }
}

extension SceneDelegate: HotNewBusinessDelegate {

    func request<T: Decodable>(_ message: HTTPRequest) async throws -> T {
        /// Mocking
        let topics: [Topic] = [.mock, .mock]
        if let t = topics as? T {
            return t
        }

        let result = await URLSession.shared.request(message.toURLRequest())
        switch result {
        case let .success(data):
            return try JSONDecoder().decode(T.self, from: data)
        case let .failure(error):
            throw error
        }
    }
}
