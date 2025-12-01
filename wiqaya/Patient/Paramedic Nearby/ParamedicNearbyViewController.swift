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
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var hospitalView: UIView!
    
    @IBOutlet weak var hospitalBottomConstraint: NSLayoutConstraint!
    
    private var didSetupPopup = false
    private var isPopupVisible = false
    var array = [ItemHospital]()
    
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
    
    var locationManager = CLLocationManager()
    var lastLocation : CLLocation?
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        myMap.delegate = self
        implementData()
        
        hospitalView.layer.cornerRadius = 20
        hospitalView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // زوايا فوق بس
        hospitalView.layer.masksToBounds = true
        
        // shadow بسيط فوق الماب
        hospitalView.layer.shadowColor = UIColor.black.cgColor
        hospitalView.layer.shadowOpacity = 0.1
        hospitalView.layer.shadowRadius = 10
        hospitalView.layer.shadowOffset = CGSize(width: 0, height: -4)
        
        // searchbar
        searchbar.layer.cornerRadius = 12
        searchbar.layer.masksToBounds = true
        searchbar.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        setStartingLocation()
        addHospitalsAnnotations()   // ⬅️ إضافة الـ annotations
        setupSearchBar()
        setupSheetPanGesture()
        addGrabberToSheet()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        
        if islocationservicesavailable(){
            CheckAuthorization()
        }else{
            showMsg("Please Enable  Location Services")
        }
        
    }
    
    func implementData() {
        array.append(ItemHospital(name: "مستشفى نور الشروق 1", address: "طريق الشباب", lblAddressCar: "20 دقيقة ", lblAddress: "20 دقيقة", lblDistance: "1.2 كم"))
        array.append(ItemHospital(name: "مستشفى نور الشروق 2", address: "طريق الشباب", lblAddressCar: "25 دقيقة ", lblAddress: "25 دقيقة", lblDistance: "2.3 كم"))
        array.append(ItemHospital(name: "مستشفى نور الشروق 3", address: "طريق الشباب", lblAddressCar: "15 دقيقة ", lblAddress: "15 دقيقة", lblDistance: "0.8 كم"))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        applyAlphaGradientToHeader()
        
        // إعداد أوضاع الـ sheet مرة واحدة بس بعد ما كل الـ constraints تظبط
        if !didSetupPopup {
            didSetupPopup = true
            
            sheetExpandedConstant = 0 // الشيت ملزوق في تحت الشاشة
            
            // نخليه يختفي لتحت (ننزله قد ارتفاعه تقريبًا)
            sheetHiddenConstant = hospitalView.frame.height
            
            // medium: قيمة بين 0 و hidden
            sheetMediumConstant = sheetHiddenConstant * 0.4   // مثلاً 40% من طريق الإختفاء
            
            // نبدأ في وضع medium
            currentSheetState = .medium
            hospitalBottomConstraint.constant = sheetMediumConstant
            view.layoutIfNeeded()
        }
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
//        myMap.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 2800000)
        myMap.setCameraZoomRange(zoomRange, animated: true)
    }
    
    // MARK: - إضافة الـ Annotations الخاصة بالمستشفيات على الخريطة
    func addHospitalsAnnotations() {
        
        // إحداثيات كل مستشفى بنفس ترتيب array
        let hospitalCoordinates: [CLLocationCoordinate2D] = [
            CLLocationCoordinate2D(latitude: 29.9553802, longitude: 31.0946302),
            CLLocationCoordinate2D(latitude: 29.955800, longitude: 31.093500),
            CLLocationCoordinate2D(latitude: 29.956400, longitude: 31.094200)
        ]
        
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
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "HomeTabBar") as? HomeTabBarViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }
        
    }
    
}

// MARK: - Bottom Sheet: pan gesture

extension ParamedicNearbyViewController {
    private func setupSheetPanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handleSheetPan(_:)))
        hospitalView.addGestureRecognizer(pan)
    }
    
    private func addGrabberToSheet() {
        let grabber = UIView()
        grabber.translatesAutoresizingMaskIntoConstraints = false
        grabber.backgroundColor = UIColor.systemGray3
        grabber.layer.cornerRadius = 2
        
        hospitalView.addSubview(grabber)
        
        NSLayoutConstraint.activate([
            grabber.topAnchor.constraint(equalTo: hospitalView.topAnchor, constant: 8),
            grabber.centerXAnchor.constraint(equalTo: hospitalView.centerXAnchor),
            grabber.widthAnchor.constraint(equalToConstant: 40),
            grabber.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    private func moveSheet(to state: SheetState, animated: Bool = true) {
        currentSheetState = state
        
        switch state {
        case .expanded:
            hospitalBottomConstraint.constant = sheetExpandedConstant
        case .medium:
            hospitalBottomConstraint.constant = sheetMediumConstant
        case .hidden:
            hospitalBottomConstraint.constant = sheetHiddenConstant
        }
        
        let animations = {
            self.view.layoutIfNeeded()
        }
        
        if animated {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.9,
                           initialSpringVelocity: 0.8,
                           options: [.curveEaseInOut],
                           animations: animations,
                           completion: nil)
        } else {
            animations()
        }
    }
    
    @objc private func handleSheetPan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view).y
        
        switch gesture.state {
        case .began:
            panStartConstant = hospitalBottomConstraint.constant
            
        case .changed:
            let newConstant = panStartConstant - translation.y
            hospitalBottomConstraint.constant = min(
                max(newConstant, sheetExpandedConstant),
                sheetHiddenConstant
            )
            view.layoutIfNeeded()
            
        case .ended, .cancelled:
            let position = hospitalBottomConstraint.constant
            
            var targetState: SheetState
            
            // لو السحب سريع لتحت → اخفي
            if velocity > 1000 {
                targetState = .hidden
            }
            // لو السحب سريع لفوق → expanded
            else if velocity < -1000 {
                targetState = .expanded
            }
            else {
                // اختار أقرب detent
                let toExpanded = abs(position - sheetExpandedConstant)
                let toMedium   = abs(position - sheetMediumConstant)
                let toHidden   = abs(position - sheetHiddenConstant)
                
                let minDistance = min(toExpanded, toMedium, toHidden)
                
                if minDistance == toExpanded {
                    targetState = .expanded
                } else if minDistance == toMedium {
                    targetState = .medium
                } else {
                    targetState = .hidden
                }
            }
            
            moveSheet(to: targetState)
            
        default:
            break
        }
    }
}

// MARK: - TableView

extension ParamedicNearbyViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ParamedicTableViewCell
        cell.hospitalName.text = array[indexPath.row].name
        cell.hospitalAddress.text = array[indexPath.row].address
        cell.lblAddressCar.text = array[indexPath.row].lblAddressCar
        cell.lblAddress.text = array[indexPath.row].lblAddress
        cell.lblDistance.text = array[indexPath.row].lblDistance
        
        cell.onButtonTap = { [weak self] in
            guard let self = self else { return }
            
            let storyboard = UIStoryboard(name: "Patient", bundle: nil)
            if let loginVC = storyboard.instantiateViewController(withIdentifier: "HospitalDetails") as? HospitalDetailsViewController {
                loginVC.modalPresentationStyle = .fullScreen
                loginVC.modalTransitionStyle = .crossDissolve
                self.present(loginVC, animated: false)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    // لما يختار مستشفى من الجدول
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "HospitalDetails") as? HospitalDetailsViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            self.present(loginVC, animated: false)
        }
    }
}

// MARK: - Location + Map

extension ParamedicNearbyViewController : CLLocationManagerDelegate, MKMapViewDelegate {
    
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
    func zoomToUserLocatio(location : CLLocation) {
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
        
        // اختار الـ row في الجدول
        myTableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        
        // افتح الـ bottom sheet على expanded
        moveSheet(to: .medium)
//        currentSheetState = .medium
        // لو عايز تفتح التفاصيل كمان:
        // tableView(myTableView, didSelectRowAt: indexPath)
    }
}

struct ItemHospital {
    var name : String
    var address : String
    var lblAddressCar : String
    var lblAddress : String
    var lblDistance : String
}
