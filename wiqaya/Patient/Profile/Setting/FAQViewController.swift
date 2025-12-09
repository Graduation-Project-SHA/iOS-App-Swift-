//
//  FAQViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/8/25.
//

import UIKit

class FAQViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    var array = [FAQModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.estimatedRowHeight = 65
        myTableView.rowHeight = UITableView.automaticDimension
        implement ()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        // نخلي الكنترولر الحالي هو الـ delegate
        navigationController?.interactivePopGestureRecognizer?.delegate = self

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        appearance.shadowColor = .clear        // أهم واحدة
        appearance.shadowImage = UIImage()     // بعض الأنظمة تحتاجها
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        navigationItem.title = "اسئلة شائعة"

        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    func implement () {
        array.append(FAQModel(question: "ماذا يجب أن أتوقع خلال موعد الطبيب؟", answer: "خلال موعدك مع الطبيب، يمكنك أن تتوقع مناقشة تاريخك الطبي، والأعراض أو المخاوف الحالية، وأي أدوية أو علاجات تتناولها. من المرجح أن يقوم الطبيب بإجراء فحص جسدي وقد يطلب اختبارات أو إجراءات إضافية إذا لزم الأمر."))
        array.append(FAQModel(question: "ما الذي يجب أن أحضره إلى موعدي مع الطبيب؟", answer: "عند حضور موعدك مع الطبيب، يُفضَّل إحضار قائمة بالأدوية التي تستخدمها، بما في ذلك الفيتامينات والمكمّلات الغذائية. كما يُستحسن أن تُحضِر معك أي تقارير أو تحاليل أو أشعة سابقة، إضافة إلى قائمة بالأعراض أو الأسئلة التي ترغب في مناقشتها. هذا يساعد الطبيب على فهم حالتك بشكل أفضل ويضمن عدم نسيان أي معلومات مهمة."))
        array.append(FAQModel(question: "ماذا لو كنتُ بحاجة إلى إلغاء أو إعادة جدولة موعدي؟", answer: "إذا كنت بحاجة إلى إلغاء أو إعادة جدولة موعدك، فمن الأفضل التواصل مع العيادة في أقرب وقت ممكن. سيتيح ذلك لهم تعديل الموعد وتوفير وقت لمريض آخر. غالبًا ما توفر العيادات طرقًا سهلة للتعديل، سواء عبر الهاتف أو التطبيق الإلكتروني أو الرسائل النصية."))
        array.append(FAQModel(question: "كيف يمكنني تحديد موعد مع الطبيب؟", answer: "يمكنك حجز موعد مع الطبيب من خلال الاتصال بالعيادة مباشرة، أو استخدام التطبيق الإلكتروني الخاص بها إذا كان متوفّرًا. بعض المراكز الطبية تتيح أيضًا الحجز عبر الموقع الإلكتروني أو من خلال خدمة العملاء. اختر الوقت المناسب لك، وسيتم تأكيد الموعد بعد تسجيل بياناتك."))
        array.append(FAQModel(question: "في أي وقت يجب أن أصل لموعد طبيبي؟", answer: "يُفضَّل الوصول قبل موعدك بـ 10 إلى 15 دقيقة لإتمام أي إجراءات مطلوبة مثل التسجيل أو تحديث المعلومات. الوصول المبكر يساعد على بدء الموعد في الوقت المحدد ويمنع التأخير."))
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell",
                                                   for: indexPath) as! FAQTableViewCell
        
        let model = array[indexPath.row]
        cell.configure(with: model)   // 👈 هنستخدم فانكشن الكونفيج
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // نغيّر حالة السؤال
        array[indexPath.row].isExpanded.toggle()
        
        // نحدّث الصف فقط
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }

}
struct FAQModel {
    var question: String
    var answer: String
    var isExpanded: Bool = false   // 👈 مغلق افتراضياً
}
