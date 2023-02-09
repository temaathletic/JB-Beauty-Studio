//
//  ScanViewControllerDecrimentBonus.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 09.02.2023.
//

import AVFoundation
import UIKit
import SnapKit

class ScanVCFormCartForDicrement: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    public var stringValue2 = ""
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
       
    private lazy var grView: UIImageView = {
        let grView = UIImageView()
        grView.layer.borderWidth = 2
        grView.layer.borderColor = UIColor.systemRed.cgColor
        return grView
    }()
    
    private lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 15
        btn.setTitle("Назад", for: .normal)
        btn.setTitleColor(Color.mainTextColor, for: .normal)
        btn.backgroundColor = Color.mainRedColor
        btn.addTarget(self, action: #selector(goBackAgain), for: .touchUpInside)
        return btn
    }()
    
    //var productSCanVC: ProductScanViewController!
    
    let systemSoundID: SystemSoundID = 1016
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
  
        reStart()
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeLeft)
        view.isUserInteractionEnabled = true
        
        view.addSubview(grView)
        view.addSubview(cancelBtn)
        
        cancelBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(40)
        }
        
        grView.snp.makeConstraints { make in
            make.size.equalTo(300)
            make.center.equalToSuperview()
        }
        
        
    }
                     
    @objc func swipe(){
        self.dismiss(animated: true, completion: nil)
    }

    func reStart(){
        //view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            //productSCanVC.didScannerOpen = false
            
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            //FORMATS OF BARCODE
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417, .code39, .code128, .qr]
        } else {
            failed()
           // productSCanVC.didScannerOpen = false
            
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = self.view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        
       
        view.bringSubviewToFront(grView)
        view.bringSubviewToFront(cancelBtn)
        
        Service.afterBlock(seconds: 0, queue: .global()) {
            self.captureSession.startRunning()
        }
    }
    
    @objc func goBackAgain(){
        self.dismiss(animated: true)
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        Service.afterBlock(seconds: 1, queue: .global()) {
            if (self.captureSession?.isRunning == true) {
                self.captureSession.startRunning()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(stringValue)
            stringValue2 = stringValue
        }
    }

    func found(_ code: String) {
        
       AudioServicesPlaySystemSound(systemSoundID)
        print("CODE -> \(code)")
        
        Service.afterBlock(seconds: 0, queue: .main, complition: { [ weak self ] in
            let scene = AdminUserSettingPanel()
            scene.stringValue4 = self!.stringValue2
            self!.present(scene, animated: true)
        })
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
