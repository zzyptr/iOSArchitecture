import Foundation

public enum HTTPMethod: String {

    case get = "GET"

    case post = "POST"
}

extension HTTPRequest {

    public static var defaultHost = "www.example.com"
}

public struct HTTPRequest {

    public let host: String

    public let path: String

    public let method: HTTPMethod

    public let parameters: [String: Any]?

    public init(
        host: String = defaultHost,
        method: HTTPMethod,
        path: String,
        parameters: [String: Any]?
    ) {
        self.host = host
        self.path = path
        self.method = method
        self.parameters = parameters
    }
}

extension HTTPRequest {

    @inlinable
    public func toURLRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        if method == .get {
            urlComponents.queryItems = parameters?.flatMap(encode).map(URLQueryItem.init)
        }

        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = method.rawValue
        // TODO: urlRequest.httpBody

        return urlRequest
    }

    @inlinable
    func encode(name: String, value: Any) -> [(String, String)] {
        switch value {
        case let bool as Bool:
            return [(name, bool ? "1" : "0")]
        case let array as [Any]:
            return array.flatMap {
                encode(name: "\(name)[]", value: $0)
            }
        case let dictionary as [String: Any]:
            return dictionary.flatMap {
                encode(name: "\(name)[\($0)]",value: $1)
            }
        default:
            return [(name, String(reflecting: value))]
        }
    }
}
