//
//  FBRegisterViewController.swift
//  Seebo Project 
//
//  Created by Admin on 10/23/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreLocation

class FBRegisterViewController: UIViewController,FBRegisterViewProtocol {
    
  var locationManager = CLLocationManager()
  var userData = UserObj()
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var fullNameError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneError: UILabel!
    var presenter:FBRegisterPresenterProtocol!
    var validEmail:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
      fullName.text = userData.name
      email.text = userData.email
        presenter = FBPresenter(RegView: self)
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var emailLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        self.view.layoutIfNeeded()
        fullName.configure()
        fullName.textFieldWithIcon(image: #imageLiteral(resourceName: "name_icon"))
        email.configure()
        email.textFieldWithIcon(image: #imageLiteral(resourceName: "email_icon"))
        phone.configure()
        phone.textFieldWithIcon(image: #imageLiteral(resourceName: "name_icon"))
    }
    func configureTextFields(){
        fullName.addTarget(self, action:"fullNameChange", for:[UIControlEvents.editingDidBegin,UIControlEvents.editingChanged])
        email.addTarget(self, action:"emailChange", for:[UIControlEvents.editingDidBegin,UIControlEvents.editingChanged])
        phone.addTarget(self, action:"phoneChange", for:[UIControlEvents.editingDidBegin,UIControlEvents.editingChanged])
    }
    @objc func fullNameChange(){
        fullNameError.alpha = 0
        fullNameLabel.alpha = 0.7
        emailLabel.alpha = 0
        phoneLabel.alpha = 0
    }
    @objc func emailChange(){
        emailError.alpha = 0
        fullNameLabel.alpha = 0
        emailLabel.alpha = 0.7
        phoneLabel.alpha = 0
    }
    @objc func phoneChange(){
        phoneError.alpha = 0
        fullNameLabel.alpha = 0
        emailLabel.alpha = 0
        phoneLabel.alpha = 0.7
    }
    @IBAction func doneAction(_ sender: UIButton) {
        
        if (fullName.text?.isEmpty)! {
            fullNameError.alpha = 1
        }else if (!Helper.isValidEmail(emailStr: email.text!)) {
            emailError.alpha = 1
        }else if (phone.text?.isEmpty)!{
            phoneError.alpha = 1
        }else{
            if (userData.email == email.text){
               validEmail = true
            }
            presenter.fbRegisterRequest(fullname: fullName.text!, email: email.text!, phone: phone.text!, validEmail: validEmail)
        }
    }
    func accessDataToHome(){
        if CheckConnection.Connection() {
            self.accessLocation()
        }else{
            Alert.showConnectionAlert(title: "Oh no !", message:"No internet found. Check your connection or try again" , view: self, splash:2)
        }
    }
    func sendLocation(location:CLLocation){
        presenter.getItems(location: location)
    }
    func accessLocation() {
        //when we request access to the location even when the App is closed
        locationManager.delegate = self
        if(CLLocationManager.locationServicesEnabled())
        {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined,.restricted, .denied:
                print("No access")
                locationManager.requestAlwaysAuthorization()
                break
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                locationManager.desiredAccuracy = kCLLocationAccuracyBest // location accuracy
                locationManager.startUpdatingLocation()
                break
            }
        }else{
            if Helper.getLocation() != nil {
                self.sendLocation(location: Helper.getLocation()!)
            }else{
                Alert.showGpsAlert(title: "GPS Not Avalible", message: "Please Open GPS At Least for First Once", view: self,splash: 1)
            }
        }
    }
}

extension FBRegisterViewController:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            print("hire:\(location.coordinate)")
            var userLocation:CLLocation = locations.last!
            print(userLocation.coordinate.longitude)
            locationManager.stopUpdatingLocation()
            Helper.setLocation(location: userLocation)
            self.sendLocation(location: userLocation)
        }else {
            print("no location to show")
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("change to notDetermined")
            locationManager.requestAlwaysAuthorization()
            break
        case .restricted, .denied:
            print("change to denied")
            locationManager.requestAlwaysAuthorization()
            if Helper.getLocation() != nil {
                self.sendLocation(location: Helper.getLocation()!)
            }else{
                //default location
                var loc = CLLocation(latitude: 29.315654, longitude: 28.46415)
                self.sendLocation(location: loc)
            }
            break
        case .authorizedAlways, .authorizedWhenInUse:
            self.accessLocation()
            break
        }
    }
}
