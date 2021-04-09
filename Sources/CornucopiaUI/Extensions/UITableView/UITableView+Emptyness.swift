//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UITableView

public extension UITableView {

    /// Returns true, if there are no items. False, otherwise.
    @inlinable var CC_isEmpty: Bool {
        guard let dataSource = self.dataSource else { return true }
        // Ideally we'd just inspect the visibleCells, but if we're checking in the false moment,
        // UITableView will complain about us checking while updating, so we better directly
        // refer to the data source. Unfortunately, `UITableView` does not have an API for `isEmpty()`.
        guard let numberOfSections = dataSource.numberOfSections?(in: self), numberOfSections > 0 else { return true }
        for section in 0..<numberOfSections {
            let entriesPerSection = dataSource.tableView(self, numberOfRowsInSection: section)
            if entriesPerSection > 0 {
                return false
            }
        }
        return true
    }

}
#endif
