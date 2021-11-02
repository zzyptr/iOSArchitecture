import UIKit
import Infra

protocol V2EXBusinessDelegate: AnyObject, HTTPClient {}

class V2EXBusinessController<VBD: V2EXBusinessDelegate>: BusinessController<VBD> {

    override init(businessDelegate: VBD) {
        super.init(businessDelegate: businessDelegate)

        let content = UITabBarController(nibName: nil, bundle: nil)
        let fvc = FavorsViewController.instantiate()
        let hnbc = HotNewBusinessController(businessDelegate: self)
        content.setViewControllers([fvc, hnbc], animated: true)
        embedContent(content)
    }
}

extension V2EXBusinessController: HotNewBusinessDelegate {}
