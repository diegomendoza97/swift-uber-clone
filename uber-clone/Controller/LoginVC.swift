//
//  LoginVC.swift
//  uber-clone
//
//  Created by Diego Mendoza on 7/16/19.
//  Copyright © 2019 Diego Mendoza. All rights reserved.
//
import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {
    
    var segmentedCtrl: UISegmentedControl?
    var descriptionLbl: UILabel?
    var emailTf: UITextField!
    var passwordTf: UITextField!
    var submitBtn: AnimatedButton!
    
    override func viewDidLoad() {
        view.backgroundColor = .black
//        emailTf.delegate = self
//        passwordTf.delegate = self
        setupView()
        view.bindToKeyBoard()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func onScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func popView() {
        self.dismiss(animated: true) {
        }
        
    }
    
    func setupView() {
        let cancelBtn: UIButton = {
            let button = UIButton()
            let image = UIImage(named: "cancelBtn")?.withRenderingMode(.alwaysTemplate)
            button.setImage(image, for: .normal)
            button.tintColor = .white
            button.isUserInteractionEnabled = true
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(popView), for: .touchUpInside)
            return button
        }()
        
        view.addSubview(cancelBtn)
        cancelBtn.widthAnchor.constraint(equalToConstant: 15)
        cancelBtn.heightAnchor.constraint(equalToConstant: 15)
        cancelBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        cancelBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Ubah"
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            label.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            label.layer.shadowOpacity = 1.0
            label.layer.shadowRadius = 0.0
            label.layer.masksToBounds = false
            label.layer.cornerRadius = 4.0
            label.sizeToFit()
            return label
        }()
        
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant:  -150).isActive = true
        
        
        descriptionLbl = {
            let label = UILabel()
            label.text = "Get there. Your day belongs to you."
            label.textColor = UIColor(white: 1, alpha: 0.4)
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.layer.shadowOpacity = 1.0
            label.layer.shadowRadius = 0.0
            label.layer.masksToBounds = false
            label.sizeToFit()
            return label
        }()
        
        view.addSubview(descriptionLbl!)
        descriptionLbl!.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16 ).isActive = true
        descriptionLbl!.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        segmentedCtrl = {
            let seg = UISegmentedControl(items: ["Passenger", "Driver"])
            seg.translatesAutoresizingMaskIntoConstraints = false
            seg.tintColor = .white
            seg.selectedSegmentIndex = 0
            seg.addTarget(self, action: #selector(tapOnSegmentedController), for: .valueChanged)
            return seg
        }()
        
        view.addSubview(segmentedCtrl!)
//        segmentedCtrl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedCtrl!.leftAnchor.constraint(equalTo: view!.leftAnchor, constant: 40).isActive = true
        segmentedCtrl!.rightAnchor.constraint(equalTo: view!.rightAnchor, constant: -40).isActive = true
        segmentedCtrl!.heightAnchor.constraint(equalToConstant: 40).isActive = true
        segmentedCtrl!.topAnchor.constraint(equalTo: descriptionLbl!.bottomAnchor, constant: 24 ).isActive = true
        
        emailTf = {
            let textField = RoundedTextField()
            textField.placeholder = "Email"
            return textField
        }()
        
        view.addSubview(emailTf)
        emailTf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailTf.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        emailTf.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        emailTf.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTf.topAnchor.constraint(equalTo: segmentedCtrl!.bottomAnchor, constant: 32 ).isActive = true
        
        
        passwordTf = {
            let textField = RoundedTextField()
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            return textField
        }()
        
        view.addSubview(passwordTf)
        passwordTf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTf.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        passwordTf.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        passwordTf.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTf.topAnchor.constraint(equalTo: emailTf.bottomAnchor, constant: 16 ).isActive = true
        
        
        submitBtn = {
            let button = AnimatedButton()
            button.setTitle("Sign In / Sign Up", for: .normal)
            button.tintColor = .black
            button.setBackgroundColor(.white, for: .normal)
            button.layer.cornerRadius = 30
            button.layer.borderWidth = 2.0
            button.clipsToBounds = true
            button.setTitleColor(.black, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            button.addTarget(self, action: #selector(submit), for: .touchUpInside)
            button.spinner.color = .black
            return button
        }()
        
        
        view.addSubview(submitBtn)
        submitBtn.leftAnchor.constraint(equalTo: passwordTf.leftAnchor).isActive = true
        submitBtn.rightAnchor.constraint(equalTo: passwordTf.rightAnchor).isActive = true
        submitBtn.topAnchor.constraint(equalTo: passwordTf.bottomAnchor, constant: 32 ).isActive = true
        submitBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func tapOnSegmentedController() {
        if segmentedCtrl?.selectedSegmentIndex == 1 {
            UIView.transition(with: descriptionLbl!, duration: 0.4, options: .transitionCrossDissolve, animations: {
                self.descriptionLbl?.text = "Drive with Ubah"
            }, completion: nil)
            
        } else {
            UIView.transition(with: descriptionLbl!, duration: 0.4, options: .transitionCrossDissolve, animations: {
                self.descriptionLbl?.text = "Get there. Your day belongs to you."
            }, completion: nil)
        }
    }
    
    @objc func submit() {
        if emailTf.text != nil && passwordTf.text != nil {
            submitBtn.animateButton(shouldLoad: true, withMessage: nil)
            self.view.endEditing(true)
            
            if let email = emailTf.text, let password = passwordTf.text {
                Firebase.Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    if error == nil {
                        print("Not an Error")
                        if let user = user {
                            if self.segmentedCtrl?.selectedSegmentIndex == 0 {
                                let userData = ["provider" : user.user.providerID] as [String: Any]
                                DataService.instance.createFirebaseUser(uid: user.user.uid, userData: userData, isDriver: false)
                            } else {
                                let userData = ["provider" : user.user.providerID, "isDriver": true, "isPickupEnabled": false, "onTrip": false] as [String: Any]
                                DataService.instance.createFirebaseUser(uid: user.user.uid, userData: userData, isDriver: true)
                            }
                        }
                        print("ADDED TO FIREBASE")
                        self.dismiss(animated: true, completion: nil)
                    }  else  {
                        Firebase.Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                                    switch errorCode {
                                    case .invalidEmail:
                                        print("Invalid Email")
                                        break
                                    case .emailAlreadyInUse:
                                        print("InvalidEmail")
                                        break
                                    default:
                                        print("Unexpected Error")
                                        break
                                    }
                                }
                            } else {
                                if let user = user  {
                                    if self.segmentedCtrl?.selectedSegmentIndex == 0 {
                                        let userData = ["provider": user.user.providerID] as [String: Any]
                                        DataService.instance.createFirebaseUser(uid: user.user.uid, userData: userData, isDriver: false)
                                    } else {
                                        let userData = ["provider" : user.user.providerID, "isDriver": true, "isPickupEnabled": false, "onTrip": false] as [String: Any]
                                        DataService.instance.createFirebaseUser(uid: user.user.uid, userData: userData, isDriver: true)
                                    }
                                    
                                    print("Added to Firebase")
                                    self.dismiss(animated: true, completion: nil)
                                }
                            }
                        })
                    }
                }
            }
            submitBtn.animateButton(shouldLoad: false, withMessage: "Sign In / Sign Up")
        }
    }
}
