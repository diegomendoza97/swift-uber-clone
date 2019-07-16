//
//  ViewController.swift
//  uber-clone
//
//  Created by Diego Mendoza on 7/9/19.
//  Copyright © 2019 Diego Mendoza. All rights reserved.
//

import UIKit
import MapKit

class HomeController: UIViewController, MKMapViewDelegate {
    let mapView = MKMapView()
    var isMenuOpen: Bool = false;
    var menuSlider: MenuSlider =  MenuSlider()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideMenu)))
        setupMap()
        setupTopView()
        setupBottomView()
    }
    

    @objc func hideMenu () {
        if self.isMenuOpen == true {
            menuSlider.slideOut()
            self.isMenuOpen = false
        }
        
    }
    
   
    func setupMap() {
        mapView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        mapView.center = view.center
        
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        view.addSubview(mapView)
    }
    
    @objc func showMenu() {
    
        self.isMenuOpen = true
        
        menuSlider.slideIn()
    }
    
    
    func setupTopView() {
//        Slider Button
        let sliderBtn: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named:"menuSliderBtn"), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            // Shadow and Radius
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 0.0
            button.layer.masksToBounds = false
            button.layer.cornerRadius = 4.0
            button.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
            return button
        }()
        view.addSubview(sliderBtn)
        sliderBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        sliderBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sliderBtn.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 24).isActive = true
        sliderBtn.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 40).isActive = true
        
//        Label
        
        let uberLabel: UILabel = {
            let label = UILabel()
            label.text = "Ubah"
            label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            label.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            label.layer.shadowOpacity = 1.0
            label.layer.shadowRadius = 0.0
            label.layer.masksToBounds = false
            label.layer.cornerRadius = 4.0
            return label
        }()
        
        
        view.addSubview(uberLabel)
        uberLabel.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        uberLabel.topAnchor.constraint(equalTo: sliderBtn.topAnchor, constant: 10).isActive = true
        
//        Profile Picture
        let profilePicture: UIImageView = {
            let imageView = UIImageView()
            let image = UIImage(named: "noProfilePhoto")
            imageView.image = image
            imageView.layer.cornerRadius = 22
            imageView.layer.masksToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        mapView.addSubview(profilePicture)
        profilePicture.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profilePicture.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profilePicture.rightAnchor.constraint(equalTo: mapView.rightAnchor, constant: -24).isActive = true
        profilePicture.topAnchor.constraint(equalTo: sliderBtn.topAnchor, constant: 5).isActive = true
        
        let searchView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        mapView.addSubview(searchView)
        searchView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        searchView.topAnchor.constraint(equalTo: uberLabel.bottomAnchor, constant: 30).isActive = true
        searchView.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 16).isActive = true
        searchView.rightAnchor.constraint(equalTo: mapView.rightAnchor, constant: -16).isActive = true
        searchView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        
        let greenDot = UIView()
        greenDot.backgroundColor = .green
        greenDot.translatesAutoresizingMaskIntoConstraints = false
        greenDot.clipsToBounds = true
        greenDot.layer.cornerRadius = 5
        greenDot.layer.masksToBounds = true

        searchView.addSubview(greenDot)
        greenDot.heightAnchor.constraint(equalToConstant: 11).isActive = true
        greenDot.widthAnchor.constraint(equalToConstant: 11).isActive = true
        greenDot.leftAnchor.constraint(equalTo: searchView.leftAnchor, constant: 24).isActive = true
        greenDot.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 16).isActive = true
        
        let myLocationText: UITextField = {
            let tf = UITextField()
            tf.text = "My Location"
            tf.tintColor = .darkGray
            tf.isUserInteractionEnabled = false
            tf.translatesAutoresizingMaskIntoConstraints = false
            return tf
        }()

        searchView.addSubview(myLocationText)
        myLocationText.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 12).isActive = true
        myLocationText.leftAnchor.constraint(equalTo: greenDot.rightAnchor, constant: 16).isActive = true
        myLocationText.rightAnchor.constraint(equalTo: searchView.rightAnchor, constant: -8).isActive = true
        
        let separatingBar = UIView()
        separatingBar.backgroundColor = .lightGray
        separatingBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchView.addSubview(separatingBar)
        separatingBar.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatingBar.leftAnchor.constraint(equalTo: searchView.leftAnchor, constant: 8).isActive = true
        separatingBar.rightAnchor.constraint(equalTo: searchView.rightAnchor, constant: -8).isActive = true
        separatingBar.topAnchor.constraint(equalTo: myLocationText.bottomAnchor, constant: 16).isActive = true
        
        let redDot = UIView()
        redDot.backgroundColor = .lightGray
        redDot.translatesAutoresizingMaskIntoConstraints = false
        redDot.clipsToBounds = true
        redDot.layer.cornerRadius = 5
        redDot.layer.masksToBounds = true
        
        searchView.addSubview(redDot)
        redDot.heightAnchor.constraint(equalToConstant: 11).isActive = true
        redDot.widthAnchor.constraint(equalToConstant: 11).isActive = true
        redDot.leftAnchor.constraint(equalTo: searchView.leftAnchor, constant: 24).isActive = true
        redDot.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -20).isActive = true
        
        let whereText: UITextField = {
            let tf = UITextField()
            tf.placeholder = "Where do you want to go?"
            tf.isUserInteractionEnabled = true
            tf.translatesAutoresizingMaskIntoConstraints = false
            return tf
        }()
        
        searchView.addSubview(whereText)
        whereText.leftAnchor.constraint(equalTo: redDot.rightAnchor, constant: 16).isActive = true
        whereText.rightAnchor.constraint(equalTo: searchView.rightAnchor, constant: -8).isActive = true
        whereText.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -16).isActive = true
    }
    
    
    func setupBottomView() {
        let findRideButton: UIButton = {
            let button = UIButton()
            button.setTitle("Find Me a Ride!", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
            button.backgroundColor = .black
            button.translatesAutoresizingMaskIntoConstraints = false
            button.clipsToBounds = true
            button.layer.cornerRadius = 22
            button.layer.masksToBounds = true
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 0.0
            button.layer.masksToBounds = false
            button.layer.cornerRadius = 4.0
        
            return button
        }()
        
        mapView.addSubview(findRideButton)
        findRideButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        findRideButton.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        findRideButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -60).isActive = true
        findRideButton.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 8).isActive = true
        findRideButton.rightAnchor.constraint(equalTo: mapView.rightAnchor, constant: -8).isActive = true
        
        
//      Center View Button
        let centerButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "centerMapBtn"), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.clipsToBounds = true
            button.layer.cornerRadius = 22
            button.layer.masksToBounds = true
            return button
        }()
        
        mapView.addSubview(centerButton)
        
        centerButton.rightAnchor.constraint(equalTo: mapView.rightAnchor, constant: -8).isActive = true
        centerButton.bottomAnchor.constraint(equalTo: findRideButton.topAnchor, constant: -8).isActive = true
    }
 
}

