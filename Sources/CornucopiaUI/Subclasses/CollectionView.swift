//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import CornucopiaCore
import UIKit

/// A `UICollectionView` subclass that features an empty view.
public class CC_CollectionView: UICollectionView {

    @IBOutlet public var collectionEmptyView: UIView!
    static private let AnimationDuration = 0.2
    private var lastContentSize: CGSize = .zero

    public override var contentSize: CGSize {
        didSet {
            guard self.contentSize != self.lastContentSize else { return }
            self.lastContentSize = self.contentSize
            self.handleContentSizeUpdate()
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        guard let ev = self.collectionEmptyView, ev.superview == self else { return }
        ev.frame = self.bounds
    }

}

private extension CC_CollectionView {

    private func handleContentSizeUpdate() {

        // let's defer updating until we're out of refreshing
        guard let ev = self.collectionEmptyView else { return }
        guard !self.hasUncommittedUpdates else { return }
        #if !os(tvOS)
        if let refreshControl = self.refreshControl, refreshControl.isRefreshing {
            return
        }
        #endif
        let empty = self.CC_isEmpty // cache it, since the call might be expensive
        if empty && ev.superview != self {
            ev.frame = self.bounds
            UIView.transition(with: self, duration: Self.AnimationDuration, options: [.transitionCrossDissolve, .curveEaseInOut], animations: {
                self.addSubview(ev)
                self.bringSubviewToFront(ev)
            }, completion: nil)
            self.addSubview(ev)
        } else if !empty && ev.superview == self {
            UIView.transition(with: self, duration: Self.AnimationDuration, options: [.transitionCrossDissolve, .curveEaseInOut], animations: {
                ev.removeFromSuperview()
            }, completion: nil)
        }
    }
}

/// Put it into our namespace for a nicer syntax when using it programmatically
public extension Cornucopia.UI { typealias CollectionView = CC_CollectionView }
