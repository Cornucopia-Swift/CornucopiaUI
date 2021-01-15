//
//  File.swift
//  
//
//  Created by Dr. Michael Lauer on 12.12.20.
//

import CornucopiaCore
import UIKit.UIButton

public class CC_PillToggleButton: UIButton {

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }

    public override func draw(_ rect: CGRect) {
        
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        //self.layer.cornerRadius = self.bounds.size.height / 4.0

    }

}

private extension CC_PillToggleButton {

    func setup() {
        self.addTarget(self, action: #selector(onTouchUpInside), for: .touchUpInside)
    }

    @objc func onTouchUpInside() {
        self.isSelected.toggle()
    }

}

public extension Cornucopia.UI { typealias PillToggleButton = CC_PillToggleButton }
