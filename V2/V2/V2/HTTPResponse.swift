extension HTTPResponse {

    public static let ok = HTTPResponse(
        status: "ok",
        message: "ok"
    )
}

public struct HTTPResponse: Decodable, Error {
    public let status: String
    public let message: String
}
