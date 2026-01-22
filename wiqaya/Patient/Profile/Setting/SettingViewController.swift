import UIKit

class SettingViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var isFromTabBar = true   // غيّرها لـ false لما تفتح من الـ Profile
    
    @IBOutlet weak var back: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
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
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        navigationItem.title = "الاعدادات"
        
        if isFromTabBar {
            // جاي من التاب بار → خليه ظاهر، وغالبًا ما تحتاج زر رجوع
            self.tabBarController?.tabBar.isHidden = false
            back.isHidden = true
            back.tintColor = .clear
        } else {
            // جاي من صفحة Profile مثلاً → اخفي التاب بار واظهر زر الرجوع
            self.tabBarController?.tabBar.isHidden = true
            back.isHidden = false
            back.tintColor = .systemBlue
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // دائمًا لما نطلع من الإعدادات نظهر التاب بار
        self.tabBarController?.tabBar.isHidden = false
        
        // ✅ نرجع للهوم فقط لو الشاشة فعلاً بتنشال من الـ navigation stack
        // يعني رجوع Back (زر أو سحب)، مو لما تغير التاب من تحت
        if isFromTabBar && (self.isMovingFromParent || self.isBeingDismissed) {
            tabBarController?.selectedIndex = 0   // 0 = الهوم
        }
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        let alert = UIAlertController(
            title: "تسجيل الخروج",
            message: "ستحتاج إلى إدخال اسم المستخدم الخاص بك وكلمة المرور في المرة القادمة.\nهل تريد تسجيل الخروج؟",
            preferredStyle: .alert
        )
        
        let logoutAction = UIAlertAction(title: "تسجيل خروج", style: .destructive) { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let loginVC = storyboard.instantiateViewController(withIdentifier: "Login") as? LogIngVC {
                loginVC.modalPresentationStyle = .fullScreen
                loginVC.modalTransitionStyle = .crossDissolve
                self.present(loginVC, animated: true)
            }
        }
        
        let cancelAction = UIAlertAction(title: "إلغاء", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(logoutAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        if isFromTabBar {
            // لو حاب زر رجوع في حالة التاب بار يرجعك للهوم
            tabBarController?.selectedIndex = 0
        } else {
            // جاي من صفحة تانية جوّا الناف → رجوع عادي
            navigationController?.popViewController(animated: true)
        }
    }
}
