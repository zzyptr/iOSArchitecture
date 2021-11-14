import UIKit

public class ActivityIndicatorViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.startAnimating()
        indicatorView.center = view.center
        view.addSubview(indicatorView)
    }
}
