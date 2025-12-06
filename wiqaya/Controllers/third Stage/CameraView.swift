//
//  CameraView.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/6/25.
//

import UIKit
import AVKit

class CameraView: UIView {
    
    // MARK: - Properties
    private let session = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    private var previewLayer = AVCaptureVideoPreviewLayer()
    
    // Bottom capture button
    private let captureButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Capture", for: .normal)
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 25
        return btn
    }()
    
    // Popup elements
    private let popupView = UIView()
    private let popupImageView = UIImageView()
    private let popupCancelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        btn.layer.cornerRadius = 20
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return btn
    }()
    
    
    // MARK: - Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupCamera()
        setupUI()
    }
    
    
    // MARK: - Camera Setup
    private func setupCamera() {
        session.sessionPreset = .photo
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                   for: .video,
                                                   position: .back),
              let input = try? AVCaptureDeviceInput(device: device),
              session.canAddInput(input)
        else { return }
        
        session.addInput(input)
        
        guard session.canAddOutput(photoOutput) else { return }
        session.addOutput(photoOutput)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer.frame = bounds
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        addSubview(captureButton)
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            captureButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            captureButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            captureButton.widthAnchor.constraint(equalToConstant: 140),
            captureButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        captureButton.addTarget(self, action: #selector(didTapCapture), for: .touchUpInside)
        
        setupPopup()
    }
    
    private func setupPopup() {
        popupView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        popupView.alpha = 0
        popupView.isHidden = true
        
        popupImageView.contentMode = .scaleAspectFit
        
        addSubview(popupView)
        popupView.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(popupImageView)
        popupView.addSubview(popupCancelButton)
        
        popupImageView.translatesAutoresizingMaskIntoConstraints = false
        popupCancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            popupView.topAnchor.constraint(equalTo: topAnchor),
            popupView.bottomAnchor.constraint(equalTo: bottomAnchor),
            popupView.leadingAnchor.constraint(equalTo: leadingAnchor),
            popupView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            popupImageView.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            popupImageView.centerYAnchor.constraint(equalTo: popupView.centerYAnchor),
            popupImageView.widthAnchor.constraint(equalTo: popupView.widthAnchor, multiplier: 0.8),
            popupImageView.heightAnchor.constraint(equalTo: popupView.heightAnchor, multiplier: 0.6),
            
            popupCancelButton.topAnchor.constraint(equalTo: popupImageView.bottomAnchor, constant: 20),
            popupCancelButton.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            popupCancelButton.widthAnchor.constraint(equalToConstant: 120),
            popupCancelButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        popupCancelButton.addTarget(self, action: #selector(didTapCancelPopup), for: .touchUpInside)
    }
    
    
    // MARK: - Actions
    @objc private func didTapCapture() {
        capturePhoto()
    }
    
    @objc private func didTapCancelPopup() {
        hidePopup()
    }
    
    
    // MARK: - Capture
    var onPhotoCaptured: ((UIImage) -> Void)?
    
    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = .off
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    
    // MARK: - Popup
    private func showPopup(with image: UIImage) {
        popupImageView.image = image
        popupView.isHidden = false
        
        UIView.animate(withDuration: 0.25) {
            self.popupView.alpha = 1
        }
    }
    
    private func hidePopup() {
        UIView.animate(withDuration: 0.25, animations: {
            self.popupView.alpha = 0
        }) { _ in
            self.popupView.isHidden = true
        }
    }
}


// MARK: - Delegate
extension CameraView: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        guard error == nil,
              let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data)
        else { return }
        
        onPhotoCaptured?(image)
        showPopup(with: image)
    }
}
