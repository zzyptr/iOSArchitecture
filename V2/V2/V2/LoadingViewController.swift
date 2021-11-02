import UIKit

extension LoadingViewController {

    static func instantiate() -> Self {
        let sb = UIStoryboard(name: "\(Self.self)", bundle: nil)
        return sb.instantiateViewController(withIdentifier: "\(Self.self)") as! Self
    }
}

class LoadingViewController: UIViewController {}
