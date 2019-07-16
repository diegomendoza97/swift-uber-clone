//
//  MenuSlider.swift
//  uber-clone
//
//  Created by Diego Mendoza on 7/15/19.
//  Copyright © 2019 Diego Mendoza. All rights reserved.
//

import UIKit



enum LabelsName: String {
    case Payment = "Payment"
    case YourTrips = "YourTrips"
    case Help = "Help"
    case Settings = "Settings"
}


class MenuSlider:  UIView, UICollectionViewDelegate  {
    let width = ((UIApplication.shared.keyWindow?.frame.width)! / 4) * 3
    //    var backButton: UIButton?
    var userProfileImage: UIImageView?
    var profileName: UILabel?
    var menuView: UIView?
    var windowFrame: CGRect?
    lazy var homeController = HomeController()
    
    var  homeFaded: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(slideOut)))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.zPosition = 1
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        windowFrame = UIApplication.shared.keyWindow?.frame
        setupView()
    }
   
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        print("Setup View")
        if let keyWindow = UIApplication.shared.keyWindow {
            let widthIn4 = keyWindow.frame.width / 4
            homeFaded.frame = CGRect(x:0 , y: 0, width: widthIn4, height: keyWindow.frame.height)
            
            windowFrame = keyWindow.frame
            menuView = UIView(frame: keyWindow.frame)
            menuView?.isUserInteractionEnabled = true
            menuView?.backgroundColor = .white
            menuView?.frame = CGRect(x: -width, y:  0  , width: width, height: keyWindow.frame.height )
            menuView?.layer.zPosition = 1
            keyWindow.addSubview(menuView!)
            
            let darkHeight = ((menuView?.frame.width)! * 9 / 16)
            let darkBackground: UIView = {
                let view = UIView()
                view.backgroundColor = .black
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
            
            menuView?.addSubview(darkBackground)
            darkBackground.heightAnchor.constraint(equalToConstant: darkHeight).isActive = true

            darkBackground.leftAnchor.constraint(equalTo: menuView!.leftAnchor, constant: 0).isActive = true
            darkBackground.rightAnchor.constraint(equalTo: menuView!.rightAnchor, constant: 0).isActive = true
            

            let originalImage = UIImage(named: "backIcon")
            let backImage: UIImage = (originalImage?.withRenderingMode(.alwaysTemplate))!
            let backButton: UIButton = {
                let button = UIButton()
                button.isUserInteractionEnabled = true
                button.setImage(backImage, for: .normal)
                button.tintColor = .white
                button.translatesAutoresizingMaskIntoConstraints = false
                return button
            }()

            backButton.addTarget(self, action: #selector(slideOut), for: .touchUpInside)

            menuView?.addSubview(backButton)
            backButton.rightAnchor.constraint(equalTo: menuView!.rightAnchor, constant: -16).isActive = true
            backButton.topAnchor.constraint(equalTo: menuView!.topAnchor,constant: 40).isActive = true
            backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
            backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true

            userProfileImage = {
                let imageView = UIImageView()
                imageView.image = UIImage(named: "noProfilePhoto")
                imageView.layer.cornerRadius = 25
                imageView.layer.masksToBounds = true
                imageView.contentMode = .scaleAspectFill
                imageView.translatesAutoresizingMaskIntoConstraints = false
                return imageView
            }()

            menuView?.addSubview(userProfileImage!)

            userProfileImage?.leftAnchor.constraint(equalTo: menuView!.leftAnchor, constant: 16).isActive = true
            userProfileImage?.topAnchor.constraint(equalTo: menuView!.topAnchor, constant: 55).isActive = true
            userProfileImage?.heightAnchor.constraint(equalToConstant: 50).isActive = true
            userProfileImage?.widthAnchor.constraint(equalToConstant: 50).isActive = true

            profileName = {
                let label = UILabel()
                label.text = "Profile Name"
                label.textAlignment = .right
                label.textColor = .white
                label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
                label.translatesAutoresizingMaskIntoConstraints = false
                label.sizeToFit()
                return label
            }()

            menuView?.addSubview(profileName!)

            profileName?.leftAnchor.constraint(equalTo: userProfileImage!.leftAnchor, constant: 70).isActive = true
            profileName?.topAnchor.constraint(equalTo: menuView!.topAnchor, constant: 60).isActive = true


            let paymentlabel: UILabel = {
                let label = UILabel()
                label.textColor = .black
                label.text = "Payment"
                label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
                label.sizeToFit()
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()

            menuView?.addSubview(paymentlabel)

            paymentlabel.topAnchor.constraint(equalTo: darkBackground.bottomAnchor, constant: 30).isActive = true
            paymentlabel.leftAnchor.constraint(equalTo: menuView!.leftAnchor, constant: 16).isActive = true

            
            let yourTripsLabel: UILabel = {
                let label = UILabel()
                label.textColor = .black
                label.text = "Your Trips"
                label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
                label.sizeToFit()
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            menuView?.addSubview(yourTripsLabel)
            
            yourTripsLabel.topAnchor.constraint(equalTo: paymentlabel.bottomAnchor, constant: 16).isActive = true
            yourTripsLabel.leftAnchor.constraint(equalTo: menuView!.leftAnchor, constant: 16).isActive = true
            
            let helpLabel: UILabel = {
                let label = UILabel()
                label.textColor = .black
                label.text = "Help"
                label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
                label.sizeToFit()
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            menuView?.addSubview(helpLabel)
            helpLabel.topAnchor.constraint(equalTo: yourTripsLabel.bottomAnchor, constant: 16).isActive = true
            helpLabel.leftAnchor.constraint(equalTo: menuView!.leftAnchor, constant: 16).isActive = true
            
            let settingsLabel: UILabel = {
                let label = UILabel()
                label.textColor = .black
                label.text = "Settings"
                label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
                label.sizeToFit()
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            menuView?.addSubview(settingsLabel)
            settingsLabel.topAnchor.constraint(equalTo: helpLabel.bottomAnchor, constant: 16).isActive = true
            settingsLabel.leftAnchor.constraint(equalTo: menuView!.leftAnchor, constant: 16).isActive = true
            
            
            let signInButton: UIButton = {
                let button = UIButton()
                button.setTitle("Sign In / Sign Up", for: .normal)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
                button.setTitleColor(.black, for: .normal)
                button.addTarget(self, action: #selector(printFuck), for: .touchUpInside)
                return button
            }()
            
            menuView?.addSubview(signInButton)
            signInButton.widthAnchor.constraint(equalToConstant: (menuView?.frame.width)!);
//            signInButton.widthAnchor.constraint(equalToConstant: menuView?.frame.width);
            signInButton.bottomAnchor.constraint(equalTo: menuView!.bottomAnchor, constant: -40).isActive = true
            signInButton.leftAnchor.constraint(equalTo: menuView!.leftAnchor, constant: 24).isActive = true
        }
        
    }
    
    @objc func printFuck() {
        print("FUUUCK" )
    }
    
    func slideIn() {
        homeFaded.isHidden = true
        menuView?.superview?.bringSubviewToFront(menuView!)
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            let newFrame = CGRect(x: 0, y: 0, width: self.width, height: self.windowFrame!.height)
            self.menuView?.frame = newFrame
        }) { (completed) in }
        
    }
    
    
    @objc func slideOut() {
        print("SLIDE OUT")
        homeFaded.isHidden = false
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            let newFrame = CGRect(x: -self.width, y: 0, width: self.menuView!.frame.width, height: self.windowFrame!.height)
            self.menuView?.frame = newFrame
        }) { (completed) in
            self.homeFaded.removeFromSuperview()
            
        }
    }
}


