//
//  DonationViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 1/24/26.
//

import UIKit

class DonationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myTableView: UITableView!
    
    
    
    
    var array = [Donation]()
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.isScrollEnabled = false
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DonationTableViewCell
        cell.donorimage.image = array[indexPath.row].image
        cell.donorName.text = array[indexPath.row].name
        cell.donorService.text = array[indexPath.row].service
        cell.donorDescription.text = array[indexPath.row].deescription
        
        return cell
    }


}
struct Donation {
    var image: UIImage
    var name: String
    var service: String
    var deescription: String
}
