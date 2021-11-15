import UIKit
import Infra
import HotNew

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        HTTPRequest.defaultHost = "www.v2ex.com"

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = HotNewBusinessController(businessDelegate: self)
        window.makeKeyAndVisible()
        self.window = window
    }
}

extension SceneDelegate: HotNewBusinessDelegate {

    func request<T: Decodable>(_ message: HTTPRequest) async throws -> T {
        /// Mocking topics
        let topics: [Topic] = [.mock, .mock]
        if let t = topics as? T {
            return t
        }

        /// Mocking replies
        let replies: [Reply] = [.mock, .mock]
        if let t = replies as? T {
            return t
        }

        let result = await URLSession.shared.request(message.toURLRequest())
        switch result {
        case let .success(data):
            let t = try JSONDecoder().decode(T.self, from: data)
            return t
        case let .failure(error):
            throw error
        }
    }
}
