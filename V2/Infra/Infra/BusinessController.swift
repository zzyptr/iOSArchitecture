import UIKit

open class BusinessController<BusinessDelegate>: UIViewController where BusinessDelegate: AnyObject {

    public unowned var businessDelegate: BusinessDelegate

    @inlinable
    public init(businessDelegate: BusinessDelegate) {
        self.businessDelegate = businessDelegate
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        return nil
    }
}
