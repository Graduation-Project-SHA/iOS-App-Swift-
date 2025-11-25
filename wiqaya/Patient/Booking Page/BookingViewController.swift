//
//  BookingViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/16/25.
//

import UIKit

class BookingViewController: UIViewController {
    
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var dayCollectionView: UICollectionView!
    @IBOutlet weak var morningCollectionView: UICollectionView!
    @IBOutlet weak var eveningCollectionView: UICollectionView!
    
    
    
    var selectedMorningIndexPath: IndexPath?
    var selectedEveningIndexPath: IndexPath?
    
    
    var selectedDayIndexPath: IndexPath?

    
    
    var dayArray = [Day1]()
    var morningArray = [Morning]()
    var eveningArray = [Evening]()
    var selectedIndexPath: IndexPath?
    var selectedDay : Bool = false
    var selectedMorning : Bool = false
    var selectedEvening : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        morningCollectionView.allowsMultipleSelection = false
        eveningCollectionView.allowsMultipleSelection = false

        // تعيين الـ delegate و الـ dataSource لجميع الـ collection views
        [dayCollectionView, morningCollectionView, eveningCollectionView].forEach {
            $0?.delegate = self
            $0?.dataSource = self
        }

        // تعيين الشهر الحالي في `month`
        month.text = formatMonth(Date())
        
        // ملء البيانات
        loadData()
    }
    
    // دالة لتحميل البيانات
    func loadData() {
        // ملء dayArray
        dayArray.append(Day1(day: "Thursday", dateDay: Date().addingTimeInterval(86400)))
        dayArray.append(Day1(day: "Wednesday", dateDay: Date().addingTimeInterval(2 * 86400)))
        dayArray.append(Day1(day: "Thursday", dateDay: Date().addingTimeInterval(3 * 86400)))
        dayArray.append(Day1(day: "Wednesday", dateDay: Date().addingTimeInterval(4 * 86400)))
        dayArray.append(Day1(day: "Thursday", dateDay: Date().addingTimeInterval(86400)))
        dayArray.append(Day1(day: "Wednesday", dateDay: Date().addingTimeInterval(2 * 86400)))
        dayArray.append(Day1(day: "Thursday", dateDay: Date().addingTimeInterval(3 * 86400)))
        dayArray.append(Day1(day: "Wednesday", dateDay: Date().addingTimeInterval(4 * 86400)))
        dayArray.append(Day1(day: "Thursday", dateDay: Date().addingTimeInterval(86400)))
        dayArray.append(Day1(day: "Wednesday", dateDay: Date().addingTimeInterval(2 * 86400)))
        dayArray.append(Day1(day: "Thursday", dateDay: Date().addingTimeInterval(3 * 86400)))
        dayArray.append(Day1(day: "Wednesday", dateDay: Date().addingTimeInterval(4 * 86400)))
        // ملء morningArray
        morningArray.append(Morning(clock: "12:00"))
        morningArray.append(Morning(clock: "1:00"))
        morningArray.append(Morning(clock: "2:00"))
        morningArray.append(Morning(clock: "12:00"))
        morningArray.append(Morning(clock: "1:00"))
        morningArray.append(Morning(clock: "2:00"))
        morningArray.append(Morning(clock: "12:00"))
        morningArray.append(Morning(clock: "1:00"))
        morningArray.append(Morning(clock: "2:00"))
        
        // ملء eveningArray
        eveningArray.append(Evening(clock: "12:00"))
        eveningArray.append(Evening(clock: "1:00"))
        eveningArray.append(Evening(clock: "2:00"))
        eveningArray.append(Evening(clock: "12:00"))
        eveningArray.append(Evening(clock: "1:00"))
        eveningArray.append(Evening(clock: "2:00"))

        // إعادة تحميل الـ collection views بعد تحميل البيانات
        dayCollectionView.reloadData()
        morningCollectionView.reloadData()
        eveningCollectionView.reloadData()
    }
    
    @IBAction func paymentButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "Payment") as? PaymentViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }

    }
    
    @IBAction func backButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "DetailsDoctor") as? DetailsDoctorViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }
    }
    
}

extension BookingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // تعيين عدد العناصر في كل قسم
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dayCollectionView {
            return dayArray.count
        } else if collectionView == morningCollectionView {
            return morningArray.count
        } else {
            return eveningArray.count
        }
    }
    
    // تخصيص الخلايا لكل CollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dayCollectionView {
            let cell = dayCollectionView.dequeueReusableCell(withReuseIdentifier: "Daycell", for: indexPath) as! DayCollectionViewCell
            let dayData = dayArray[indexPath.row]
            cell.day.text = formatDay(dayData.dateDay)
            cell.dateDay.text = formatDate(dayData.dateDay)
            return cell
        } else if collectionView == morningCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Morningcell", for: indexPath) as! MorningCollectionViewCell
            let morningData = morningArray[indexPath.row]
            cell.clock.text = morningData.clock
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Eveningcell", for: indexPath) as! EveningCollectionViewCell
            let eveningData = eveningArray[indexPath.row]
            cell.clock.text = eveningData.clock
            return cell
        }
        
        

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == dayCollectionView {
            // شيل تلوين القديم لو فيه
            if let oldIndex = selectedDayIndexPath,
               let oldCell = collectionView.cellForItem(at: oldIndex) as? DayCollectionViewCell {
                oldCell.containerView.backgroundColor = .white
            }
            
            selectedDayIndexPath = indexPath
            
            if let cell = collectionView.cellForItem(at: indexPath) as? DayCollectionViewCell {
                cell.containerView.backgroundColor = UIColor(hex: "#2B73F3")
            }
            
        } else if collectionView == morningCollectionView {
            // 1) ألغِ أي اختيار سابق للصباح
            if let oldIndex = selectedMorningIndexPath,
               let oldCell = collectionView.cellForItem(at: oldIndex) as? MorningCollectionViewCell {
                oldCell.backgroundColor = .white
                collectionView.deselectItem(at: oldIndex, animated: false)
            }
            
            // 2) ألغِ أي اختيار للمساء
            if let eveningIndex = selectedEveningIndexPath,
               let eveningCell = eveningCollectionView.cellForItem(at: eveningIndex) as? EveningCollectionViewCell {
                eveningCell.backgroundColor = .white
                eveningCollectionView.deselectItem(at: eveningIndex, animated: false)
            }
            selectedEveningIndexPath = nil
            
            // 3) احفظ التحديد الجديد للصباح
            selectedMorningIndexPath = indexPath
            
            if let cell = collectionView.cellForItem(at: indexPath) as? MorningCollectionViewCell {
                cell.backgroundColor = UIColor(hex: "#2B73F3")
            }
            
        } else if collectionView == eveningCollectionView {
            // 1) ألغِ أي اختيار سابق للمساء
            if let oldIndex = selectedEveningIndexPath,
               let oldCell = collectionView.cellForItem(at: oldIndex) as? EveningCollectionViewCell {
                oldCell.backgroundColor = .white
                collectionView.deselectItem(at: oldIndex, animated: false)
            }
            
            // 2) ألغِ أي اختيار للصباح
            if let morningIndex = selectedMorningIndexPath,
               let morningCell = morningCollectionView.cellForItem(at: morningIndex) as? MorningCollectionViewCell {
                morningCell.backgroundColor = .white
                morningCollectionView.deselectItem(at: morningIndex, animated: false)
            }
            selectedMorningIndexPath = nil
            
            // 3) احفظ التحديد الجديد للمساء
            selectedEveningIndexPath = indexPath
            
            if let cell = collectionView.cellForItem(at: indexPath) as? EveningCollectionViewCell {
                cell.backgroundColor = UIColor(hex: "#2B73F3")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if collectionView == dayCollectionView,
           let cell = collectionView.cellForItem(at: indexPath) as? DayCollectionViewCell {
            cell.containerView.backgroundColor = .white
        } else if collectionView == morningCollectionView,
                  let cell = collectionView.cellForItem(at: indexPath) as? MorningCollectionViewCell {
            cell.backgroundColor = .white
        } else if collectionView == eveningCollectionView,
                  let cell = collectionView.cellForItem(at: indexPath) as? EveningCollectionViewCell {
            cell.backgroundColor = .white
        }
    }


    // تنسيق الشهر الحالي
    func formatMonth(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM - yyyy"  // التنسيق المطلوب مثل "10 - 2025"
        return dateFormatter.string(from: date)
    }
    
    // تنسيق اليوم (مثل "Wed" أو "Thu")
    func formatDay(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"  // أول 3 أحرف من اسم اليوم (مثل Wed, Thu)
        return dateFormatter.string(from: date)
    }
    
    // تنسيق التاريخ بشكل عام
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"  // فقط اليوم (مثلاً: 10)
        return dateFormatter.string(from: date)
    }
    
    // تنسيق الساعة (مثل "11:00")
    func formatClock(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm"  // مثل "11:00 AM" أو "11:00 PM"
        return dateFormatter.string(from: date)
    }
}

struct Day1 {
    var day: String
    var dateDay: Date
}

struct Morning {
    var clock: String
}

struct Evening {
    var clock: String
}

