//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import CornucopiaCore
import UIKit

/// A `UITableView` subclass that features an empty view.
public class CC_TableView: UITableView {

    private static let AnimationDuration = 0.2
    private var lastContentSize: CGSize = .zero

    @IBOutlet public var tableEmptyView: UIView! /* {
        didSet {
            self.tableEmptyView.backgroundColor = .red
        }
    } */

    public override var contentSize: CGSize {
        didSet {
            guard self.contentSize != self.lastContentSize else { return }
            self.handleContentSizeUpdate()
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        guard let ev = self.tableEmptyView, ev.superview == self else { return }
        ev.frame = CGRect(x: self.adjustedContentInset.left,
                          y: 0,
                          width: self.bounds.size.width - self.adjustedContentInset.left - self.adjustedContentInset.right,
                          height: self.bounds.size.height - self.adjustedContentInset.top - self.adjustedContentInset.bottom)
    }
}

private extension CC_TableView {

    private func handleContentSizeUpdate() {

        // let's defer updating until we're out of refreshing
        guard let ev = self.tableEmptyView else { return }
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
public extension Cornucopia.UI {
    typealias TableView = CC_TableView
}
#endif
