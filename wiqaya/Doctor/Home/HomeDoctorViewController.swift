//
//  HomeDoctorViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/27/25.
//

import UIKit

class HomeDoctorViewController: UIViewController {

    
    @IBOutlet weak var doctorName: UILabel!
    
    @IBOutlet weak var today: UIButton!
    
    
    @IBOutlet weak var thisWeek: UIButton!
    
    
    @IBOutlet weak var thisMonth: UIButton!
    
    @IBOutlet weak var thisYear: UIButton!
    
    
    @IBOutlet weak var paymentsView: UIView!
    
    @IBOutlet weak var allPayments: UILabel!
    
    
    @IBOutlet weak var allBookingView: UIView!
    
    @IBOutlet weak var allBooking: UILabel!
    
    @IBOutlet weak var newBookingCollection: UICollectionView!
    
    @IBOutlet weak var commentsDoctorCollection: UICollectionView!
    
    @IBOutlet weak var periodButtonsView: UIView!
    
    
    var period : String = "ToDay"
    
    var newBookingArray = [nextDateItem]()
    var commentsarray = [Comment]()
    var animatedIndexes: Set<Int> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newBookingCollection.delegate = self
        newBookingCollection.dataSource = self
        
        commentsDoctorCollection.delegate = self
        commentsDoctorCollection.dataSource = self
        
        setFilter(selected: today)
        animateFilterBar()

        implementData ()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        periodButtonsView.layer.cornerRadius = 10
        periodButtonsView.layer.masksToBounds = true
        periodButtonsView.layer.borderWidth = 1
        periodButtonsView.layer.borderColor = UIColor(hex: "D2D2D2").cgColor

        setupShadow(for: paymentsView, cornerRadius: 20)
        
        setupShadow(for: allBookingView, cornerRadius: 20)
        
        
    }

    
    func animateButton(_ button: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        UIView.animate(withDuration: 0.08, animations: {
            button.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        }) { _ in
            UIView.animate(withDuration: 0.25,
                           delay: 0,
                           usingSpringWithDamping: 0.4,
                           initialSpringVelocity: 4,
                           options: .allowUserInteraction,
                           animations: {
                button.transform = .identity
            })
        }
    }
    
    func animateFilterBar() {
        guard let view = self.view.viewWithTag(999) else { return }
        
        UIView.animate(withDuration: 0.2, animations: {
            view.transform = CGAffineTransform(translationX: 8, y: 0)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                view.transform = .identity
            }
        }
    }
    
    // ✨ أنيميشن الخلايا
    func animateCell(_ cell: UICollectionViewCell, index: Int) {
        if animatedIndexes.contains(index) { return }
        animatedIndexes.insert(index)
        
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: 0, y: 20)
        
        UIView.animate(
            withDuration: 0.4,
            delay: 0.05 * Double(index),
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.3,
            options: .curveEaseOut,
            animations: {
                cell.alpha = 1
                cell.transform = .identity
            }, completion: nil
        )
    }
    

    
    func implementData () {
        newBookingArray.append(nextDateItem(
            doctorImage: UIImage(named: "DoctorImage")!,
            nameDoctor: "د. أحمد خالد",
            specialtyDoctor: "باطنة",
            clock: "4:00",
            date: "5 نوفمبر 2025"
        ))
        newBookingArray.append(nextDateItem(
            doctorImage: UIImage(named: "DoctorImage")!,
            nameDoctor: "د. ليلى عبد الله",
            specialtyDoctor: "عيون",
            clock: "7:00",
            date: "8 نوفمبر 2025"
        ))
        newBookingArray.append(nextDateItem(
            doctorImage: UIImage(named: "DoctorImage")!,
            nameDoctor: "د. ليلى عبد الله",
            specialtyDoctor: "عيون",
            clock: "7:00",
            date: "8 نوفمبر 2025"
        ))

        commentsarray.append(Comment(
            image: UIImage(named: "nurse")!,
            name: "ليلى عبد الله",
            rate: 1.0,
            comment: "دكتور محترم ومستمع جيد وتم تشخيصي من اول مرة بعد معاناة بلا فائدة"
        ))
        commentsarray.append(Comment(
            image: UIImage(named: "nurse")!,
            name: "ليلى عبد الله",
            rate: 3.5,
            comment: "دكتور محترم ومستمع جيد وتم تشخيصي من اول مرة بعد معاناة بلا فائدةدكتور محترم ومستمع جيد وتم تشخيصي من اول مرة بعد معاناة بلا فائدة"
        ))
        commentsarray.append(Comment(
            image: UIImage(named: "nurse")!,
            name: "ليلى عبد الله",
            rate: 5.0,
            comment: "دكتور محترم ومستمع جيد وتم تشخيصي من اول مرة بعد معاناة بلا فائدة"
        ))
        commentsarray.append(Comment(
            image: UIImage(named: "nurse")!,
            name: "ليلى عبد الله",
            rate: 2.0,
            comment: "دكتور محترم ومستمع جيد وتم تشخيصي من اول مرة بعد معاناة بلا فائدة"
        ))
    }
    
    
    @IBAction func todayButton(_ sender: UIButton) {
        animateButton(sender)

        setFilter(selected: sender)
        period = sender.currentTitle ?? ""
        print(period)
    }
    
    @IBAction func thisWeekButton(_ sender: UIButton) {
        animateButton(sender)

        setFilter(selected: sender)
        period = sender.currentTitle ?? ""
        print(period)
    }
    
    @IBAction func thisMonthButton(_ sender: UIButton) {
        animateButton(sender)

        setFilter(selected: sender)
        period = sender.currentTitle ?? ""
        print(period)
    }
    
    @IBAction func thisYearButton(_ sender: UIButton) {
        animateButton(sender)

        setFilter(selected: sender)
        period = sender.currentTitle ?? ""
        print(period)
    }
    @IBAction func allAppointmentButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Doctor", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "BookingForDoctor") as? BookingForDoctorViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: true)
        }
        
    }
    
    // MARK: - Filter UI Update
    func setFilter(selected: UIButton?) {
        let buttons = [today, thisWeek, thisMonth, thisYear]
        
        for button in buttons {
            guard let button = button else { continue }
            
            var config = UIButton.Configuration.plain()
            config.title = button.currentTitle
            config.baseForegroundColor = UIColor(hex: "434343")
            config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
            selected?.alpha = 0.6
            
            UIView.animate(withDuration: 0.25) {
                selected?.alpha = 1
            }
            
            button.setTitle(button.currentTitle, for: .normal)
            button.configuration = config
        }
        
        if let selected = selected {
            var config = UIButton.Configuration.filled()
            config.title = selected.currentTitle
            config.baseBackgroundColor = .systemBlue
            config.baseForegroundColor = .white
            config.cornerStyle = .medium
            config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
            
            selected.setTitle(selected.currentTitle, for: .normal)
            selected.configuration = config
        }
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

}
extension HomeDoctorViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == newBookingCollection{
            
            return newBookingArray.count
        } else{
            return commentsarray.count
        }
            
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == newBookingCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nextCell", for: indexPath) as! newBookingsDoctorCollectionViewCell
            cell.patiantImage.image = newBookingArray[indexPath.row].doctorImage
            cell.namepatiant.text = newBookingArray[indexPath.row].nameDoctor
            cell.clock.text = newBookingArray[indexPath.row].clock
            cell.date.text = newBookingArray[indexPath.row].date
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentsCollectionViewCell", for: indexPath) as! commentsDoctorCollectionViewCell
            cell.patiantImage.image = commentsarray[indexPath.row].image
            cell.patiantName.text = commentsarray[indexPath.row].name
            cell.rate = Double(commentsarray[indexPath.row].rate ?? 3.0)
            cell.lblComments.text = commentsarray[indexPath.row].comment
            return cell
        }
    }

    
}
