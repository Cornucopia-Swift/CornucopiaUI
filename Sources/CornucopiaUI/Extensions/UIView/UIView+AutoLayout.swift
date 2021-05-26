//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if !os(watchOS)
import UIKit.UIView

public extension UIView {

    /// Adds a subview and pins it to all edges. Specify an `index` to use `insertSubview` instead of `addSubview`.
    func CC_addSubview(_ view: UIView, at index: Int = -1) {
        view.translatesAutoresizingMaskIntoConstraints = false
        if index == -1 {
            self.addSubview(view)
        } else {
            self.insertSubview(view, at: index)
        }
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    /// Adds a subview and pins it with the given `margin` to the specified `edge`.
    /// An optional `inset` is used for pinning it to the opposite axis.
    func CC_addSubview(_ view: UIView, to edge: UIRectEdge, margin: CGFloat = 0, inset: CGFloat = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        switch edge {
            case .top:
                NSLayoutConstraint.activate([
                    self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -inset),
                    self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: inset),
                    self.topAnchor.constraint(equalTo: view.topAnchor, constant: -margin)
                ])
            case .bottom:
                NSLayoutConstraint.activate([
                    self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -inset),
                    self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: inset),
                    self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin),
                ])
            case .left:
                NSLayoutConstraint.activate([
                    self.topAnchor.constraint(equalTo: view.topAnchor, constant: -inset),
                    self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset),
                    self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -margin),
                ])
            case .right:
                NSLayoutConstraint.activate([
                    self.topAnchor.constraint(equalTo: view.topAnchor, constant: -inset),
                    self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset),
                    self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
                ])
            default:
                fatalError("Unsupported configuration \(edge) for UIRectEdge")
        }
    }
} // extension UIView
#endif // !os(watchOS)
