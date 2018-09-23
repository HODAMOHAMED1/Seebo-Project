//
//  DetailsViewController.swift
//  Seebo Project 
//
//  Created by Admin on 9/19/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import ImageSlideshow
import SDWebImage

class DetailsViewController: UIViewController ,UIScrollViewDelegate,DetailsViewPro{
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var cardDetails: CardViewDetails!
    @IBOutlet weak var tableViewHight: NSLayoutConstraint!
    @IBOutlet weak var tableReviewHight: NSLayoutConstraint!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var tableviewReview: UITableView!
    @IBOutlet weak var usercontact: UserContact!
    @IBOutlet weak var imageslides: ImageSlideshow!
    
    var advertisment : advertisment!
    var presenter:DetailsPresenterPro!
    var inputs = [InputSource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DetailsPresenter(view: self)
        configurImageSlides()
        configurTableView()
        cardDetails.configure(adverit: advertisment)
        usercontact.configure(user: advertisment.userobj!)
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter.getAllReviewsById(id: advertisment.adv_id!)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    func configurImageSlides() {
        var images:[String] = advertisment.images!
        print("iiiiiiiii\(images.count)")
        if (images.count > 0) {
            for i in 0...images.count-1
        {
            let iconurl = URL(string: images[i])
            var imagee = UIImageView()
            imagee.sd_setImage(with: iconurl,placeholderImage:#imageLiteral(resourceName: "dress"))
            inputs.append(ImageSource(image:imagee.image!))
        }
        }
        imageslides.setImageInputs(inputs)
        imageslides.contentScaleMode = UIViewContentMode.scaleToFill
        imageslides.pageControl.backgroundColor = UIColor.clear
        imageslides.pageControl.currentPageIndicatorTintColor = UIColor.gray
        imageslides.pageControl.pageIndicatorTintColor = UIColor.white
        imageslides.pageControl.numberOfPages = images.count
        self.imageslides.reloadInputViews()
    }
    func configurTableView() {
        tableview.register(UINib(nibName: "DetailsTableCell", bundle: nil), forCellReuseIdentifier: "DetailsCell")
        tableview.register(UINib(nibName: "HeaderDetailsCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        tableviewReview.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
        tableviewReview.register(UINib(nibName: "DetailsTableCell", bundle: nil), forCellReuseIdentifier: "DetailsCell")
        tableview.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions(rawValue: 0), context: nil)
        tableviewReview.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions(rawValue: 0), context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tableViewHight.constant = self.tableview.contentSize.height
        tableReviewHight.constant = self.tableviewReview.contentSize.height
        self.updateViewConstraints()
    }
    func reloadData() {
        self.tableviewReview.reloadData()
       
    }
}
extension DetailsViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count :Int?
        if tableView == tableview {
            count = advertisment.subattributes?.count
        }
        if tableView == tableviewReview {
            count = presenter.getNumberOfReviews()
        }
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableview {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsTableCell
           cell.configure(attributes: advertisment.subattributes!)
            return cell
        }
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
                cell.configure(review: presenter.getReview(index: indexPath.row))
        return cell
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == self.tableview {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderDetailsCell
            return cell
        }
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsTableCell
            cell.title_details.text = "REVIEW"
            cell.value_details.text = ""
            cell.title_details.font.withSize(30)
         return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
extension DetailsViewController :UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        var items=[Item]()
        items = [Item(name: "jacket", description:""),Item(name: "dress", description:""),Item(name: "jacket", description:"")]
        cell.configure(item: items[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: collectionView.frame.width*0.31, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: "CollectionHeader",for: indexPath) as! CollectionHeaderView
        headerView.text.text = "Related Items"
        return headerView
    }
}
