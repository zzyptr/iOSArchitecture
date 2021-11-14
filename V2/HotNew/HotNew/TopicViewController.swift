import UIKit
import Infra

protocol TopicViewControllerDelegate: AnyObject, HTTPClient {

    func show(_ member: Member)

    func showReplies(topicID: Int)
}

extension TopicViewController {

    static func instantiate(topic: Topic) -> Self {
        let sb = UIStoryboard(name: "\(Self.self)", bundle: Bundle(for: Self.self))
        let vc = sb.instantiateViewController(withIdentifier: "\(Self.self)") as! Self
        vc.topic = topic
        return vc
    }
}

class TopicViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyView: UITextView!

    weak var delegate: TopicViewControllerDelegate?

    var topic: Topic?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
    }

    func loadUI() {
        guard let topic = topic else { return }
        titleLabel.text = topic.title
        userLabel.text = topic.member.username
        let df = DateFormatter()
        df.dateFormat = "MM-dd HH:mm"
        let date = Date(timeIntervalSince1970: Double(topic.created))
        dateLabel.text = df.string(from: date)
        bodyView.text = topic.content
    }

    @IBAction func showMember() {
        guard let member = topic?.member else { return }
        delegate?.show(member)
    }

    @IBAction func showReplies() {
        guard let id = topic?.id else { return }
        delegate?.showReplies(topicID: id)
    }
}
