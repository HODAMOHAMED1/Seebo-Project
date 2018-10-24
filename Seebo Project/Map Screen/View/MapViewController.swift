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
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var UpperView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUpperView()
        configureCollectionView()
        configureStatusBar()
        presenter = MapPresenter(view: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.accessLocation()
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillLayoutSubviews() {
        view.layoutIfNeeded()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    func reloadData() {
        
        self.collectionView.reloadData()
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
    
    func configureCollectionView() {

     //   tableview.layer.cornerRadius = 20
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 15
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
    }
    func configureStatusBar (){
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().clipsToBounds = true
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor(red: 0.9922, green: 0.7529, blue: 0.0863, alpha: 1.0)
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var detailsview = segue.destination as! DetailsViewController
    if let indexPath = self.collectionView.indexPathsForSelectedItems?.first {
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

extension MapViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return presenter.getNumberOfAdvertisments()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        cell.configure2(advertis: presenter.getAdvertisments()[indexPath.row])
        cell.layer.cornerRadius = 15
        cell.imagee.layer.cornerRadius = 15
        cell.imagee.layer.masksToBounds = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat((collectionView.frame.size.width/2)-20), height: collectionView.frame.size.height*(0.9))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 10, 5, 10);
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected")
        performSegue(withIdentifier: "details", sender: self)
    }
}






