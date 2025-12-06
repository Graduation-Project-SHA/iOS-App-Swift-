//
//  secondPageInThirdStageViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/2/25.
//

import UIKit
import AVKit



class secondPageInThirdStageViewController: UIViewController {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var flag: UILabel!
    @IBOutlet weak var camera: UIImageView!
    @IBOutlet weak var cameraLiveView: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var reeTake: UIButton!
    
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var photoOutput: AVCapturePhotoOutput?
    var cameraDevice: AVCaptureDevice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flag.isHidden = true
        
        
        cameraView.isHidden = false
        reeTake.backgroundColor = .white
        
        camera.layer.cornerRadius = 15
        camera.clipsToBounds = true

        
        cameraLiveView.layer.cornerRadius = 15
        cameraLiveView.clipsToBounds = true
        cameraLiveView.layer.borderWidth = 1
        cameraLiveView.layer.borderColor = UIColor(hex: "0D5BE3").cgColor

        
        // Set up camera live view
        setUpCameraLiveView()
    }
    
    func setUpCameraLiveView() {
        captureSession = AVCaptureSession()
        
        // Get the default back camera
        guard let device = AVCaptureDevice.default(for: .video) else {
            print("No camera available")
            return
        }
        cameraDevice = device
        
        do {
            // Create an input object from the camera device
            let deviceInput = try AVCaptureDeviceInput(device: device)
            
            // Add input to capture session
            if captureSession!.canAddInput(deviceInput) {
                captureSession!.addInput(deviceInput)
            }
            
            // Create a photo output object
            photoOutput = AVCapturePhotoOutput()
            
            // Add photo output to capture session
            if captureSession!.canAddOutput(photoOutput!) {
                captureSession!.addOutput(photoOutput!)
            }
            
            // Create a preview layer to display the camera input
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            previewLayer!.frame = cameraLiveView.bounds
            previewLayer!.videoGravity = .resizeAspectFill
            cameraLiveView.layer.addSublayer(previewLayer!)
            
            // Start capturing
            captureSession!.startRunning()
        } catch {
            print("Error setting up camera: \(error)")
        }
    }
    
    @IBAction func cameraShootButton(_ sender: Any) {
        // Animation effect
        let flashView = UIView(frame: self.view.frame)
        flashView.backgroundColor = UIColor.white
        flashView.alpha = 0
        self.view.addSubview(flashView)
        
        UIView.animate(withDuration: 0.1, animations: {
            flashView.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                flashView.alpha = 0
            }) { _ in
                flashView.removeFromSuperview()
            }
        }
        
        // Camera view zoom-in effect
        UIView.animate(withDuration: 0.15,
                       animations: {
            self.cameraLiveView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }) { _ in
            UIView.animate(withDuration: 0.15) {
                self.cameraLiveView.transform = CGAffineTransform.identity
            }
        }
        // Button tap animation
//        UIView.animate(withDuration: 0.1, animations: {
//            self.cameraButton.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
//        }) { _ in
//            UIView.animate(withDuration: 0.15, animations: {
//                self.cameraButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
//            }) { _ in
//                UIView.animate(withDuration: 0.15) {
//                    self.cameraButton.transform = CGAffineTransform.identity
//                }
//            }
//        }
        self.cameraButton.layer.shadowColor = UIColor.white.cgColor
        self.cameraButton.layer.shadowRadius = 10
        self.cameraButton.layer.shadowOpacity = 0.0
        
        UIView.animate(withDuration: 0.2, animations: {
            self.cameraButton.layer.shadowOpacity = 0.8
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.cameraButton.layer.shadowOpacity = 0.0
            }
        }


        
        // Capture photo
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    @IBAction func reTake(_ sender: Any) {
        // Clear the current photo
        camera.image = nil
        
        // Restart the camera session if necessary
        captureSession?.startRunning()
        camera.isHidden = true

    }
    
    func evaluatePhotoQuality(image: UIImage) -> Bool {
        // Here you can add logic to evaluate if the photo is perfect or not
        // For the sake of simplicity, let's assume we return true if image is not nil
        return image != nil
    }
}

extension secondPageInThirdStageViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error)")
            return
        }
        flag.isHidden = false

        // Get image data
        if let imageData = photo.fileDataRepresentation(),
           let image = UIImage(data: imageData) {
            
            // Stop camera preview so image becomes visible
            captureSession?.stopRunning()
            
            // Set image to UIImageView
            camera.image = image
            
            // Show the captured image
            camera.isHidden = false
            
            // Evaluate photo quality
            let isPhotoPerfect = evaluatePhotoQuality(image: image)
            
            if isPhotoPerfect {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.performSegue(withIdentifier: "goToNextPageInThirdStage", sender: self)
                }
            } else {
                print("Photo is not perfect.")
            }
        }
    }
}
