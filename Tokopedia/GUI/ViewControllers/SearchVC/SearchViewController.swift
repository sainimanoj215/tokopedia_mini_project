//
//  SearchViewController.swift
//  Tokopedia
//
//  Created by Manoj Saini on 15/05/18.
//  Copyright © 2018 MDS. All rights reserved.
//

import UIKit
import SDWebImage

class SearchViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, kFilterViewControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterBtn: UIButton!
    var searchProducts : [Product] = []
    var searchCategory : [Category] = []
    var selectedCategoryId = -1
    var startIndex = 0
    let limit = 10
    var totalProducts = 0
    var isLoadMore = true
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var filterData : [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let productCellNib = UINib(nibName: kProductCollectionViewCell, bundle: nil)
        self.collectionView.register(productCellNib, forCellWithReuseIdentifier:kProductCollectionViewCell)
        // Do any additional setup after loading the view.
        self.getSearchData()
        if CommonClass.getCurrentDeviceType() == iPhone_X {
            activityView.frame = CGRect.init(x: (self.view.frame.size.width - 10)/2, y: self.view.frame.size.height - 100, width: 20, height: 20)
        } else {
            activityView.frame = CGRect.init(x: (self.view.frame.size.width - 10)/2, y: self.view.frame.size.height - 60, width: 20, height: 20)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func getSearchData(){
        if startIndex == 0 {
            self.showLoaderWithMessage()
        }
        let param = NSMutableDictionary()
        param.setValue("samsung", forKey: "q")
        param.setValue(startIndex, forKey: "start")
        param.setValue(limit, forKey: "rows")
        if filterData.count > 0 {
            param.addEntries(from: filterData)
        }
        NetworkCommunicationLayer.getDataFromAPI(apiName: kSearchProductApi, params: param) { (response, isSuccess) in
            print(response)
            let result = response as! NSDictionary
            let status = result.value(forKey: "status") as! NSDictionary
            let header = result.value(forKey: "header") as! NSDictionary
            self.totalProducts = header.value(forKey: "total_data") as! Int
            if status.value(forKey: "error_code") as! Int == 0 {
                if self.startIndex == 0 {
                    self.searchProducts = []
                    self.searchCategory = []
                }
                self.searchProducts += Product.PopulateArray(array:result.value(forKey: "data") as! NSArray)
                self.collectionView.reloadData()
                self.isLoadMore = true
                self.activityView.stopAnimating()
                self.activityView.removeFromSuperview()
                self.startIndex = self.startIndex + 1
            }
            self.hideLoader()
        }
    }
    
    // MARK: - UICollectionView Delegate & DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: kProductCollectionViewCell, for: indexPath) as! ProductCollectionViewCell
        let product = searchProducts[indexPath.row]
        cell.productNameLbl.text = product.name
        cell.priceLbl.text = product.price
        let imgUrl = URL.init(string: product.image_uri_700!)
        cell.productImageView.sd_setImage(with: imgUrl) { (image, error, cacheType, url) in
            if error != nil {
                cell.productImageView.image = image
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (screenSize.width - 25)/2, height: 280)
    }
    
    // MARK:  UIScrollView Method
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height
        if endScrolling >= scrollView.contentSize.height {
            if (searchProducts.count < totalProducts && isLoadMore) {
                self.isLoadMore = false
                self.view.addSubview(activityView)
                self.activityView.startAnimating()
                self.perform(#selector(getSearchData), with: nil, afterDelay: 1)
            }
        }
    }
    
    @IBAction func didTapFilter(_ sender: Any) {
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "filterSegue" {
            let vc = segue.destination as! FilterViewController
            vc.delegate = self
            vc.filterData = self.filterData
        }
    }
    
    func filterDataWith(data:[String:Any]) {
        startIndex = 0
        self.filterData = data
        self.getSearchData()
    }
    

}
