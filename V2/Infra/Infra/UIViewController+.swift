import UIKit

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
