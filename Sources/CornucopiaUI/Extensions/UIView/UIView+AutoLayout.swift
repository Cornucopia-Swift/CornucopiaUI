//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
import UIKit.UIView

public extension UIView {

    func CC_addSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func CC_addSubview(_ view: UIView, to edge: UIRectEdge, inset: CGFloat = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        switch edge {
            case .top:
                NSLayoutConstraint.activate([
                    self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
                    self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: inset),
                    self.topAnchor.constraint(equalTo: view.topAnchor),
                ])
            case .bottom:
                NSLayoutConstraint.activate([
                    self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
                    self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: inset),
                    self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                ])
            default:
                fatalError("Unsupported configuration \(edge) for UIRectEdge")
        }

    }


} // extension UIView
