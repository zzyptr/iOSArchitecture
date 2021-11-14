import Foundation

extension URLSession {

    @inlinable
    public func request(_ message: URLRequest) async -> Result<Data, URLError> {
        return await withCheckedContinuation { continuation in
            dataTask(with: message) { data, _, error in
                if let data = data {
                    continuation.resume(returning: .success(data))
                }
                if let error = error as? URLError {
                    continuation.resume(returning: .failure(error))
                }
            }.resume()
        }
    }
}
