//
//  MapViewController.swift
//  Seebo Project 
//
//  Created by Admin on 9/16/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController, MapViewPro {

    var presenter : MapPresenterPro!
    var locationManager = CLLocationManager()
    var userLocation = CLLocation()
    @IBOutlet weak var map: GMSMapView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var UpperView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUpperView()
        configureTableView()
        presenter = MapPresenter(view: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.accessLocation()
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func reloadData() {
        
        self.tableview.reloadData()
        self.map.clear()
        self.setMarkers()
    }
    
    func setMarkers() {
        
        var advertisments = presenter.getAdvertisments()
        for i in 0...advertisments.count-1
        {
            let longitude:String = advertisments[i].lng!
            let latitude:String = advertisments[i].lat!
            let longitudeDegrees : CLLocationDegrees = Double(longitude)!
            let latitudeDegrees : CLLocationDegrees = Double(latitude)!
            print("asdasdsd\(longitudeDegrees)")
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(latitudeDegrees,longitudeDegrees)
            print ("position\(marker.position)")
            marker.title = advertisments[i].adv_title
            marker.icon =  #imageLiteral(resourceName: "marker")
            marker.map = map
        }
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
            presenter.getDataDefaultLocation()
        }
    }
    func configureUpperView() {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        UpperView.backgroundColor = UIColor(red: 0.9922, green: 0.7529, blue: 0.0863, alpha: 1.0)
        searchbar.placeholder="Find nearest items"
        searchbar.layer.borderWidth = 3
        searchbar.layer.borderColor = UIColor(red: 0.1569, green: 0.2314, blue: 0.5333, alpha: 1.0).cgColor
        let textFieldInsideSearchBar = searchbar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor(red: 0.1569, green: 0.2314, blue: 0.5333, alpha: 1.0)
        textFieldInsideSearchBar?.backgroundColor=UIColor.clear
        textFieldInsideSearchBar?.tintColor = UIColor.white
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar?.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor(red: 0.1569, green: 0.2314, blue: 0.5333, alpha: 1.0)
        let iconview = textFieldInsideSearchBar?.leftView as? UIImageView
        iconview?.image = iconview?.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        iconview?.tintColor = UIColor(red: 0.1569, green: 0.2314, blue: 0.5333, alpha: 1.0)
        searchbar.backgroundColor = UIColor.clear
        searchbar.barTintColor = UIColor.clear
        searchbar.backgroundImage = UIImage()
    }
    
    func configureTableView() {
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.layer.cornerRadius = 20
        tableview.register(UINib(nibName: "DiscoverCell", bundle: nil), forCellReuseIdentifier: "DiscoverCell")
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var detailsview = segue.destination as! DetailsViewController
    if let indexPath = self.tableview.indexPathForSelectedRow {
        let selectedAdvert = presenter.getAdvertisment(index: indexPath.row)
        detailsview.advertisment = selectedAdvert
    }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            print("hire:\(location.coordinate)")
            self.userLocation = locations.last!
            presenter.setLocation(location: userLocation)
            //foucs on user location
            let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude,
                                                  longitude: userLocation.coordinate.longitude, zoom: 6)
            self.map.camera = camera
            self.map.animate(to:camera)
            self.map.isMyLocationEnabled = true
            locationManager.stopUpdatingLocation() // we use it if we want to stop any update in location
        }
    }
   func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
        
    case .restricted, .denied, .notDetermined:
        print("change to denied")
        locationManager.requestAlwaysAuthorization()
         presenter.getDataDefaultLocation()
        break
    case .authorizedAlways, .authorizedWhenInUse:
        self.accessLocation()
        break
    }
  }
}

extension MapViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.getNumberOfAdvertisments()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "DiscoverCell", for: indexPath) as! DiscoverCell
        cell.configure(advertis: presenter.getAdvertisments()[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("selected")
        performSegue(withIdentifier: "details", sender: self)
    }
}







