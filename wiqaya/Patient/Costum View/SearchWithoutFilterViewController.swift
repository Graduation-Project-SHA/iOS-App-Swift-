import UIKit

protocol SearchWithoutFilterDelegate: AnyObject {
    func searchTextDidChange(_ text: String)
}

class SearchWithoutFilterViewController: UIViewController {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    
    weak var delegate: SearchWithoutFilterDelegate?   // 👈 مهم جدًا
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // كل ما المستخدم يكتب حاجة... ابعت للـ delegate
        txtSearch.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    @objc func textFieldChanged() {
        delegate?.searchTextDidChange(txtSearch.text ?? "")
    }
    
    @IBAction func searchButton(_ sender: Any) {
        // لو عندك زرار بحث تعمل نفس الوظيفة
        delegate?.searchTextDidChange(txtSearch.text ?? "")
    }
}
