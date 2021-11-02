import UIKit
import Infra

class RootController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        HTTPRequest.defaultHost = "www.v2ex.com"

        let content = V2EXBusinessController(businessDelegate: self)
        embedContent(content)
    }
}

extension RootController: V2EXBusinessDelegate {}
