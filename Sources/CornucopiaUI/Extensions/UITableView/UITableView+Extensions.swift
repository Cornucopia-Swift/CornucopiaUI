//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UITableView

public extension UITableView {

    /// Deselects a selected row, if existing.
    func CC_deselectSelectedRows(animated: Bool) {
        self.indexPathsForSelectedRows?.forEach { self.deselectRow(at: $0, animated: animated) }
    }

}
