//
//  SplashViewController.swift
//  Seebo Project 
//
//  Created by Admin on 10/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreLocation

class SplashViewController: UIViewController,SplashViewProtocol{
    
    var presenter :SplashPresenterProtocol!
    var locationManager = CLLocationManager()
    var items = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SplashPresenter(vieww: self)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if CheckConnection.Connection() {
            if (Constants.isLogin == true){
                 self.accessLocation()
            }else{
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main2", bundle: nil)
                    let loginController = mainStoryboard.instantiateViewController(withIdentifier: "login") as! LoginScreenViewController
                    navigationController?.pushViewController(loginController, animated: true)
                }
        }else {
            Alert.showConnectionAlert(title: "Oh no !", message:"No internet found. Check your connection or try again" , view: self,splash: 0)
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
                Alert.showGpsAlert(title: "GPS Not Avalible", message: "Please Open GPS At Least for First Once", view: self,splash: 0)
            }
        }
    }
}
extension SplashViewController: CLLocationManagerDelegate {
    
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
