import UIKit
import Infra

public protocol HotNewBusinessDelegate: AnyObject, HTTPClient {}

public class HotNewBusinessController<HNBD: HotNewBusinessDelegate>: BusinessController<HNBD> {

    let content: UINavigationController

    public override init(businessDelegate: HNBD) {
        let aivc = ActivityIndicatorViewController()
        content = UINavigationController(rootViewController: aivc)
        super.init(businessDelegate: businessDelegate)

        title = "Hot & New"
        tabBarItem.image = UIImage(systemName: "flame.circle")

        embedContent(content)

        Task(operation: fetchData)
    }

    @Sendable
    func fetchData() async {
        do {
            async let hot = request(API.hotTopics()) as [Topic]
            async let new = request(API.newTopics()) as [Topic]

            let tuple = try await (hot, new)

            DispatchQueue.main.async {
                let hnvc = HotNewViewController.instantiate(hot: tuple.0, new: tuple.1)
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
