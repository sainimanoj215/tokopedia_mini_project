
//
//  FilterViewController.swift
//  Tokopedia
//
//  Created by Manoj Saini on 15/05/18.
//  Copyright © 2018 MDS. All rights reserved.
//

import UIKit
import RangeSeekSlider

protocol kFilterViewControllerDelegate {
    func filterDataWith(data:[String:Any])
}

class FilterViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, RangeSeekSliderDelegate, UITextFieldDelegate, kShoptypesViewControllerDelegate {

    @IBOutlet weak var shopTypeCollectionView: UICollectionView!
    @IBOutlet weak var tfMinPrice: UITextField!
    @IBOutlet weak var tfMaxPrice: UITextField!
    @IBOutlet weak var wholeSaleSwitchBtn: UISwitch!
    @IBOutlet weak var shopTypeBtn: UIButton!
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var priceRangeSlider: RangeSeekSlider!
    var selectedShopTypes : [String] = []
    var delegate : kFilterViewControllerDelegate?
    let minVal: CGFloat = 0.0
    let maxVal: CGFloat = 10000.0
    var filterData : [String: Any] = [:]
    var official : Bool = true
    var fshop : String = "2"
    var didTapShopTypes = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let shopTypeCellNib = UINib(nibName: kShopTypeCollectionViewCell, bundle: nil)
        self.shopTypeCollectionView.register(shopTypeCellNib, forCellWithReuseIdentifier:kShopTypeCollectionViewCell)
        // Do any additional setup after loading the view.
        selectedShopTypes = shopTypes
        priceRangeSlider.delegate = self
        priceRangeSlider.minValue = minVal
        priceRangeSlider.maxValue = maxVal
        priceRangeSlider.selectedMinValue = minVal
        priceRangeSlider.selectedMaxValue = maxVal
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !didTapShopTypes {
            self.showFilterData()
        }
    }
    
    func showFilterData() {
        if filterData.count == 0 {
            return
        }
        self.official = filterData["official"] as! Bool
        self.fshop = filterData["fshop"] as! String
        let min : String? = filterData["pmin"] as? String
        let max : String? = filterData["pmax"] as? String
        if (filterData["pmin"] as! String) != "" {
            tfMinPrice?.text = "Rp \(min ?? "")"
        }
        if (filterData["pmax"] as! String) != "" {
            tfMaxPrice?.text = "Rp \(max ?? "")"
        }
        self.priceRangeSlider.selectedMinValue = CGFloat(Double(min!)!)
        self.priceRangeSlider.selectedMaxValue = CGFloat(Double(max!)!)
        self.priceRangeSlider.minValue = minVal
        self.priceRangeSlider.maxValue = maxVal
        wholeSaleSwitchBtn.isOn = (filterData["wholesale"] as! Bool)
        selectedShopTypes.remove(at: selectedShopTypes.index(of: Official_Store)!)
        if official {
            selectedShopTypes.append(Official_Store)
        }
        selectedShopTypes.remove(at: selectedShopTypes.index(of: Gold_Merchant)!)
        if  fshop != "" {
            selectedShopTypes.append(Gold_Merchant)
        }
        self.shopTypeCollectionView.reloadData()
    }
    
    // MARK: - UICollectionView Delegate & DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedShopTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.shopTypeCollectionView.dequeueReusableCell(withReuseIdentifier: kShopTypeCollectionViewCell, for: indexPath) as! ShopTypeCollectionViewCell
        cell.titleLbl.text = selectedShopTypes[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CommonClass.widthOfString(withConstrainedHeight: 20, font: UIFont.systemFont(ofSize: 15), text: selectedShopTypes[indexPath.row])
        return CGSize.init(width: width + 60, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedShopTypes[indexPath.row] == Gold_Merchant {
            self.fshop = ""
        } else if selectedShopTypes[indexPath.row] == Official_Store {
            self.official = false
        }
        selectedShopTypes.remove(at: indexPath.row)
        self.shopTypeCollectionView.reloadData()
    }
    
    @IBAction func didTapApply(_ sender: Any) {
        var param : [String: Any] = [:]
        param["pmin"] = tfMinPrice.text?.replacingOccurrences(of: "Rp ", with: "")
        param["pmax"] = tfMaxPrice.text?.replacingOccurrences(of: "Rp ", with: "")
        param["wholesale"] = wholeSaleSwitchBtn.isOn
        param["official"] = official
        if fshop == "2" {
            param["fshop"] = fshop
        }
        self.delegate?.filterDataWith(data:param)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapReset(_ sender: Any) {
        self.priceRangeSlider.selectedMinValue = minVal
        self.priceRangeSlider.selectedMaxValue = maxVal
        self.priceRangeSlider.minValue = minVal
        self.priceRangeSlider.maxValue = maxVal
        selectedShopTypes = shopTypes
        self.shopTypeCollectionView.reloadData()
        self.wholeSaleSwitchBtn.isOn = false
        self.tfMinPrice.text = "Rp \(Int(minVal))"
        self.tfMaxPrice.text = "Rp \(Int(maxVal))"
        official = true
        fshop = "2"
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        self.tfMinPrice.text = "Rp \(Int(minValue))"
        self.tfMaxPrice.text = "Rp \(Int(maxValue))"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var text = textField.text?.replacingOccurrences(of: "Rp ", with: "")
        if text == "" {
            if textField == tfMinPrice {
                text = "\(Int(minVal))"
            } else {
               text = "\(Int(maxVal))"
            }
        }
        textField.text = "Rp " + text!
        if textField == tfMinPrice {
            self.priceRangeSlider.selectedMinValue = CGFloat(Double(text!)!)
        }else {
            self.priceRangeSlider.selectedMaxValue = CGFloat(Double(text!)!)
        }
        self.priceRangeSlider.minValue = minVal
        self.priceRangeSlider.maxValue = maxVal
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "shopTypesSegue"{
            let vc = segue.destination as! ShoptypesViewController
            vc.delegate = self
            vc.fshop = self.fshop
            vc.official = self.official
            didTapShopTypes = true
        }
    }
    
    func didSelectShopType(official: Bool, fshop: String) {
        self.fshop = fshop
        self.official = official
        if selectedShopTypes.count > 0 {
            if selectedShopTypes.contains(Official_Store) {
                selectedShopTypes.remove(at: selectedShopTypes.index(of: Official_Store)!)
            }
            if selectedShopTypes.contains(Gold_Merchant) {
                selectedShopTypes.remove(at: selectedShopTypes.index(of: Gold_Merchant)!)
            }
        }
        if fshop != "" {
            selectedShopTypes.append(Official_Store)
        }
        if official {
            selectedShopTypes.append(Gold_Merchant)
        }
        self.shopTypeCollectionView.reloadData()
    }
}
