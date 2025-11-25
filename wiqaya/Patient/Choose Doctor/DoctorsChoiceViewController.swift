//
//  DoctorsChoiceViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/5/25.
//

import UIKit

class DoctorsChoiceViewController: UIViewController {
    var forMainTitle: String?
    var arrayCollection = [ItemCollection]()
    var arrayTable = [ItemTable]()
    var originalArrayTable = [ItemTable]()

    @IBOutlet weak var mainTitle: UILabel!
    
    @IBOutlet weak var back: UIButton!
    
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var description1: UILabel!
    
    @IBOutlet weak var searchbar: UIView!
    
    
    @IBOutlet weak var myCollection: UICollectionView!
    
    @IBOutlet weak var price: UIButton!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    
    @IBOutlet weak var gender: UIButton!
    @IBOutlet weak var lblGender: UILabel!

    @IBOutlet weak var available: UIButton!
    @IBOutlet weak var lblAvailabel: UILabel!
    
    
    @IBOutlet weak var myTable: UITableView!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollection.delegate = self
        myCollection.dataSource = self
        myTable.delegate = self
        myTable.dataSource = self
//        myTable.isScrollEnabled = false

        mainTitle.text = forMainTitle ?? "NON"
        setupSearchBar()
        setupDelegates()
        setupDummyData()
        setupMenus()
    }
    func setupMenus() {
        // PRICE MENU
        let priceMenu = UIMenu(title: "Select Price", children: [
            UIAction(title: "50 - 100") { [weak self] _ in
                self?.lblPrice.text = "50 - 100"
                self?.applyPriceFilter()
            },
            UIAction(title: "100 - 200") { [weak self] _ in
                self?.lblPrice.text = "100 - 200"
                self?.applyPriceFilter()
            },
            UIAction(title: "200 - 300") { [weak self] _ in
                self?.lblPrice.text = "200 - 300"
                self?.applyPriceFilter()
            }
        ])
        price.menu = priceMenu
        price.showsMenuAsPrimaryAction = true
        
        
        // GENDER MENU (تحديث اللابل فقط)
        let genderMenu = UIMenu(title: "Select Gender", children: [
            UIAction(title: "ذكر") { [weak self] _ in
                self?.lblGender.text = "ذكر"
            },
            UIAction(title: "أنثى") { [weak self] _ in
                self?.lblGender.text = "أنثى"
            }
        ])
        gender.menu = genderMenu
        gender.showsMenuAsPrimaryAction = true
        
        
        // AVAILABLE MENU (تحديث اللابل فقط)
        let availableMenu = UIMenu(title: "Availability", children: [
            UIAction(title: "اليوم") { [weak self] _ in
                self?.lblAvailabel.text = "اليوم"
            },
            UIAction(title: "هذا الاسبوع") { [weak self] _ in
                self?.lblAvailabel.text = "هذا الاسبوع"
            },
            UIAction(title: "الاسبوع القادم") { [weak self] _ in
                self?.lblAvailabel.text = "الاسبوع القادم"
            }
        ])
        available.menu = availableMenu
        available.showsMenuAsPrimaryAction = true
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
    func setupDelegates() {
        myCollection.delegate = self
        myCollection.dataSource = self
        myTable.delegate = self
        myTable.dataSource = self
    }
    
    private func setupDummyData() {
        // بيانات الـ Collection (تخصصات الأطباء مثلاً)
        arrayCollection = [
            ItemCollection(image: UIImage(named: "ear")!, title: "عيون"),
            ItemCollection(image: UIImage(named: "Brain")!, title: "مخ و اعصاب"),
            ItemCollection(image: UIImage(named: "Teeth")!, title: "اسنان"),
            ItemCollection(image: UIImage(named: "Bones")!, title: "عظام")
        ]
        
        // بيانات الـ Table (قائمة الأطباء)
        arrayTable = [
            ItemTable(image: UIImage(systemName: "person.fill")!,
                      nameDoctor: "Dr. Ahmad Alshafei",
                      specialtyDoctor: "عيون",
                      priceDoctor: "250",
                      rating: "4.0"),
            ItemTable(image: UIImage(systemName: "person.fill")!,
                      nameDoctor: "Dr. Ahmad Alshafei",
                      specialtyDoctor: "اسنان",
                      priceDoctor: "210",
                      rating: "4.0"),
            ItemTable(image: UIImage(systemName: "person.fill")!,
                      nameDoctor: "Dr. Ahmad Alshafei",
                      specialtyDoctor: "اسنان",
                      priceDoctor: "150",
                      rating: "4.0"),
            
            ItemTable(image: UIImage(systemName: "person.fill")!,
                      nameDoctor: "Dr. Sara Mahmoud",
                      specialtyDoctor: "عظام",
                      priceDoctor: "180",
                      rating: "4.5"),
            
            ItemTable(image: UIImage(systemName: "person.fill")!,
                      nameDoctor: "Dr. Omar Hassan",
                      specialtyDoctor: "مخ و اعصاب",
                      priceDoctor: "100",
                      rating: "4.1"),
            ItemTable(image: UIImage(systemName: "person.fill")!,
                      nameDoctor: "Dr. Omar Hassan",
                      specialtyDoctor: "مخ و اعصاب",
                      priceDoctor: "50",
                      rating: "4.1"),
            ItemTable(image: UIImage(systemName: "person.fill")!,
                      nameDoctor: "Dr. Omar Hassan",
                      specialtyDoctor: "اسنان",
                      priceDoctor: "300",
                      rating: "4.1"),
            ItemTable(image: UIImage(systemName: "person.fill")!,
                      nameDoctor: "Dr. Omar Hassan",
                      specialtyDoctor: "عيون",
                      priceDoctor: "99",
                      rating: "4.1"),
            ItemTable(image: UIImage(systemName: "person.fill")!,
                      nameDoctor: "Dr. Omar Hassan",
                      specialtyDoctor: "عيون",
                      priceDoctor: "100",
                      rating: "4.1"),
            ItemTable(image: UIImage(systemName: "person.fill")!,
                      nameDoctor: "Dr. Omar Hassan",
                      specialtyDoctor: "عيون",
                      priceDoctor: "300",
                      rating: "4.1")
        ]
        
        originalArrayTable = arrayTable

        myCollection.reloadData()
        myTable.reloadData()
    }
    
    func applyPriceFilter() {
        let priceText = lblPrice.text ?? ""
        
        // لو ما فيه رنج "X - Y" → رجع البيانات الأصلية
        if !priceText.contains("-") {
            arrayTable = originalArrayTable
            myTable.reloadData()
            return
        }
        
        // نتوقع الشكل: "50 - 100"
        let parts = priceText.components(separatedBy: "-")
            .map { $0.trimmingCharacters(in: .whitespaces) }
        
        guard parts.count == 2,
              let min = Int(parts[0]),
              let max = Int(parts[1]) else {
            arrayTable = originalArrayTable
            myTable.reloadData()
            return
        }
        
        arrayTable = originalArrayTable.filter { doctor in
            if let price = Int(doctor.priceDoctor) {
                return price >= min && price <= max
            }
            return false
        }
        
        myTable.reloadData()
    }

    
    
    
    
    @IBAction func backButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "reservation") as? reservationViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }
    }
    
    
    @IBAction func bookingButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "Booking") as? BookingViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }
    }
    
    @IBAction func detailsButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "DetailsDoctor") as? DetailsDoctorViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }

    }
    
    
    
}
extension DoctorsChoiceViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cellCollection", for: indexPath) as! DoctorsChoiceCollectionViewCell
        
        let item = arrayCollection[indexPath.row]
        cell.imageView.image = item.image
        cell.nameLabel.text = item.title

        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
}
extension DoctorsChoiceViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath) as! DoctorsChoiceTableViewCell
        
        let item = arrayTable[indexPath.row]
        cell.image1.image = item.image
        cell.nameDoctor.text = item.nameDoctor
        cell.specialtyDoctor.text = item.specialtyDoctor
        cell.priceDoctor.text = item.priceDoctor
        cell.rating.text = item.rating

        return cell
    }
}
struct ItemCollection {
    var image : UIImage
    var title : String
}
struct ItemTable {
    var image : UIImage
    var nameDoctor : String
    var specialtyDoctor : String
    var priceDoctor : String
    var rating : String
}
extension UIView {
    func applyPrimaryGradient1() {
        // نحذف أي تدرجات قديمة
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "#4786F5").cgColor,
            UIColor(hex: "#2B73F3").cgColor,
            UIColor(hex: "#3077F3").cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
