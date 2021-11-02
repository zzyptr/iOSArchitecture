import UIKit

extension UITableView {

    @inlinable
    public func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as! T
    }
}
