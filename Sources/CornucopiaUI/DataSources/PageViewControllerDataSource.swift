//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import CornucopiaCore
import UIKit.UIPageViewController

public extension Cornucopia.UI {

    class PageViewControllerDataSource<CONTROLLER_TYPE: UIViewController>: NSObject, UIPageViewControllerDataSource where CONTROLLER_TYPE: Cornucopia.Core.Configurable & Cornucopia.Core.Indexable {

        public var supportsPageControl: Bool = false

        public let modelItemProvider: Cornucopia.Core.AnyItemProvider<CONTROLLER_TYPE.MODEL_TYPE>
        let controllerName = String(describing: CONTROLLER_TYPE.self)

        public init(itemProvider: Cornucopia.Core.AnyItemProvider<CONTROLLER_TYPE.MODEL_TYPE>) {
            self.modelItemProvider = itemProvider
        }

        public func registerAsDataSourceFor(pageViewController: UIPageViewController) {
            pageViewController.dataSource = self
        }

        public func viewController(forIndex index: Int) -> CONTROLLER_TYPE {
            let indexPath = IndexPath(item: index, section: 0)
            guard let item = self.modelItemProvider.item(at: indexPath) else { fatalError("Model Object for index \(indexPath) not available)") }
            var viewController = CONTROLLER_TYPE()
            viewController.index = index
            viewController.configure(for: item)
            return viewController
        }

        //MARK: - <UIPageViewControllerDataSource>

        public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let controller = viewController as? CONTROLLER_TYPE else { fatalError("View Controller \(viewController) is not of required type \(CONTROLLER_TYPE.self)") }
            guard controller.index > 0 else { return nil }
            let nextIndex = controller.index - 1
            let indexPath = IndexPath(item: nextIndex, section: 0)
            guard let item = self.modelItemProvider.item(at: indexPath) else { fatalError("Model Object for index \(indexPath) not available)") }
            var viewController = CONTROLLER_TYPE()
            viewController.index = nextIndex
            viewController.configure(for: item)
            return viewController
        }

        public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let controller = viewController as? CONTROLLER_TYPE else { fatalError("View Controller \(viewController) is not of required type \(CONTROLLER_TYPE.self)") }
            guard controller.index < self.modelItemProvider.numberOfItems(in: 0) - 1 else { return nil }
            let nextIndex = controller.index + 1
            let indexPath = IndexPath(item: nextIndex, section: 0)
            guard let item = self.modelItemProvider.item(at: indexPath) else { fatalError("Model Object for index \(indexPath) not available)") }
            var viewController = CONTROLLER_TYPE()
            viewController.index = nextIndex
            viewController.configure(for: item)
            return viewController
        }

        public func presentationCount(for pageViewController: UIPageViewController) -> Int { self.supportsPageControl ? self.modelItemProvider.numberOfItems(in: 0) : 0 }
        public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
            guard self.supportsPageControl else { return -1 }
            guard let controller = pageViewController.CC_visibleViewController else { return -1 }
            guard let typedController = controller as? CONTROLLER_TYPE else { fatalError("View Controller \(controller) is not of required type \(CONTROLLER_TYPE.self)") }
            return typedController.index
        }
    }
}
#endif

