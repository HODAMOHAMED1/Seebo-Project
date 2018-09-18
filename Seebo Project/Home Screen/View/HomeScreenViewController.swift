//
//  ViewController.swift
//  HomeScreen_TaskPerfect
//
//  Created by Admin on 9/12/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ViewPro {
   
    var presenter : PresenterPro!
    var isSearch:Bool=false
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.configureCollectionView()
        self.configureSearchBar()
        presenter = Presenter(viewinit: self)
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

extension ViewController: UICollectionViewDataSource {
    
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
}

extension ViewController :UICollectionViewDelegate {
    //action
}

extension ViewController :UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: collectionview.frame.width*0.31, height: collectionview.frame.height)
    }
}

extension ViewController :UISearchBarDelegate {
    
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

