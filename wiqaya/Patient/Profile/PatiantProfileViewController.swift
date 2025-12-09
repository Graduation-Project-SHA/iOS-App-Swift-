//
//  PatiantProfileViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/8/25.
//

import UIKit

class PatiantProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var PatiantImage: UIImageView!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Has nav? 👉", navigationController != nil)

        navigationItem.title = "حسابى"
        navigationItem.titleView?.tintColor = .white
        view.backgroundColor = UIColor.systemBlue
        
        contentView.layer.cornerRadius = 30
        
        PatiantImage.layer.cornerRadius = PatiantImage.bounds.width / 2
        PatiantImage.clipsToBounds = true
        PatiantImage.layer.borderWidth = 1
        PatiantImage.layer.borderColor = UIColor(hex: "FFFFFF").cgColor

        
        
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
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        navigationItem.title = "حسابى"
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
            PatiantImage.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            PatiantImage.image = originalImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
