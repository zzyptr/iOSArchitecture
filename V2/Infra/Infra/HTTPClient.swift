public protocol HTTPClient {

    func request<T: Decodable>(_ message: HTTPRequest) async throws -> T
}

extension HTTPClient {

    @inlinable
    public func request<T: Decodable, BD: HTTPClient>(_ message: HTTPRequest) async throws -> T where Self: BusinessController<BD> {
        return try await self.businessDelegate.request(message)
    }
}
