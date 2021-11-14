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
        Task(operation: fetchReplies)
    }

    @Sendable
    func fetchReplies() async {
        guard let delegate = delegate else { return }
        guard let topicID = topicID else { return }
        do {
            replies = try await delegate.request(API.replies(topicID: topicID))
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {

        }
    }
}

struct Reply: Decodable {
    let member: Member
    let created: Int
    let topic_id: Int
    let content: String
    let content_rendered: String
    let last_modified: Int
    let id: Int
}
