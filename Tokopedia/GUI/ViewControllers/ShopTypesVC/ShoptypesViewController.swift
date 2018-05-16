//
//  ShoptypesViewController.swift
//  Tokopedia
//
//  Created by Manoj Saini on 15/05/18.
//  Copyright © 2018 MDS. All rights reserved.
//

import UIKit

protocol kShoptypesViewControllerDelegate {
    func didSelectShopType(official:Bool, fshop: String)
}

class ShoptypesViewController: BaseViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var delegate : kShoptypesViewControllerDelegate?
    var fshop: String = "2"
    var official : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let shopTypeCellNib = UINib(nibName: kShopTypeTableViewCell, bundle: nil)
        self.tableView.register(shopTypeCellNib, forCellReuseIdentifier:kShopTypeTableViewCell)
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: kShopTypeTableViewCell, for: indexPath) as! ShopTypeTableViewCell
        cell.selectionStyle = .none
        cell.titleLbl.text = shopTypes[indexPath.row]
        if indexPath.row == 0 && fshop == "2"{
            cell.checkboxBtn.isSelected = true
        }
        else if indexPath.row == 1 && official{
            cell.checkboxBtn.isSelected = true
        } else {
            cell.checkboxBtn.isSelected = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @IBAction func didTapReset(_ sender: Any) {
        official = true
        fshop = "2"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            if fshop == "2" {
                fshop = ""
            } else {
                fshop = "2"
            }
        }
        else if indexPath.row == 1{
            if official {
                official = false
            } else {
                official = true
            }
        }
        self.tableView.reloadData()
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapApply(_ sender: Any) {
        self.delegate?.didSelectShopType(official: official, fshop: fshop)
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
