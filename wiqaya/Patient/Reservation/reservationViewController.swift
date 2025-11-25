//
//  reservationViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/4/25.
//

import UIKit

class reservationViewController: UIViewController {
    var array = [specialization]()
    
    @IBOutlet weak var searchbar: UIView!
    
    @IBOutlet weak var mytableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mytableView.delegate = self
        mytableView.dataSource = self
        array.append(specialization(image: UIImage(named: "ear")!, name: "عيون", specializ: "مجموعة من الاطباء الخبراء في مكان واحد"))
        array.append(specialization(image: UIImage(named: "Brain")!, name: "مخ و أعصاب", specializ: "مجموعة من الاطباء الخبراء في مكان واحد"))
        array.append(specialization(image: UIImage(named: "Teeth")!, name: "أسنان", specializ: "مجموعة من الاطباء الخبراء في مكان واحد"))
        array.append(specialization(image: UIImage(named: "Bones")!, name: "عظام", specializ: "مجموعة من الاطباء الخبراء في مكان واحد"))
        mytableView.rowHeight = UITableView.automaticDimension
        mytableView.estimatedRowHeight = 50

        setupSearchBar()
    }
    
    private func setupSearchBar() {
        // تحميل الـ ViewController من الـ XIB
        let searchVC = SearchCistomVC(nibName: "SearchCistomVC", bundle: nil)
        addChild(searchVC) // مهم جداً عشان تبقى العلاقة مظبوطة بين الـ VCs
        searchVC.view.frame = searchbar.bounds
        searchVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        searchbar.addSubview(searchVC.view)
        searchVC.didMove(toParent: self)
    }

    
    @IBAction func backButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "HomeTabBar") as? HomeTabBarViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: true)
        }
    }
    
    

}
extension reservationViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mytableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SpecializationsTableViewCell
        
        // نجيب العنصر الحالي من المصفوفة
        let item = array[indexPath.row]
        
        // نعين البيانات في عناصر الخلية
        cell.ear.image = item.image
        cell.nameDoctor.text = item.name
        cell.specializationDoctor.text = item.specializ
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "doctorsChoice") as? DoctorsChoiceViewController {
            loginVC.forMainTitle = array[indexPath.row].name
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }
    }
}
struct specialization {
    var image : UIImage
    var name : String
    var specializ : String
}
