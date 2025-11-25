//
//  HomeViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/30/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var namePatient: UILabel!
    
    @IBOutlet weak var viewSearch: UIView!
    
    
    @IBOutlet weak var ViewAppoin: UIView!
    
    @IBOutlet weak var viewTimeAppoin: UIView!
    
    
    @IBOutlet weak var viewOtherContent: UIView!
    
    @IBOutlet weak var viewparamedicNearby: UIView!
    
    @IBOutlet weak var viewBookAppointment: UIView!
    
    @IBOutlet weak var viewFamousDoctors: UIView!
    
    
    @IBOutlet weak var myCollection: UICollectionView!
    
    @IBOutlet weak var nextDateCollection: UICollectionView!
    
    
    @IBOutlet weak var bookDate: UIButton!
    
    @IBOutlet weak var lookingForParamedic: UIButton!
    
    
    
    
    var servesArray = [servesItem]()
    var nextDateArray = [nextDateItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollection.delegate = self
        myCollection.dataSource = self
        nextDateCollection.delegate = self
        nextDateCollection.dataSource = self

        bookDate.tintColor = UIColor(hex: "#6161FF")
        
        lookingForParamedic.tintColor = UIColor(hex: "#E6474F")
        ViewAppoin.isHidden = false
        ViewAppoin.layer.cornerRadius = 10
//        viewTimeAppoin.layer.cornerRadius = 10
        viewBookAppointment.layer.cornerRadius = 20

        viewparamedicNearby.layer.cornerRadius = 20

        viewFamousDoctors.layer.cornerRadius = 10
        
        
        
        if let layout = nextDateCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 16 // المسافة بين كل خليتين
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        nextDateCollection.showsHorizontalScrollIndicator = true
        nextDateCollection.decelerationRate = .fast

        
        
        
        servesArray.append(servesItem(image: UIImage(named: "DoctorImage")!, label: "طبيب"))
        servesArray.append(servesItem(image: UIImage(named: "Donors")!, label: "متبرعون"))
        servesArray.append(servesItem(image: UIImage(named: "nurse")!, label: "ممرضة"))
        servesArray.append(servesItem(image: UIImage(named: "Medications")!, label: "ادوية"))
        servesArray.append(servesItem(image: UIImage(named: "HomeCare")!, label: "رعاية منزلية"))
        
        nextDateArray.append(nextDateItem(
            doctorImage: UIImage(named: "DoctorImage")!,
            nameDoctor: "د. أحمد خالد",
            specialtyDoctor: "باطنة",
            clock: "4:00",
            date: "5 نوفمبر 2025"
        ))
        nextDateArray.append(nextDateItem(
            doctorImage: UIImage(named: "DoctorImage")!,
            nameDoctor: "د. ليلى عبد الله",
            specialtyDoctor: "عيون",
            clock: "7:00",
            date: "8 نوفمبر 2025"
        ))
        nextDateArray.append(nextDateItem(
            doctorImage: UIImage(named: "DoctorImage")!,
            nameDoctor: "د. ليلى عبد الله",
            specialtyDoctor: "عيون",
            clock: "7:00",
            date: "8 نوفمبر 2025"
        ))


    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Book Appointment
        setupShadow(for: viewBookAppointment, cornerRadius: 20)
        
        // Paramedic Nearby
        setupShadow(for: viewparamedicNearby, cornerRadius: 20)
        
        // Famous Doctors
        setupShadow(for: viewFamousDoctors, cornerRadius: 10)
        
//        setupShadow(for: nextDateCollection, cornerRadius: 10)
        
    }

    private func setupShadow(for view: UIView, cornerRadius: CGFloat) {
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 6
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: cornerRadius).cgPath
    }

    
    @IBAction func bookAppointmentTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "reservation") as? reservationViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: true)
        }
    }
    @IBAction func lookingParamedicButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "ParamedicNearby") as? ParamedicNearbyViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: true)
        }

    }

    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myCollection {
            return servesArray.count > 0 ? servesArray.count : 1
        } else if collectionView == nextDateCollection {
            return nextDateArray.count > 0 ? nextDateArray.count : 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // الحالة الأولى: collection الخاصة بالخدمات
        if collectionView == myCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! servicesCollectionViewCell
            
            if servesArray.count > 0 {
                let item = servesArray[indexPath.row]
                cell.myimage.image = item.image
                cell.mylabel.text = item.label
                cell.mylabel.textColor = .label
            } else {
                cell.myimage.image = UIImage(systemName: "exclamationmark.triangle")
                cell.mylabel.text = "لا توجد خدمات متوفرة حالياً"
//                cell.mylabel.textColor = .gray
//                cell.mylabel.textAlignment = .center
            }
            return cell
        }
        
        // الحالة الثانية: collection الخاصة بالمواعيد القادمة
        else if collectionView == nextDateCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nextCell", for: indexPath) as! nextDatesCollectionViewCell
            
            if nextDateArray.count > 0 {
                let item = nextDateArray[indexPath.row]
                cell.doctorImage.image = item.doctorImage
                cell.nameDoctor.text = item.nameDoctor
                cell.specialtyDoctor.text = item.specialtyDoctor
                cell.clock.text = item.clock
                cell.date.text = item.date
            } else {
                // خلية placeholder
                cell.doctorImage.image = UIImage(systemName: "calendar.badge.exclamationmark")
                cell.nameDoctor.text = "لا توجد مواعيد حالياً"
                cell.specialtyDoctor.text = ""
                cell.clock.text = ""
                cell.date.text = ""
            }
            return cell
        }

        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == nextDateCollection {
            return CGSize(width: 400, height: collectionView.bounds.height)
        } else {
            return CGSize(width: 100, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == nextDateCollection ? 16 : 12
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == nextDateCollection {
            // نحسب الهوامش بناءً على عرض الـ collection وعرض الخلية
            let totalInset = (collectionView.frame.width - 340) / 2
            return UIEdgeInsets(top: 0, left: totalInset, bottom: 0, right: totalInset)
        } else {
            return .zero
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // تأكد إننا بنتعامل مع nextDateCollection فقط
        guard scrollView == nextDateCollection else { return }
        
        guard let layout = nextDateCollection.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        // عرض الخلية مع المسافة
        let cellWidthIncludingSpacing = 345 + layout.minimumLineSpacing
        
        // الموضع الحالي للتمرير
        var offset = targetContentOffset.pointee
        
        // نحسب أي خلية أقرب للمكان الحالي
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        // نحرك الـ scroll علشان تثبت الخلية في النص بالضبط
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left,
                         y: -scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
    }

    
    

}

    

struct servesItem {
    var image : UIImage
    var label : String
}
struct nextDateItem {
    var doctorImage : UIImage
    var nameDoctor : String
    var specialtyDoctor : String
    var clock : String
    var date : String
}
