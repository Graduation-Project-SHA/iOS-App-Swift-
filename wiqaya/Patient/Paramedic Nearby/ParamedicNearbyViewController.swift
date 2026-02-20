import UIKit
import MapKit
import CoreLocation

// MARK: - Custom Annotation للمستشفيات
class HospitalAnnotation: MKPointAnnotation {
    var imageName: String?
    var tableIndex: Int?   // عشان نعرف ده مربوط بأي row في الجدول
}

class ParamedicNearbyViewController: UIViewController {
    @IBOutlet weak var GradientView: UIView!
    @IBOutlet weak var searchbar: UIView!
    @IBOutlet weak var myMap: MKMapView!
    
    @IBOutlet weak var hospitalButt: UIButton!
    @IBOutlet weak var doctorButt: UIButton!
    
    private var didSetupPopup = false
    private var isPopupVisible = false
    
    // حالات الـ sheet
    private enum SheetState {
        case hidden
        case medium
        case expanded
    }
    
    private var currentSheetState: SheetState = .medium
    
    // قيم الـ detents (هتتظبط بعد الـ layout)
    private var sheetHiddenConstant: CGFloat = 0
    private var sheetMediumConstant: CGFloat = 0
    private var sheetExpandedConstant: CGFloat = 0
    
    // عشان نخزن قيمة الكونسـترينت أثناء السحب
    private var panStartConstant: CGFloat = 0
    private var didShowSheet = false
    
    var identifierMap : String = ""
    var locationManager = CLLocationManager()
    var lastLocation: CLLocation?
    let annotation = MKPointAnnotation()
    var ishospital : Bool = true
    var sheet : UIViewController!
    // ✅ FIX: كان عندك let array = HospitalMapViewController() وده غلط
    // لازم array يبقى نفس داتا المستشفيات
    var array: [ItemHospital] = [
        ItemHospital(name: "مستشفى نور الشروق 1", address: "طريق الشباب", lblAddressCar: "20 دقيقة ", lblAddress: "20 دقيقة", lblDistance: "1.2 كم"),
        ItemHospital(name: "مستشفى نور الشروق 2", address: "طريق الشباب", lblAddressCar: "25 دقيقة ", lblAddress: "25 دقيقة", lblDistance: "2.3 كم"),
        ItemHospital(name: "مستشفى نور الشروق 3", address: "طريق الشباب", lblAddressCar: "15 دقيقة ", lblAddress: "15 دقيقة", lblDistance: "0.8 كم")
    ]
    
    // ✅ إحداثيات كل مستشفى بنفس ترتيب array
    private let hospitalCoordinates: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 29.9553802, longitude: 31.0946302),
        CLLocationCoordinate2D(latitude: 29.955800, longitude: 31.093500),
        CLLocationCoordinate2D(latitude: 29.956400, longitude: 31.094200)
    ]
    
    // ✅ Added: نمسك Reference للـ sheet VC عشان نتحكم في الجدول/الـ detent
    private weak var hospitalSheetVC: HospitalMapViewController?
    private weak var doctorSheetVC: DoctorMapViewController?
    // ✅ Added: نفس اسم myTableView اللي كنت بتستعمله في didSelect بتاع الخريطة
    // بس بدل ما يكون Table عندك هنا، بيشير لجدول الشيت
    private var myTableView: UITableView? {
        return ishospital ? hospitalSheetVC?.myTableView : doctorSheetVC?.myTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ✅ مهم: Delegate للـ Map عشان viewForAnnotation و didSelect يشتغلوا
        myMap.delegate = self
        
        // searchbar
        searchbar.layer.cornerRadius = 12
        searchbar.layer.masksToBounds = true
        searchbar.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        setStartingLocation()
        addHospitalsAnnotations()   // ⬅️ إضافة الـ annotations
        setupSearchBar()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        
        if islocationservicesavailable() {
            CheckAuthorization()
        } else {
            showMsg("Please Enable  Location Services")
        }
    }
    
    // ✅ Added: نخلي الشيت يظهر أول ما الصفحة تفتح (مرة واحدة بس)
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateModeButtonsUI()

        if !didShowSheet {
            didShowSheet = true
            showHospitalSheet()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyAlphaGradientToHeader()
    }
    
    private func setupSearchBar() {
        let searchVC = SearchWithoutFilterViewController(nibName: "SearchWithoutFilterViewController", bundle: nil)
        addChild(searchVC)
        searchVC.view.frame = searchbar.bounds
        searchVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        searchbar.addSubview(searchVC.view)
        searchVC.didMove(toParent: self)
    }
    
    private func applyAlphaGradientToHeader() {
        GradientView.layer.sublayers?
            .filter { $0.name == "alphaGradient" }
            .forEach { $0.removeFromSuperlayer() }
        
        let gradient = CAGradientLayer()
        gradient.name = "alphaGradient"
        gradient.frame = GradientView.bounds
        
        gradient.colors = [
            UIColor.white.withAlphaComponent(1.0).cgColor,
            UIColor.white.withAlphaComponent(0.8).cgColor,
            UIColor.white.withAlphaComponent(0.0).cgColor
        ]
        
        gradient.locations = [0.0, 0.7, 1.0] as [NSNumber]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint   = CGPoint(x: 0.5, y: 1.0)
        
        GradientView.backgroundColor = .clear
        GradientView.layer.insertSublayer(gradient, at: 0)
    }
    
    func setStartingLocation() {
        let location = CLLocationCoordinate2D(latitude: 29.9560079, longitude: 31.0938121)
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: location, span: span)
        myMap.setRegion(region, animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 2800000)
        myMap.setCameraZoomRange(zoomRange, animated: true)
    }
    
    // MARK: - إضافة الـ Annotations الخاصة بالمستشفيات على الخريطة
    func addHospitalsAnnotations() {
        
        let count = min(array.count, hospitalCoordinates.count)
        
        for index in 0..<count {
            let item = array[index]
            let coord = hospitalCoordinates[index]
            
            let annotation = HospitalAnnotation()
            
            // 👈 هنا الاسم = title
            annotation.title = item.name
            
            // 👈 العنوان = subtitle
            annotation.subtitle = item.address
            
            annotation.coordinate = coord
            annotation.imageName = "hospital"
            annotation.tableIndex = index
            
            myMap.addAnnotation(annotation)
        }
    }
    
    @IBAction func backbutton(_ sender: Any) {
        dismiss(animated: true)

    }
    
    @IBAction func hospitalButton(_ sender: Any) {
        ishospital = true
        updateModeButtonsUI()

        showCurrentSheet()
    }
    
    @IBAction func doctorButton(_ sender: Any) {
        ishospital = false
        updateModeButtonsUI()

        showCurrentSheet()

    }
    private func updateModeButtonsUI() {
        if ishospital {
            hospitalButt.tintColor = .systemBlue
            hospitalButt.setTitleColor(.white, for: .normal)
            
            doctorButt.tintColor = .white
            doctorButt.setTitleColor(.systemGray, for: .normal)
        } else {
            doctorButt.tintColor = .systemBlue
            doctorButt.setTitleColor(.white, for: .normal)
            
            hospitalButt.tintColor = .white
            hospitalButt.setTitleColor(.systemGray, for: .normal)
        }
    }

    // ✅ Added: زوم على المستشفى لما تختاره من الجدول
    private func focusOnHospital(index: Int) {
        guard index >= 0, index < hospitalCoordinates.count else { return }
        let coord = hospitalCoordinates[index]
        let region = MKCoordinateRegion(center: coord, latitudinalMeters: 300, longitudinalMeters: 300)
        myMap.setRegion(region, animated: true)
        
        // اختياري: select للـ annotation
        if let ann = myMap.annotations.compactMap({ $0 as? HospitalAnnotation }).first(where: { $0.tableIndex == index }) {
            myMap.selectAnnotation(ann, animated: true)
        }
    }
}

// MARK: - Bottom Sheet

extension ParamedicNearbyViewController {
    private func showCurrentSheet(selectIndex: Int? = nil) {
        if ishospital {
            showHospitalSheet(selectIndex: selectIndex)
        } else {
            showDoctorSheet(selectIndex: selectIndex)
        }
    }

    // ✅ Added: تغيير وضع الشيت (min / mid / up)
    private func moveSheet(to state: SheetState) {
        let currentVC: UIViewController? = ishospital ? hospitalSheetVC : doctorSheetVC
        guard let sheetVC = currentVC,
              let sheet = sheetVC.sheetPresentationController else { return }

        currentSheetState = state
        
        if #available(iOS 16.0, *) {
            let targetId: UISheetPresentationController.Detent.Identifier
            switch state {
            case .hidden:   targetId = UISheetPresentationController.Detent.Identifier("min")
            case .medium:   targetId = UISheetPresentationController.Detent.Identifier("mid")
            case .expanded: targetId = UISheetPresentationController.Detent.Identifier("up")
            }
            
            sheet.animateChanges {
                sheet.selectedDetentIdentifier = targetId
            }
            
        } else {
            // iOS 15 fallback
            let targetId: UISheetPresentationController.Detent.Identifier
            switch state {
            case .hidden, .medium: targetId = .medium
            case .expanded:        targetId = .large
            }
            sheet.selectedDetentIdentifier = targetId
        }
    }
    
    private func showHospitalSheet(selectIndex: Int? = nil) {
        // لو في presented VC مش الشيت، ما نبوظش الدنيا
        // ✅ لو المفتوح doctor وإنت عايز hospital -> اقفله وافتح hospital
        if let presented = presentedViewController, presented is DoctorMapViewController {
            presented.dismiss(animated: false) { [weak self] in
                self?.showHospitalSheet(selectIndex: selectIndex)
            }
            return
        }

        // لو الشيت مفتوح بالفعل
        if let sheetVC = hospitalSheetVC, presentedViewController === sheetVC {
            if let idx = selectIndex {
                sheetVC.selectHospitalRow(index: idx)
            }
            moveSheet(to: .medium)
            return
        }
        
        let sb = UIStoryboard(name: "Patient", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "HospitalMap") as? HospitalMapViewController else {
            print("❌ testSheet ID/class مشكلة")
            return
        }
        
        // ✅ خلي نفس الداتا في الشيت (متزامنة مع الخريطة)
        vc.array = self.array
        
        // ✅ نخزن reference
        self.hospitalSheetVC = vc
        
        // ✅ Prevent swipe-to-dismiss (ما تتقفلش بالسحب)
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .pageSheet
        
        // ✅ Callback: لما تختار مستشفى من الجدول -> زوم على الخريطة
        vc.onHospitalSelected = { [weak self] index, _ in
            self?.focusOnHospital(index: index)
        }
        
        if let sheet = vc.sheetPresentationController {
            
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            
            if #available(iOS 16.0, *) {
                
                let minId = UISheetPresentationController.Detent.Identifier("min")
                let midId = UISheetPresentationController.Detent.Identifier("mid")
                let upId  = UISheetPresentationController.Detent.Identifier("up")
                
                let minDetent = UISheetPresentationController.Detent.custom(identifier: minId) { context in
                    context.maximumDetentValue * 0.20   // 20% (صغير تحت)
                }
                
                let midDetent = UISheetPresentationController.Detent.custom(identifier: midId) { context in
                    context.maximumDetentValue * 0.50   // 50% (نص)
                }
                
                let upDetent = UISheetPresentationController.Detent.custom(identifier: upId) { context in
                    context.maximumDetentValue * 1.0    // 100% (فوق)
                }
                
                sheet.detents = [minDetent, midDetent, upDetent]
                sheet.selectedDetentIdentifier = midId
                sheet.largestUndimmedDetentIdentifier = upId
                
            } else {
                sheet.detents = [.medium(), .large()]
                sheet.selectedDetentIdentifier = .medium
                sheet.largestUndimmedDetentIdentifier = .large
            }
        }
        
        present(vc, animated: true) { [weak self] in
            // لو جايين من annotation وعايزين نحدد row بعد ما الشيت يظهر
            if let idx = selectIndex {
                vc.selectHospitalRow(index: idx)
                self?.moveSheet(to: .medium)
            }
        }
    }
    private func showDoctorSheet(selectIndex: Int? = nil) {
        
        // لو في presented VC مش DoctorSheet، ما نبوظش الدنيا
        if let presented = presentedViewController,
           !(presented is DoctorMapViewController) {
            // لو المفتوح hospital وعايز doctor (أو العكس) اقفله وافتح الجديد
            if presented is HospitalMapViewController {
                presented.dismiss(animated: false) { [weak self] in
                    self?.showDoctorSheet(selectIndex: selectIndex)
                }
            }
            return
        }
        
        // لو الشيت مفتوح بالفعل
        if let sheetVC = doctorSheetVC, presentedViewController === sheetVC {
            if let idx = selectIndex {
                sheetVC.selectDoctorRow(index: idx) // اختياري لو عندك
            }
            moveSheet(to: .medium)
            return
        }
        
        let sb = UIStoryboard(name: "Patient", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "DoctorMap") as? DoctorMapViewController else {
            print("❌ DoctorMap ID/class مشكلة")
            return
        }
        
        self.doctorSheetVC = vc
        
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = vc.sheetPresentationController {
            
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            
            if #available(iOS 16.0, *) {
                
                let minId = UISheetPresentationController.Detent.Identifier("min")
                let midId = UISheetPresentationController.Detent.Identifier("mid")
                let upId  = UISheetPresentationController.Detent.Identifier("up")
                
                let minDetent = UISheetPresentationController.Detent.custom(identifier: minId) { context in
                    context.maximumDetentValue * 0.20
                }
                
                let midDetent = UISheetPresentationController.Detent.custom(identifier: midId) { context in
                    context.maximumDetentValue * 0.50
                }
                
                let upDetent = UISheetPresentationController.Detent.custom(identifier: upId) { context in
                    context.maximumDetentValue * 1.0
                }
                
                sheet.detents = [minDetent, midDetent, upDetent]
                sheet.selectedDetentIdentifier = midId
                sheet.largestUndimmedDetentIdentifier = upId
                
            } else {
                sheet.detents = [.medium(), .large()]
                sheet.selectedDetentIdentifier = .medium
                sheet.largestUndimmedDetentIdentifier = .large
            }
        }
        
        present(vc, animated: true) { [weak self] in
            // لو عايز تعمل selectIndex هنا للدكتور بعد ما يفتح
            if selectIndex != nil {
                self?.moveSheet(to: .medium)
            }
        }
    }

}

// MARK: - Location + Map

extension ParamedicNearbyViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func islocationservicesavailable() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    func CheckAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            myMap.showsUserLocation = true
            break
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            myMap.showsUserLocation = true
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            myMap.showsUserLocation = true
            break
        case .denied:
            showMsg("please authorize Access to Location")
            break
        case .restricted:
            showMsg("GPS access is restricted. In order to use tracking, please enable GPS in the Settings app under Privacy, Location Services.")
            break
        @unknown default:
            print("default..")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.last!
        if let location = lastLocation {
            print("latitude \(location.coordinate.latitude) longitude \(location.coordinate.longitude)")
            zoomToUserLocatio(location: location)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            myMap.showsUserLocation = true
            break
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            myMap.showsUserLocation = true
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            myMap.showsUserLocation = true
            break
        case .denied:
            showMsg("please authorize Access to Location")
            break
        default:
            print("default..")
        }
    }
    
    func showMsg(_ msg: String) {
        let alert = UIAlertController(title: "Permission Needed",
                                      message: msg,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Go to Settings now", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // عشان يعمل زوم لمكان المستخدم
    func zoomToUserLocatio(location: CLLocation) {
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
        myMap.setRegion(region, animated: true)
    }
    
    // شكل الـ annotation (أيقونة المستشفى)
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // سيب مكان المستخدم زي ما هو
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "HospitalAnnotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKAnnotationView
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        if let hospitalAnnotation = annotation as? HospitalAnnotation,
           let imageName = hospitalAnnotation.imageName {
            annotationView?.image = UIImage(named: imageName)
        }
        
        annotationView?.frame.size = CGSize(width: 40, height: 40)
        
        return annotationView
    }
    
    // لما تدوس على الـ annotation في الخريطة
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let hospitalAnnotation = view.annotation as? HospitalAnnotation,
              let index = hospitalAnnotation.tableIndex else { return }
        
        let indexPath = IndexPath(row: index, section: 0)
        
        // ✅ بدل ما كان myTableView غير موجود هنا:
        // نضمن الشيت مفتوح وبعدين نحدد الـ row جوّه جدول الشيت
        showCurrentSheet(selectIndex: index)
        
        // اختار الـ row في الجدول (بتاع الشيت)
        myTableView?.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        
        // افتح الـ bottom sheet على medium
        moveSheet(to: .medium)
    }
}
