//
//  ViewController.swift
//  HomeScreen_TaskPerfect
//
//  Created by Admin on 9/12/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ViewPro,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate{
   
    var presenter : PresenterPro!
    var isSearch:Bool=false
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var searchbar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.delegate = self
        collectionview.dataSource = self
        searchbar.delegate = self
        presenter = Presenter(viewinit: self)
        searchbar.placeholder="Find nearest items"
        searchbar.layer.borderWidth = 3
        searchbar.layer.borderColor = UIColor.white.cgColor
        let textFieldInsideSearchBar = searchbar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        textFieldInsideSearchBar?.backgroundColor=UIColor.clear
        textFieldInsideSearchBar?.tintColor = UIColor.white
        var textFieldInsideSearchBarLabel = textFieldInsideSearchBar?.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.white
        let iconview = textFieldInsideSearchBar?.leftView as? UIImageView
        iconview?.image = iconview?.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        iconview?.tintColor = UIColor.white
        searchbar.backgroundColor = UIColor.clear
        searchbar.barTintColor = UIColor.clear
        searchbar.backgroundImage = UIImage()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
      return presenter.getNumberOfSections()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
       if (isSearch)
       {
        return presenter.getNumberOfFilters()
        }else
       {
        return  presenter.getNumberOfItems()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
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
    func reloadfunc()
    {
        self.collectionview.reloadData()
    }
    @IBAction func FeatureButton(_ sender: Any) {
    }
    @IBAction func NearestButton(_ sender: Any) {
        collectionview.isHidden = true
    }
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
        if(presenter.getNumberOfFilters() == 0){
            isSearch = false
        } else {
            isSearch = true
        }
        self.reloadfunc()
    }

}

