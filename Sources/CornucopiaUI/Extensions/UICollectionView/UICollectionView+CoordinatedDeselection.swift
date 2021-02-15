//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UICollectionView

public extension UICollectionView {

    /// Animated the deselection of the first selected item along a transition coordinator.
    func CC_deselectSelectedItem(animated: Bool, with coordinator: UIViewControllerTransitionCoordinator? = nil) {
        guard let selectedIndexPath = self.indexPathsForSelectedItems?.first else { return }
        guard animated, let transitionCoordinator = coordinator else {
            self.deselectItem(at: selectedIndexPath, animated: animated)
            return
        }
        transitionCoordinator.animate { ctx in
            self.deselectItem(at: selectedIndexPath, animated: true)
        } completion: { ctx in
            guard ctx.isCancelled else { return }
            self.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom)
        }
    }

}
