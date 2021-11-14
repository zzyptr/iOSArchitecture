import UIKit

extension FavorsViewController {

    static func instantiate() -> Self {
        let sb = UIStoryboard(name: "\(Self.self)", bundle: Bundle(for: Self.self))
        let vc = sb.instantiateViewController(withIdentifier: "\(Self.self)") as! Self
        return vc
    }
}

class FavorsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Favors"
        tabBarItem.image = UIImage(systemName: "star.circle")
    }
}

