//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import CornucopiaCore
import UIKit.UITableView

public extension Cornucopia.UI {

    /// A ready-made TableViewDataSource useful for a fixed amount of data.
    /// NOTE: Classic-style editing is no longer supported. This is better handled
    /// via swipe actions in the `UITableViewDelegate`.
    class TableViewDataSource<CELL_TYPE: UITableViewCell>: NSObject, UITableViewDataSource where CELL_TYPE: Cornucopia.Core.Configurable {

        public let itemProvider: Cornucopia.Core.AnyItemProvider<CELL_TYPE.MODEL_TYPE>
        let cellName = String(describing: CELL_TYPE.self)
        let reuseIdentifier: String = String(describing: CELL_TYPE.MODEL_TYPE.self)

        public init(itemProvider: Cornucopia.Core.AnyItemProvider<CELL_TYPE.MODEL_TYPE>) {
            self.itemProvider = itemProvider
        }

        public func registerAsDataSourceFor(tableView: UITableView) {
            //FIXME: Check whether we have a valid nib for the cell class
            let nib = UINib(nibName: cellName, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
            tableView.dataSource = self
        }

        //MARK: <UITableViewDataSource>
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            self.itemProvider.numberOfItems(in: section)
        }

        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CELL_TYPE else {
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
#endif
