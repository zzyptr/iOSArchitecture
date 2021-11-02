import UIKit
import Infra

protocol HotNewBusinessDelegate: AnyObject, HTTPClient {}

class HotNewBusinessController<HLBD: HotNewBusinessDelegate>: BusinessController<HLBD> {

    let content: UINavigationController

    override init(businessDelegate: HLBD) {
        let lvc = LoadingViewController.instantiate()
        content = UINavigationController(rootViewController: lvc)
        super.init(businessDelegate: businessDelegate)

        title = "Hot & New"
        tabBarItem.image = UIImage(systemName: "flame.circle")

        embedContent(content)

        Task(operation: fetchData)
    }

    @Sendable
    func fetchData() async {
        do {
            let hot = try await request(API.hotTopics()) as [Topic]
            let new = try await request(API.newTopics()) as [Topic]

            DispatchQueue.main.async {
                let hnvc = HotNewViewController.instantiate(hot: hot, new: new)
                hnvc.delegate = self
                self.content.setViewControllers([hnvc], animated: true)
            }
        } catch {
            // TODO: Show toast or anything
        }
    }
}

extension HotNewBusinessController: HotNewViewControllerDelegate {

    func show(_ topic: Topic) {
        let tbc = TopicBusinessController(businessDelegate: self, topic: topic)
        content.pushViewController(tbc, animated: true)
    }

    func show(_ node: Node) {
        let nvc = NodeViewController.instantiate(node: node)
        present(nvc, animated: true)
    }
}

extension HotNewBusinessController: TopicBusinessDelegate {

    func show(_ member: Member) {
        
    }
}
