import UIKit
import Infra

protocol RepliesViewControllerDelegate: AnyObject, HTTPClient {

    func show(_ member: Member)
}

extension RepliesViewController {

    static func instantiate(topicID: Int) -> Self {
        let vc = instantiate()
        vc.topicID = topicID
        return vc
    }
}

class RepliesViewController: UITableViewController {

    var topicID: Int?

    var replies: [Reply] = []

    weak var delegate: RepliesViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Replies"
        tableView.rowHeight = UITableView.automaticDimension
        Task(operation: fetchReplies)
    }

    @Sendable
    func fetchReplies() async {
        guard let delegate = delegate else { return }
        guard let topicID = topicID else { return }
        if let replies: [Reply] = try? await delegate.request(API.replies(topicID: topicID)) {
            self.replies = replies
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension RepliesViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return replies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(RepliesViewCell.self, for: indexPath)
        cell.contentLabel.text = replies[indexPath.row].content
        return cell
    }
}

class RepliesViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
}
