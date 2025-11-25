//
//  DetailsDoctorViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/15/25.
//
import UIKit
import MapKit

class DetailsDoctorViewController: UIViewController {
    
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var DoctorImage: UIImageView!
    @IBOutlet weak var DoctorName: UILabel!
    @IBOutlet weak var DoctorSpecialty: UILabel!
    @IBOutlet weak var DoctorPrice: UILabel!
    @IBOutlet weak var WorkingHours: UILabel!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var numberOfComment: UILabel!
    
    
    
    var array = [Comment]()  // تعديل اسم struct إلى Comment
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myMap.layer.cornerRadius = 10
        myTableView.dataSource = self
        myTableView.delegate = self
        bio.text = "دكتور احمد الشافعي، أخصائي أسنان، واعمل في القصر العيني."
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.estimatedRowHeight = 100   // رقم تقريبي بس عشان الأداء

        loadData()
        numberOfComment.text = " (\(array.count.description))"

    }
    func loadData() {
       
        let comment1 = Comment(image: UIImage(named: "Doctor"), name: "John Doe", rate: 3.5, date: "اليوم", comment: "قمة في الذوق والادب وخبرة في مجالها")
        let comment2 = Comment(image: UIImage(named: "Doctor"), name: "Jane Smith", rate: 5.0, date: "امس", comment: "لما روحت للدكتورة مرام، أول حاجة عجبتني إنها سمعت كل شكوتي بالتفصيل ومقاطعتنيش، وكانت صبورة جداً. شرحتلي المشكلة ببساطة ومن غير مصطلحات طبية مكلكعة")
        let comment3 = Comment(image: UIImage(named: "Doctor"), name: "John Doe", rate: 3.5, date: "اليوم", comment: "قمة في الذوق والادب وخبرة في  مقمة في الذوق والادب وخبرة في  مجالها")
        let comment4 = Comment(image: UIImage(named: "Doctor"), name: "Jane Smith", rate: 5.0, date: "امس", comment: "لما روحت للدكتورة مرام، أول حاجة عجبتني إنها سمعت كل شكوتي بالتفصيل ومقاطعتنيش، وكانت صبورة جداً. شرحتلي المشكلة ببساطة ومن غير مصطلحات طبية مكلكعة أول حاجة عجبتني إنها سمعت كل شكوتي بالتفصيل ومقاطعتنيش، وكانت صبورة جداً. شرحتلي المشكلة ببساطة ومن غير مصطلحات طبية مكلكعة")
        let comment5 = Comment(image: UIImage(named: "Doctor"), name: "Jane Smith", rate: 5.0, date: "امس", comment: "لما روحت للدكتورة مرام، أول حاجة عجبتني إنها سمعت كل شكوتي بالتفصيل ومقاطعتنيش، وكانت صبورة جداً. شرحتلي المشكلة ببساطة ومن غير مصطلحات طبية مكلكعة أول حاجة عجبتني إنها سمعت كل شكوتي بالتفصيل ومقاطعتنيش، وكانت صبورة جداً. شرحتلي المشكلة ببساطة ومن غير مصطلحات طبية مكلكعة")
        let comment6 = Comment(image: UIImage(named: "Doctor"), name: "Jane Smith", rate: 5.0, date: "امس", comment: "لما روحت للدكتورة مرام، أول حاجة عجبتني إنها سمعت كل شكوتي بالتفصيل ومقاطعتنيش، وكانت صبورة جداً. شرحتلي المشكلة ببساطة ومن غير مصطلحات طبية مكلكعة أول حاجة عجبتني إنها سمعت كل شكوتي بالتفصيل ومقاطعتنيش، وكانت صبورة جداً. شرحتلي المشكلة ببساطة ومن غير مصطلحات طبية مكلكعة")
        
        // إضافة التعليقات للمصفوفة
        array = [comment1, comment2,comment3, comment4,comment5, comment6]
        
        // إعادة تحميل الجدول بعد إضافة البيانات
        myTableView.reloadData()
    }

    
    @IBAction func bookingButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "Booking") as? BookingViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }

    }
    
    @IBAction func backButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "doctorsChoice") as? DoctorsChoiceViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }
    }
    
}

extension DetailsDoctorViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count // يعرض عدد العناصر في الـ array
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue the cell and cast it
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommentsTableViewCell
        
        // الحصول على بيانات التعليق من المصفوفة بناءً على الـ indexPath
        let commentData = array[indexPath.row]
        
        // تعيين البيانات لكل عنصر في الخلية
        cell.patientImage.image = commentData.image
        cell.patientName.text = commentData.name
        cell.rate.text = "\(commentData.rate ?? 3.0)"
        cell.updateStars(rate: commentData.rate ?? 3.0)
        cell.dateComment.text = commentData.date
        cell.comment.text = commentData.comment
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let commentText = array[indexPath.row].comment ?? ""
        
        // تقدير ارتفاع النص بناءً على الطول
        let font = UIFont.systemFont(ofSize: 14)
        let maxWidth = tableView.frame.width - 40 // المسافة المتاحة للتعليق (مع حواف)
        let maxSize = CGSize(width: maxWidth, height: .infinity)
        
        let textHeight = commentText.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).height
        
        // إضافة هامش إضافي، مثلاً 50، لتغطية الـ padding وغيره
        return max(textHeight + 70, 80) // الحد الأدنى سيكون 80 لتجنب التصغير الزائد
    }
}

struct Comment {
    
    var image : UIImage?
    var name : String?
    var rate : Double?
    var date : String?
    var comment : String?
}
