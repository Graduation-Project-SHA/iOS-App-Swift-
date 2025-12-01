//
//  DailyWorkingTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/1/25.
//

import UIKit

class DailyWorkingTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var lblDay: UILabel!
    
    @IBOutlet weak var add: UIButton!
    
    @IBOutlet weak var tableViewDailayTimeWorking: UITableView!
    
    var array = [DailayTimeItem]()
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWorkingTableViewCell2") as! DailayTimeTableViewCell
        
        return cell
    }

}
struct DailayTimeItem {
    var from : String
    var to : String
}
