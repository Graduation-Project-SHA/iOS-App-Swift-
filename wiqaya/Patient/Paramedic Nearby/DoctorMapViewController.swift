//  DoctorMapViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 1/22/26.
//

import UIKit

class DoctorMapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var arrayOfDoctors = [DoctorMap]()
    
    // ✅ Added: Callback للـ parent (الخريطة) لما تختار دكتور
    var onDoctorSelected: ((Int, DoctorMap) -> Void)?
    
    // ✅ Added: عشان الوميض بعد الـ scroll
    private var flashAfterScrollIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        implementation()
    }
    
    func implementation() {
        arrayOfDoctors.removeAll()
        
        arrayOfDoctors.append(DoctorMap(image: #imageLiteral(resourceName: "Doctor"),
                                        name: "Dr. Ali Alhaider",
                                        specialization: "General Medicine",
                                        numberOfRating: 4,   // (Int(4.5) كانت هتطلع 4 برضو)
                                        rate: 4.5,
                                        salary: 1000))
        
        arrayOfDoctors.append(DoctorMap(image: #imageLiteral(resourceName: "Doctor"),
                                        name: "Dr. Ali Alhaider",
                                        specialization: "General Medicine",
                                        numberOfRating: 900,
                                        rate: 3.9,
                                        salary: 1299))
        
        arrayOfDoctors.append(DoctorMap(image: #imageLiteral(resourceName: "Doctor"),
                                        name: "Dr. Ali Alhaider",
                                        specialization: "General Medicine",
                                        numberOfRating: 500,
                                        rate: 4.5,
                                        salary: 999))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfDoctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DoctorMapTableViewCell
        
        cell.doctorImage.image = arrayOfDoctors[indexPath.row].image
        cell.doctorName.text = arrayOfDoctors[indexPath.row].name
        cell.doctorSpecialization.text = arrayOfDoctors[indexPath.row].specialization
        cell.numberOfRate.text = "\(arrayOfDoctors[indexPath.row].numberOfRating)"
        cell.rate.text = "\(arrayOfDoctors[indexPath.row].rate)"
        cell.salary.text = "\(arrayOfDoctors[indexPath.row].salary)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    // ✅ Added: لما تختار row يدويًا من الجدول
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(arrayOfDoctors[indexPath.row].name)
        onDoctorSelected?(indexPath.row, arrayOfDoctors[indexPath.row])
    }
    
    // ✅ Added: اختيار row من برّه
    func selectDoctorRow(index: Int, animated: Bool = true) {
        guard index >= 0, index < arrayOfDoctors.count else { return }
        let indexPath = IndexPath(row: index, section: 0)
        myTableView.selectRow(at: indexPath, animated: animated, scrollPosition: .middle)
        onDoctorSelected?(index, arrayOfDoctors[index])
    }
    
    // ✅ Added: وميض للـ Row
    func flashRow(index: Int) {
        guard index >= 0, index < arrayOfDoctors.count else { return }
        
        loadViewIfNeeded()
        myTableView.layoutIfNeeded()
        
        let indexPath = IndexPath(row: index, section: 0)
        
        myTableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        flashAfterScrollIndex = index
        myTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        
        // لو ظاهرة بالفعل
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let cell = self.myTableView.cellForRow(at: indexPath) {
                self.flashAfterScrollIndex = nil
                self.flashCellOverlay(cell)
            }
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard let idx = flashAfterScrollIndex else { return }
        flashAfterScrollIndex = nil
        
        let indexPath = IndexPath(row: idx, section: 0)
        if let cell = myTableView.cellForRow(at: indexPath) {
            flashCellOverlay(cell)
        }
    }
    
    private func flashCellOverlay(_ cell: UITableViewCell) {
        let overlayTag = 987654
        cell.contentView.viewWithTag(overlayTag)?.removeFromSuperview()
        
        let overlay = UIView(frame: cell.contentView.bounds)
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.backgroundColor = UIColor.systemGray4
        overlay.alpha = 0.0
        overlay.isUserInteractionEnabled = false
        overlay.tag = overlayTag
        overlay.layer.cornerRadius = 12
        overlay.clipsToBounds = true
        
        cell.contentView.addSubview(overlay)
        
        UIView.animate(withDuration: 0.12, animations: {
            overlay.alpha = 0.45
            cell.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 0.15, options: [.curveEaseOut], animations: {
                overlay.alpha = 0.0
                cell.transform = .identity
            }, completion: { _ in
                overlay.removeFromSuperview()
            })
        }
    }
}

struct DoctorMap {
    var image: UIImage
    var name: String
    var specialization: String
    var numberOfRating: Int
    var rate: Double
    var salary: Double
}
