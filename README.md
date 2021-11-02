# iOS Architecture

UIView 可以互相嵌套，其结构是以 UIWindow 为根的树。UIKit 引入 UIViewController 用于管理 UIView，UIViewController 也可以互相嵌套，也是树状结构，以 UIWindow 的 `rootViewController` 为根。为了分离关注点，UIViewController 被分为 content view controller 和 container view controller。content view controller 用于展示数据，我们创建的 UIViewController 大部分都是这类。而 container view controller 用于展示其他 UIViewController。

UINavigationController 是 UIKit 提供的栈式 container view controller。在使用 UINavigationController 时，会在当前 content view controller 中实例化下一个 content view controller，再将实例入栈：

```swift
class AppleViewController: UIViewController {

    func appleWasEaten() {
        let bvc = BananaViewController(...)
        navigationController?.pushViewController(bvc, animated: true)
    }
}
```

这样的用法有一个问题！AppleViewController 是 content view controller，其关注点不应该是如何展示其他 UIViewController，所以它应该将事件传递给 container view controller。应用委托模式：

```swift
protocol AppleViewControllerDelegate: AnyObject {

    func appleWasEaten()
}

class AppleViewController: UIViewController {

    weak var delegate: AppleViewControllerDelegate?

    func appleWasEaten() {
        delegate?.appleWasEaten()
    }
}
```

PlantController 继承自 UINavigationController，并实现 AppleViewControllerDelegate。PlantController 作为 AppleViewController 的 container view controller 和 `delegate`：

```swift
class PlantController: UINavigationController {

    init() {
        let avc = AppleViewController(...)
        super.init(rootViewController: avc)
        avc.delegate = self
    }
}

extension PlantController: AppleViewControllerDelegate {

    func appleWasEaten() {
        let bvc = BananaViewController(...)
        pushViewController(bvc, animated: true)
    }
}
```

经过重构，AppleViewController 不再依赖 BananaViewController。而 PlantController 和 AppleViewController 之间也符合依赖倒置原则。

由点及面，模块间也不能相互依赖。把 AppleViewController 看作任意一个独立模块，它的数据通过委托汇聚到上级。上级 PlantController 整合了子模块的数据并使用这些数据提供高级功能，PlantController 又被更高级的模块当作一个独立的子模块使用。就这样把 APP 递归地分解成若干模块。但这棵树有一个问题：一个 APP 中的 container view controller 数量和结构是固定的，但 content view controller 持续增长。可预见的，每个 container view controller 的体量都会不断变大，最终臃肿得令人恐惧。

只有增长才能管理增长。应对持续增长的 content view controller 的方法是向这棵树插入不影响视觉效果的 container view controller，提高树的深度。

将 AppleViewController 放进一个无形的 container view controller 而不是 UINavigationController 的子类，并传递事件给这个无形的 container view controller：

```swift
class FruitController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        let avc = AppleViewController(...)
        avc.delegate = self
        embedContent(avc)
    }

    func embedContent(_ content: UIViewController) {
        addChild(content)
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
}

extension FruitController: AppleViewControllerDelegate {

    func appleWasEaten() {
        let bvc = BananaViewController(...)
        /// 出于简单、统一的目的，BananaViewController 的 delegate 是 FruitController，
        /// 但它的 container view controller 不是 FruitController 而是 navigationController
        navigationController?.pushViewController(bvc, animated: true)
    }
}

```

PlantController 管理 FruitController 而不是 AppleViewController 和 BananaViewController：

```swift
class PlantController: UINavigationController {

    init() {
        let fvc = FruitController(...)
        super.init(rootViewController: fvc)
    }
}
```

再次改造之后，在不影响视觉效果的前提下，container view controller 臃肿的问题解决了。

## 总结

- 高内聚低耦合。每个模块既可以独立，又可以被嵌套
- 简单、统一。每个模块都是一个带委托的 UIViewController
- 清晰、明确。模块的需求都定义在其委托中
- 适应性强。结构可以随着业务的发展而不断扩展
