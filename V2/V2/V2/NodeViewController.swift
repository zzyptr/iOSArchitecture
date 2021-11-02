import UIKit

extension NodeViewController {

    static func instantiate(node: Node) -> Self {
        let sb = UIStoryboard(name: "\(Self.self)", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "\(Self.self)") as! Self
        vc.node = node
        return vc
    }
}

class NodeViewController: UIViewController {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topicsLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!

    let dimmingView = UIControl()

    var node: Node?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()

        view.backgroundColor = nil
        view.insertSubview(dimmingView, at: 0)
        dimmingView.frame = CGRect(
            x: 0,
            y: -view.frame.height,
            width: view.frame.width,
            height: 2 * view.frame.height
        )
        dimmingView.addTarget(
            self,
            action: #selector(dismissAnimated),
            for: .touchUpInside
        )
    }

    func loadUI() {
        guard let node = node else { return }

        if let url = URL(string: node.avatar_large), let data = try? Data(contentsOf: url) {
            iconView.image = UIImage(data: data)
        }
        titleLabel.text = node.title
        topicsLabel.text = String(node.topics)
        starsLabel.text = String(node.stars)
    }

    @objc
    @inlinable
    func dismissAnimated() {
        dismiss(animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        dimmingView.backgroundColor = .black.withAlphaComponent(0.3)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        dimmingView.backgroundColor = nil
    }
}
