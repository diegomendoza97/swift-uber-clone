//
//  AnimatedButton.swift
//  uber-clone
//
//  Created by Diego Mendoza on 7/17/19.
//  Copyright © 2019 Diego Mendoza. All rights reserved.
//

import UIKit

class AnimatedButton: UIButton {
    var originalSize: CGRect?
    var spinner = UIActivityIndicatorView()
    func setupView() {
        originalSize = self.frame
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func awakeFromNib() {
        
        setupView()
        
    } //this will modify the UI before the view loads so when it loads all those changes will appear.

    func animateButton(shouldLoad: Bool, withMessage message: String?){
        spinner.style = .whiteLarge //yes, we want a white AND large spinner for our users to look at.
        spinner.color = .white //fancy colour magic code.
        spinner.alpha = 0.0 // but we want it to be transparent, so its there, just so the users cant see it (yet) MUAHAHA
        spinner.hidesWhenStopped = true //this is handy and self explanatory
        spinner.tag = 21 //this is a little something that will help us in the future
        if shouldLoad {
            print(originalSize!)
            self.addSubview(spinner) // first we add the spinner, which at this point is invisible.
            
            self.setTitle("", for: .normal) //we set the button tittle to blanc, cuz is in mid transition.
            
            UIView.animate(withDuration: 0.2, animations: { //we want the UI to animate, in the middle of the screen minus half the frame size of the buttom, so it is centered. with the same height and width as the height as the original buttom frame, so it becomes a circle.
                
                self.layer.cornerRadius = self.frame.height / 2
                
//                self.frame = CGRect(x: self.frame.midX - (self.frame.height / 2), y: self.frame.origin.y, width: self.frame.height, height: self.frame.height)
                
            }, completion: { (finished) in
                
                if finished == true {
                    self.spinner.startAnimating() //we also want out invisible spinner to start moving.
                    
                    self.spinner.center = CGPoint(x: self.frame.width / 2 + 1, y: self.frame.height / 2) //we want it to be placed in the exact middle of the screen.
                    UIView.animate(withDuration: 0.3, animations: {
                        self.spinner.alpha = 1.0 //and we want the spinner now that is animating to be opaque, AKA presented to the user.
                    })
                }
            })
            self.isUserInteractionEnabled = false //and we also disable the buttom so the user cannot trigger its functionality again.
        } else {
            print(originalSize!)
            self.isUserInteractionEnabled = true
            for subview in self.subviews {
                if subview.tag == 21 {
                    subview.removeFromSuperview()
                }
            }
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.cornerRadius = 5.0
//                self.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                self.setTitle(message, for: .normal)
            })
            
        }
        
    }

}
