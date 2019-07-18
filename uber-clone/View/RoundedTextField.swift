//
//  RoundedTextField.swift
//  uber-clone
//
//  Created by Diego Mendoza on 7/16/19.
//  Copyright © 2019 Diego Mendoza. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    func setupTextField() {
        layer.cornerRadius = 22
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.black.cgColor
        backgroundColor = .white
        autocapitalizationType = .none
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        clipsToBounds = true
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 20, y: bounds.minX, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 20, y: bounds.minX, width: bounds.width, height: bounds.height)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
