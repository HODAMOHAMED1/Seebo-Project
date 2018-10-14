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
           self.accessLocation()
        }else {
            Alert.showConnectionAlert(title: "Oh no !", message:"No internet found. Check your connection or try again" , view: self)
        }
    }
    func sendLocation(location:CLLocation){
            presenter.getItems(location: location)
    }
    func setItems(items:[Item]){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        let home = tabController.viewControllers![0] as! HomeScreenViewController
        home.items = items
        navigationController?.pushViewController(tabController, animated: true)
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
            if presenter.getLocation() != nil {
                self.sendLocation(location: presenter.getLocation()!)
            }else{
                Alert.showGpsAlert(title: "GPS Not Avalible", message: "Please Open GPS At Least for First Once", view: self)
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
           presenter.setLocation(location: userLocation)
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
            if presenter.getLocation() != nil {
                self.sendLocation(location: presenter.getLocation()!)
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
