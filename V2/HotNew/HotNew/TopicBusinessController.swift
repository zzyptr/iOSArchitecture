import UIKit
import Infra

protocol TopicBusinessDelegate: AnyObject, HTTPClient {

    func show(_ member: Member)
}

class TopicBusinessController<TBD: TopicBusinessDelegate>: BusinessController<TBD> {

    init(businessDelegate: TBD, topic: Topic) {
        let content = TopicViewController.instantiate(topic: topic)
        super.init(businessDelegate: businessDelegate)
        content.delegate = self
        embedContent(content)
    }
}

extension TopicBusinessController: TopicViewControllerDelegate {

    func show(_ member: Member) {
        businessDelegate.show(member)
    }

    func showReplies(topicID: Int) {
        let rvc = RepliesViewController.instantiate(topicID: topicID)
        navigationController?.pushViewController(rvc, animated: true)
    }
}
