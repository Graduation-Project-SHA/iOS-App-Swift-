//
//  ProfileViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/30/25.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var edit: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    
    
    @IBOutlet weak var segmentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "حسابى"
        navigationItem.titleView?.tintColor = .white
        view.backgroundColor = UIColor.systemBlue
        
        contentView.layer.cornerRadius = 30
//        contentView.layer.masksToBounds = true
        segmentView.layer.cornerRadius = 10
        segmentView.layer.masksToBounds = true
        
        
        doctorImage.layer.cornerRadius = doctorImage.bounds.width / 2
        doctorImage.clipsToBounds = true
        doctorImage.layer.borderWidth = 1
        doctorImage.layer.borderColor = UIColor(hex: "FFFFFF").cgColor

        
        
        edit.layer.cornerRadius = edit.bounds.width / 2
        edit.clipsToBounds = true
        edit.layer.borderWidth = 1
        edit.layer.borderColor = UIColor(hex: "FFFFFF").cgColor
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        appearance.shadowColor = .clear        // أهم واحدة
        appearance.shadowImage = UIImage()     // بعض الأنظمة تحتاجها

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        navigationItem.title = "حسابى"
    }
    @IBAction func settingButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Setting") as! SettingViewController
        vc.isFromTabBar = false
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func editButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Image Picker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage {
            doctorImage.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            doctorImage.image = originalImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
