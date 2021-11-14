import UIKit
import Infra

protocol HotNewViewControllerDelegate: AnyObject {

    func show(_ topic: Topic)

    func show(_ node: Node)
}

extension HotNewViewController {

    static func instantiate(hot: [Topic], new: [Topic]) -> Self {
        let vc = instantiate()
        vc.hot = hot
        vc.new = new
        return vc
    }
}

class HotNewViewController: UITableViewController {

    var hot: [Topic] = []
    var new: [Topic] = []

    weak var delegate: HotNewViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Hot & New"
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension HotNewViewController {

    func topic(at indexPath: IndexPath) -> Topic {
        return indexPath.section == 0 ? hot[indexPath.row] : new[indexPath.row]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? hot.count : new.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Hot" : "New"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let topic = topic(at: indexPath)
        let cell = tableView.dequeue(TopicCell.self, for: indexPath)
        cell.delegate = self

        if let url = URL(string: topic.node.avatar_large), let data = try? Data(contentsOf: url) {
            cell.nodeIconView.image = UIImage(data: data)
        }
        cell.nodeLabel.text = topic.node.title
        cell.posterLabel.text = topic.member.username
        let df = DateFormatter()
        df.dateFormat = "MM-dd HH:mm"
        let date = Date(timeIntervalSince1970: TimeInterval(topic.created))
        cell.postDateLabel.text = df.string(from: date)

        cell.titleLabel.text = topic.title

        if !topic.last_reply_by.isEmpty {
            cell.replierLabel.text = topic.last_reply_by
            let timeInterval = Int(Date.now.timeIntervalSince1970) - topic.last_modified
            if timeInterval > 3600 {
                cell.replyDateLabel.text = "\(timeInterval / 3600)h"
            } else if timeInterval > 60 {
                cell.replyDateLabel.text = "\(timeInterval / 60)m"
            } else {
                cell.replyDateLabel.text = "\(timeInterval)s"
            }
        }

        cell.countLabel.text = String(topic.replies)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.show(topic(at: indexPath))
    }
}

extension HotNewViewController: TopicCellDelegate {

    func showNode(in cell: TopicCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        delegate?.show(topic(at: indexPath).node)
    }
}

protocol TopicCellDelegate: AnyObject {

    func showNode(in cell: TopicCell)
}

class TopicCell: UITableViewCell {

    @IBOutlet weak var nodeIconView: UIImageView!
    @IBOutlet weak var nodeLabel: UILabel!
    @IBOutlet weak var posterLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var replierLabel: UILabel!
    @IBOutlet weak var replyDateLabel: UILabel!

    @IBOutlet weak var countLabel: UILabel!

    weak var delegate: TopicCellDelegate?

    @IBAction func showNode() {
        delegate?.showNode(in: self)
    }
}
