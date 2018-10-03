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
            if presenter.getLocation() != nil {
         items = presenter.getItems()
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let tabController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            let home = tabController.viewControllers![0] as! HomeScreenViewController
            home.items = items
            navigationController?.pushViewController(tabController, animated: true)
            }else {
                print("noooooo")
            }
        }else {
            let alert = UIAlertController(title: "No Connection", message: "please check your connection", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Open Settings", style: UIAlertActionStyle.default, handler: {(_) -> Void in
                guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)")
                    })
                }}))
            alert.addAction(UIAlertAction(title: "Not Now", style: UIAlertActionStyle.cancel, handler: {action in exit(0)}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func accessLocation() {
        //when we request access to the location even when the App is closed
        locationManager.requestAlwaysAuthorization()
        if(CLLocationManager.locationServicesEnabled())
        {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                print("No access")
                break
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest // location accuracy
                locationManager.startUpdatingLocation()
                break
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
        }
    }
}
