//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UICollectionView

public extension UICollectionView {

    /// Returns true, if there are no items. False, otherwise.
    @inlinable var CC_isEmpty: Bool {
        guard let dataSource = self.dataSource else { return true }
        // Ideally we'd just inspect the visibleCells, but if we're checking in the false moment,
        // UICollectionView will complain about us checking while updating, so we better directly
        // refer to the data source. Unfortunately, `UICollectionView` does not have an API for `isEmpty()`.
        guard let numberOfSections = dataSource.numberOfSections?(in: self), numberOfSections > 0 else { return true }
        for section in 0..<numberOfSections {
            let entriesPerSection = dataSource.collectionView(self, numberOfItemsInSection: section)
            if entriesPerSection > 0 {
                return false
            }
        }
        return true
    }

}
#endif
