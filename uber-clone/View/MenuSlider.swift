//
//  MenuSlider.swift
//  uber-clone
//
//  Created by Diego Mendoza on 7/15/19.
//  Copyright © 2019 Diego Mendoza. All rights reserved.
//

import UIKit
import Firebase



enum LabelsName: String {
    case Payment = "Payment"
    case YourTrips = "YourTrips"
    case Help = "Help"
    case Settings = "Settings"
}


class MenuSlider:  UIScrollView  {
    let width = (((UIApplication.shared.keyWindow?.frame.width)! / 4) * 3) - 30
    //    var backButton: UIButton?
    var userProfileImage: UIImageView?
    var profileName: UILabel?
    var accountType: UILabel?
    var menuView: UIView?
    var windowFrame: CGRect?
    var driverModeSwitch: UISwitch?
    var signInButton: UIButton?
    
    lazy var homeController = HomeController()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        windowFrame = UIApplication.shared.keyWindow?.frame
        setupView()
        observePassengersAndDrivers()
        
        
        if Auth.auth().currentUser == nil {
            profileName?.text = "No user is logged in"
            accountType?.text = ""
            driverModeSwitch?.isHidden = true
            signInButton?.setTitle("Sign Up / Login", for: .normal)
        } else {
            self.profileName?.text = Auth.auth().currentUser?.email
            signInButton?.setTitle("Sign Out", for: .normal)
        }
    }
    
//    deinit {
//        homeController = nil
//    }
//    
    func observePassengersAndDrivers() {
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]  {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.accountType?.text = "Passenger"
                        self.profileName?.text = Auth.auth().currentUser?.email
                        self.driverModeSwitch?.isHidden = true
                        self.accountType?.isHidden = false
                    }
                }
            }
        })
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]  {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.accountType?.text = "Driver"
                        self.profileName?.text = Auth.auth().currentUser?.email
                        self.driverModeSwitch?.isHidden = false
                        self.accountType?.isHidden = false
                        self.toggleDriverMode()
                    }
                }
            }
        })
    }
    
    
    func setupView() {
        print("Setup View")
        if let keyWindow = UIApplication.shared.keyWindow {
            
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
                label.text = "User"
                label.textAlignment = .right
                label.textColor = UIColor.init(white: 1, alpha: 0.5)
                label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
                label.translatesAutoresizingMaskIntoConstraints = false
                label.sizeToFit()
                return label
            }()
            

            menuView?.addSubview(profileName!)

            profileName?.leftAnchor.constraint(equalTo: userProfileImage!.leftAnchor, constant: 70).isActive = true
            profileName?.topAnchor.constraint(equalTo: menuView!.topAnchor, constant: 70).isActive = true
            
            
            accountType = {
                let label = UILabel()
                label.text = "Driver"
                label.textAlignment = .right
                label.textColor = UIColor.init(white: 1, alpha: 0.5)
                label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
                label.translatesAutoresizingMaskIntoConstraints = false
                label.isHidden = true
                label.sizeToFit()
                return label
            }()
            
            menuView!.addSubview(accountType!)
            accountType?.leftAnchor.constraint(equalTo: userProfileImage!.leftAnchor, constant: 70).isActive = true
            accountType?.topAnchor.constraint(equalTo: profileName!.bottomAnchor, constant: 16).isActive = true
            
            
            driverModeSwitch =  {
                let swtch = UISwitch()
                swtch.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
                swtch.translatesAutoresizingMaskIntoConstraints = false
                swtch.clipsToBounds = true
                swtch.isOn = false
                swtch.isHidden = true
                swtch.addTarget(self, action: #selector(toggleDriverMode), for: .valueChanged)
                return swtch
            }()
            
            menuView?.addSubview(driverModeSwitch!)
            driverModeSwitch?.rightAnchor.constraint(equalTo: menuView!.rightAnchor, constant: -32).isActive = true
            driverModeSwitch?.topAnchor.constraint(equalTo: profileName!.bottomAnchor, constant: 16).isActive = true

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
            
            
            signInButton = {
                let button = UIButton()
                button.setTitle("Sign In / Sign Up", for: .normal)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
                button.setTitleColor(.black, for: .normal)
                button.addTarget(self, action: #selector(launchLogin), for: .touchUpInside)
                return button
            }()
            
            menuView?.addSubview(signInButton!)
            signInButton!.widthAnchor.constraint(equalToConstant: (menuView?.frame.width)!);
            signInButton!.bottomAnchor.constraint(equalTo: menuView!.bottomAnchor, constant: -40).isActive = true
            signInButton!.leftAnchor.constraint(equalTo: menuView!.leftAnchor, constant: 24).isActive = true
        }
        
    }
    
    @objc func toggleDriverMode () {
        print("toggle")
        let uid = Auth.auth().currentUser?.uid
        if driverModeSwitch!.isOn {
            DataService.instance.REF_DRIVERS.child(uid!).updateChildValues(["isPickupEnabled": true])
        } else {
            DataService.instance.REF_DRIVERS.child(uid!).updateChildValues(["isPickupEnabled": false])
        }
    }
    
    @objc func launchLogin() {
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            slideOut()
            let loginVC = LoginVC()
            rootController.present(loginVC, animated: true) {
                if Auth.auth().currentUser != nil {
                    do {
                       try  Auth.auth().signOut()
                    } catch {
                        print("Could not sign you out")
                    }
                }
            }
        }
        
    }
    
    func slideIn() {
        menuView?.superview?.bringSubviewToFront(menuView!)
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            let newFrame = CGRect(x: 0, y: 0, width: self.width, height: self.windowFrame!.height)
            self.menuView?.frame = newFrame
        }) { (completed) in }
    }
    
    
    
    func slideOut() {
        print("SLIDE OUT")
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            let newFrame = CGRect(x: -self.width, y: 0, width: self.menuView!.frame.width, height: self.windowFrame!.height)
            self.menuView?.frame = newFrame
        }) { (completed) in}
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


