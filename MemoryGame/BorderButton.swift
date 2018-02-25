//
//  BorderView.swift
//  MemoryGame
//
//  Created by Sebastian Strus on 2018-02-22.
//  Copyright © 2018 Sebastian Strus. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class BorderButton: UIButton {
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
