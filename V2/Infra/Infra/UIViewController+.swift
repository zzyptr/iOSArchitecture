import UIKit

extension UIViewController {

    @inlinable
    public static func instantiate() -> Self {
        let sb = UIStoryboard(name: "\(Self.self)", bundle: Bundle(for: Self.self))
        return sb.instantiateViewController(withIdentifier: "\(Self.self)") as! Self
    }
}

extension UIViewController {

    @inlinable
    public func embedContent(_ content: UIViewController) {
        addChild(content)
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }

    @inlinable
    public func unembedFromContainer() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
