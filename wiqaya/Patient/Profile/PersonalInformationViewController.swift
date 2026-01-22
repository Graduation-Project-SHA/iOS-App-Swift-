import UIKit
class PersonalInformationViewController: UIViewController,
                                         UIImagePickerControllerDelegate,
                                         UINavigationControllerDelegate,
                                         UIGestureRecognizerDelegate {
    
    @IBOutlet weak var patientImage: UIImageView!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "حسابى"
        navigationItem.titleView?.tintColor = .white
        
        patientImage.layer.cornerRadius = patientImage.bounds.width / 2
        patientImage.clipsToBounds = true
        edit.layer.cornerRadius = edit.bounds.width / 2
        edit.clipsToBounds = true
        edit.layer.borderWidth = 1
        edit.layer.borderColor = UIColor(hex: "FFFFFF").cgColor
        
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
        
        navigationItem.title = "معلومات شخصية"
        self.tabBarController?.tabBar.isHidden = true
        
        // حمّل الصورة من الـ Singleton لو موجودة
        if let img = UserData1.shared.profileImage {
            patientImage.image = img
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func editButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        print("✅ saveButton tapped")

        UserData1.shared.profileImage = patientImage.image
        
        // جرّب تطبع علشان تتأكد إن الزرار بيشتغل
        
        // حاول ترجع بالـ navigationController لو موجود
        if let nav = navigationController {
            print("✅ Has nav, popping")
            nav.popViewController(animated: true)
        } else {
            print("⚠️ No nav, dismissing")
            // في حالة كانت الشاشة معمولة لها present
            dismiss(animated: true, completion: nil)
        }
    }
    
    // Image Picker
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage {
            patientImage.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            patientImage.image = originalImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
