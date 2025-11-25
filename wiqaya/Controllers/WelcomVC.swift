//
//  WelcomVC.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/18/25.
//

import UIKit

class WelcomVC: UIViewController {
//    var userName : String = ""
//    var login = LogIngVC()
    @IBOutlet weak var myCollection: UICollectionView!
    
    
    @IBOutlet weak var next1: UIButton!
    
    
    @IBOutlet weak var skip: UIButton!
    
    var array = [WelcomeItem] ()


    override func viewDidLoad() {
        super.viewDidLoad()
//        labelView
        
                     
        initData()
        initCollectionView()
    }
    
    
    func initData() {
        array.append(WelcomeItem(image: UIImage(named: "image1")!, title1: "أحجز معادك مع الدكتور المناسب", title2: "مجموعة من الخبراء في جميع المجالات موجودين في مكان واحد "))
        array.append(WelcomeItem(image: UIImage(named: "Doctor")!, title1: "أحجز معادك مع الدكتور المناسب", title2: "مجموعة من الخبراء في جميع المجالات موجودين في مكان واحد "))
    }
    
    @IBAction func nextButton(_ sender: Any) {
        // نحصل على indexPath الحالي للـ visible cell
        let visibleIndexPaths = myCollection.indexPathsForVisibleItems
        guard let currentIndexPath = visibleIndexPaths.first else { return }
        
        let nextItem = currentIndexPath.item + 1
        
        if nextItem < array.count {
            // التحرك للـ cell التالية
            let nextIndexPath = IndexPath(item: nextItem, section: 0)
            myCollection.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        } else {
            // لو وصلنا للـ آخر cell ننفذ الانتقال للـ Login
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if let loginVC = storyboard.instantiateViewController(withIdentifier: "Login") as? LogIngVC {
                loginVC.modalPresentationStyle = .fullScreen
                loginVC.modalTransitionStyle = .crossDissolve
                present(loginVC, animated: true)

                // الحل الأساسي هنا 👇
//                DispatchQueue.main.async {
//                    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                       let window = scene.windows.first {
//                        window.rootViewController = loginVC
//                        window.makeKeyAndVisible()
//                    }
//                }
            }
        }

    }
    
    @IBAction func skipButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "CallConfirm") as? CallConfirmViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: true)
            // الحل الأساسي هنا 👇
//            DispatchQueue.main.async {
//                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                   let window = scene.windows.first {
//                    window.rootViewController = loginVC
//                    window.makeKeyAndVisible()
//                }
//            }
        }

    }
    
    
    
    
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)
    //        checkIfUserAlreadyLoggedIn()
    //
    //    }
    //    private func checkIfUserAlreadyLoggedIn() {
    //        let defaults = UserDefaults.standard
    //
    //        if let accessToken = defaults.string(forKey: "accessToken"),
    //           !accessToken.isEmpty,
    //           let refreshToken = defaults.string(forKey: "refreshToken"),
    //           let name = defaults.string(forKey: "name"),
    //           let email = defaults.string(forKey: "userEmail") {
    //
    //            self.userName = name
    //            if isTokenValid(accessToken) {
    //                print("🔐 User already logged in with valid token.")
    //
    //                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
    //                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //                    if let homeVC = storyboard.instantiateViewController(withIdentifier: "Success") as? SuccessVC {
    //                        homeVC.titlelbl = "مرحباً \(self.userName)"
    //                        homeVC.suptitlelbl = "لقد قمت بتسجيل الدخول مسبقاً"
    //                        homeVC.msglbl = ""
    //                        homeVC.loadViewIfNeeded() // ضروري قبل التعديل على الـ outlets
    //                        homeVC.done.isHidden = true
    //                        homeVC.modalPresentationStyle = .fullScreen
    //                        homeVC.modalTransitionStyle = .crossDissolve
    //                        self.present(homeVC, animated: true)
    //                    }
    //                }
    //            } else {
    //                print("⚠️ Token expired — please log in again.")
    //                defaults.removeObject(forKey: "accessToken")
    //                defaults.removeObject(forKey: "refreshToken")
    //
    //                let alert = UIAlertController(
    //                    title: "انتهت الجلسة",
    //                    message: "يرجى تسجيل الدخول مرة أخرى.",
    //                    preferredStyle: .alert
    //                )
    //                alert.addAction(UIAlertAction(title: "حسناً", style: .default))
    //                self.present(alert, animated: true)
    //            }
    //
    //        } else {
    //            print("🚫 No saved session found, stay on login screen")
    //        }
    //    }
    //
    //
    //
    //
    //
    //
    //    func isTokenValid(_ token: String) -> Bool {
    //        // التوكن بيكون 3 أجزاء مفصولة بـ "."
    //        let segments = token.split(separator: ".")
    //        guard segments.count == 3 else { return false }
    //
    //        // الجزء الأوسط هو الـ payload
    //        let payloadSegment = segments[1]
    //
    //        // نحول الـ Base64 إلى Data
    //        var base64 = String(payloadSegment)
    //            .replacingOccurrences(of: "-", with: "+")
    //            .replacingOccurrences(of: "_", with: "/")
    //
    //        // تكملة padding لو ناقص
    //        while base64.count % 4 != 0 {
    //            base64.append("=")
    //        }
    //
    //        guard let payloadData = Data(base64Encoded: base64),
    //              let json = try? JSONSerialization.jsonObject(with: payloadData) as? [String: Any],
    //              let exp = json["exp"] as? TimeInterval else {
    //            return false
    //        }
    //
    //        // نحسب الوقت الحالي
    //        let expirationDate = Date(timeIntervalSince1970: exp)
    //        return Date() < expirationDate
    //    }
    //
    

}
