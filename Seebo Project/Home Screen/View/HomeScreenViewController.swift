//
//  ViewController.swift
//  HomeScreen_TaskPerfect
//
//  Created by Admin on 9/12/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreLocation

class HomeScreenViewController: UIViewController,HomeViewPro {
   
    var presenter : HomePresenterPro!
    var items = [Item]()
    var isSearch:Bool=false
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var searchbar: UISearchBar!
    var checkedItems:NSMutableArray!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let tabController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = tabController
        self.configureCollectionView()
        self.configureSearchBar()
        presenter = HomePresenter(viewinit: self)
        presenter.setItems(items: items)
        checkedItems = NSMutableArray()
//        var userDefaults = UserDefaults.standard
//        let locationData  = userDefaults.object(forKey: "location") as! Data
//        let location = NSKeyedUnarchiver.unarchiveObject(with: locationData) as! CLLocation
//        print("jahsfkjashsfsf\(location.coordinate.longitude)")
    }
    
    func reloadfunc() {
        
        self.collectionview.reloadData()
    }
    
    @IBAction func FeatureButton(_ sender: Any) {
        
        collectionview.isHidden = false
    }
    
    @IBAction func NearestButton(_ sender: Any) {
        
        collectionview.isHidden = true
    }
}

extension HomeScreenViewController:UICollectionViewDataSource ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return presenter.getNumberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (isSearch)
        {
            return presenter.getNumberOfFilters()
        }else
        {
            return  presenter.getNumberOfItems()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        var items=[Item]()
        if (isSearch)
        {
            items = presenter.getFilters()
        }
        else
        {
            items = presenter.getItems()
        }
        cell.configure(item: items[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionview.frame.size.width*(0.28), height: collectionview.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        cell.checkmark.image = #imageLiteral(resourceName: "checkmark")
        var items = presenter.getItems()
        checkedItems.add(items[indexPath.row])
        print(checkedItems.count)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        cell.checkmark.image = UIImage()
        var items = presenter.getItems()
        checkedItems.remove(items[indexPath.row])
        print(checkedItems.count)
    }
}

extension HomeScreenViewController :UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        isSearch = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        presenter.FilteredData(searchText: searchText)
        if(searchText.isEmpty){
            isSearch = false
        } else {
            isSearch = true
        }
        self.reloadfunc()
    }
    
    func configureCollectionView() {
        
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
        collectionview.allowsMultipleSelection = true
    }
    
    func configureSearchBar() {
        
        searchbar.delegate = self
        searchbar.placeholder="Find nearest items"
        searchbar.layer.borderWidth = 3
        searchbar.layer.borderColor = UIColor.white.cgColor
        let textFieldInsideSearchBar = searchbar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        textFieldInsideSearchBar?.backgroundColor=UIColor.clear
        textFieldInsideSearchBar?.tintColor = UIColor.white
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar?.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.white
        let iconview = textFieldInsideSearchBar?.leftView as? UIImageView
        iconview?.image = iconview?.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        iconview?.tintColor = UIColor.white
        searchbar.backgroundColor = UIColor.clear
        searchbar.barTintColor = UIColor.clear
        searchbar.backgroundImage = UIImage()
    }
}

