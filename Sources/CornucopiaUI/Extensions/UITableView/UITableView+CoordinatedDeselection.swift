//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UITableView

public extension UITableView {

    /// Animated the deselection of the first selected row along a transition coordinator.
    func CC_deselectSelectedRow(animated: Bool, with coordinator: UIViewControllerTransitionCoordinator? = nil) {

        guard let selectedIndexPath = self.indexPathForSelectedRow else { return }
        guard animated, let transitionCoordinator = coordinator else {
            self.deselectRow(at: selectedIndexPath, animated: animated)
            return
        }
        transitionCoordinator.animate { ctx in
            self.deselectRow(at: selectedIndexPath, animated: true)
        } completion: { ctx in
            guard ctx.isCancelled else { return }
            self.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
        }
    }

}
