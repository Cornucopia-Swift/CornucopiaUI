//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import CornucopiaCore
import UIKit.UICollectionView

public extension Cornucopia.UI {

    class CollectionViewDataSource<CELL_TYPE: UICollectionViewCell>: NSObject, UICollectionViewDataSource where CELL_TYPE: Cornucopia.Core.Configurable {

        public let itemProvider: Cornucopia.Core.AnyItemProvider<CELL_TYPE.MODEL_TYPE>
        let cellName = String(describing: CELL_TYPE.self)
        let reuseIdentifier: String = String(describing: CELL_TYPE.MODEL_TYPE.self)

        public init(itemProvider: Cornucopia.Core.AnyItemProvider<CELL_TYPE.MODEL_TYPE>) {
            self.itemProvider = itemProvider
        }

        public func registerAsDataSourceFor(collectionView: UICollectionView) {
            //FIXME: Check whether we have a valid nib for the cell class
            let nib = UINib(nibName: cellName, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
            collectionView.dataSource = self
        }

        //MARK: - <UICollectionViewDataSource>

        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            self.itemProvider.numberOfItems(in: section)
        }

        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CELL_TYPE else {
                fatalError("Did not receive a \(CELL_TYPE.self)")
            }
            guard let model = self.itemProvider.item(at: indexPath) else {
                fatalError("Did not receive a valid model from item provider \(itemProvider) for indexPath \(indexPath)")
            }
            cell.configure(for: model)
            return cell
        }
    }
}
