
import UIKit


class BookingForDoctorViewController: UIViewController {
    
    @IBOutlet weak var searchbar: UIView!
    
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var cancelView: UIView!
    
    @IBOutlet weak var complate: UIButton!
    @IBOutlet weak var complateView: UIView!
    
    @IBOutlet weak var upcoming: UIButton!
    @IBOutlet weak var upcomingView: UIView!
    
    @IBOutlet weak var mainView: UIView!
    var screen: String = "upcoming"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchbar.layer.cornerRadius = 12
        searchbar.clipsToBounds = true
        
        setupSearchBar()
        setupMainView()
    }
    
    private func setupSearchBar() {
        let searchVC = SearchWithoutFilterViewController(
            nibName: "SearchWithoutFilterViewController",
            bundle: nil
        )
        addChild(searchVC)
        searchVC.view.frame = searchbar.bounds
        searchVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        searchbar.addSubview(searchVC.view)
        searchVC.didMove(toParent: self)
    }
    
    private func setupMainView() {
        
        // امسح الشاشات القديمة
        mainView.subviews.forEach { $0.removeFromSuperview() }
        children.forEach { $0.removeFromParent() }
        
        var vc: UIViewController
        
        switch screen {
            
            
        case "complate":
            vc = ComplateDatesTableViewController(
                nibName: "ComplateDatesTableViewController",
                bundle: nil
            )
            
        case "cancel":
            vc = CancelDatesTableViewController(
                nibName: "CancelDatesTableViewController",
                bundle: nil
            )
            
        default:
            vc = DoctorUpcomingDatesTableViewController(
                nibName: "DoctorUpcomingDatesTableViewController",
                bundle: nil
            )
        }
        
        // ضيف الشاشة
        addChild(vc)
        vc.view.frame = mainView.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }

    @IBAction func cancelButton(_ sender: Any) {
        screen = "cancel"
        cancel.setTitleColor(.systemBlue, for: .normal)
        complate.setTitleColor(UIColor(hex: "8E8E8E"), for: .normal)
        upcoming.setTitleColor(UIColor(hex: "8E8E8E"), for: .normal)


        cancelView.backgroundColor = .systemBlue
        complateView.backgroundColor = UIColor(hex: "8E8E8E")
        upcomingView.backgroundColor = UIColor(hex: "8E8E8E")
        
        setupMainView()

        
    }
    
    @IBAction func complateButton(_ sender: Any) {
        screen = "complate"

        complate.setTitleColor(.systemBlue, for: .normal)
        cancel.setTitleColor(UIColor(hex: "8E8E8E"), for: .normal)
        upcoming.setTitleColor(UIColor(hex: "8E8E8E"), for: .normal)
        
        
        complateView.backgroundColor = .systemBlue
        cancelView.backgroundColor = UIColor(hex: "8E8E8E")
        upcomingView.backgroundColor = UIColor(hex: "8E8E8E")

        
        

        setupMainView()

        
    }
    
    @IBAction func upcomingButton(_ sender: Any) {
        screen = "upcoming"

        
        upcoming.setTitleColor(.systemBlue, for: .normal)
        cancel.setTitleColor(UIColor(hex: "8E8E8E"), for: .normal)
        complate.setTitleColor(UIColor(hex: "8E8E8E"), for: .normal)
        
        upcomingView.backgroundColor = .systemBlue
        cancelView.backgroundColor = UIColor(hex: "8E8E8E")
        complateView.backgroundColor = UIColor(hex: "8E8E8E")
        

        
        
        
        setupMainView()

    }
    
    
    
    
    
    
    
}
