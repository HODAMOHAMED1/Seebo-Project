//
//  LoginScreenViewController.swift
//  Seebo Project 
//
//  Created by Admin on 10/16/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreLocation
import FBSDKCoreKit
import FBSDKLoginKit


class LoginScreenViewController: UIViewController,LoginViewProtocol{

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var loginFacebookBtn: UIButton!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var signupTabBtn: UIButton!
    var presenter:LoginPresenterProtocol!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        presenter = LoginPresenter(loginView: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.layoutIfNeeded()
        email.configure()
        email.textFieldWithIcon(image: #imageLiteral(resourceName: "email_icon"))
        password.configure()
        password.textFieldWithIcon(image: #imageLiteral(resourceName: "lock_icon"))
    }

    @IBAction func loginTab(_ sender: UIButton) {
    }
    
    @IBAction func signUpTab(_ sender: UIButton) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main2", bundle: nil)
        let loginController = mainStoryboard.instantiateViewController(withIdentifier: "register") as! RegisterScreenViewController
        navigationController?.pushViewController(loginController, animated: true)
    }
    @IBAction func loginBtnAction(_ sender: UIButton) {
        if (!Helper.isValidEmail(emailStr: email.text!)) {
           emailError.alpha = 1
        }else if (!Helper.isValidPassword(paswordStr: password.text!)){
            passwordError.alpha = 1
        }else{
             presenter.loginRequest(email: email.text!, password: password.text!)
        }
    }
    @IBAction func loginFacebookAction(_ sender: UIButton) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile","email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.presenter.fetchProfile()
                }
            }
        }
    }
    @IBAction func forgetPasswordAction(_ sender: UIButton) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main2", bundle: nil)
        let ForgetPassController = mainStoryboard.instantiateViewController(withIdentifier: "forget") as! ForgetPasswordViewController
        navigationController?.pushViewController(ForgetPassController, animated: true)
    }
    func configureTextFields(){
        
        email.addTarget(self, action:"emailChange", for:[UIControlEvents.editingDidBegin,UIControlEvents.editingChanged])
        password.addTarget(self, action:"passwordChange", for:[UIControlEvents.editingDidBegin,UIControlEvents.editingChanged])
    }
    @objc func emailChange(){
        emailError.alpha = 0
        emailLabel.alpha = 0.7
        passwordLabel.alpha = 0
    }
    @objc func passwordChange(){
        passwordError.alpha = 0
        emailLabel.alpha = 0
        passwordLabel.alpha = 0.7
    }
    func accessDataToHome(){
        if CheckConnection.Connection() {
        self.accessLocation()
        }else{
            Alert.showConnectionAlert(title: "Oh no !", message:"No internet found. Check your connection or try again" , view: self, splash:1)
        }
    }
    func sendLocation(location:CLLocation){
        presenter.getItems(location: location)
    }
    
    func showInvalidEmailOrPassword(){
        Alert.invalidEmailOrPassword(view: self)
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
    func fillData(user:UserObj){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main2", bundle: nil)
        let FBController = mainStoryboard.instantiateViewController(withIdentifier: "FBregister") as! FBRegisterViewController
        FBController.userData = user
        navigationController?.pushViewController(FBController, animated: true)
    }
    
}
extension LoginScreenViewController: CLLocationManagerDelegate {
    
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
