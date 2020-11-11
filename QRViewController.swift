//
//  QRViewController.swift
//  SignIn
//
//  Created by Bernardina Maldonado on 10/23/20.
//

import UIKit
import AVFoundation

class QRViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate, AVCaptureMetadataOutputObjectsDelegate {
    
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var lblOutput: UILabel!
    
    var imageOrientation: AVCaptureVideoOrientation?
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var capturePhotoOutput: AVCapturePhotoOutput?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else
        {
            fatalError("No device found")
        }
        
        //get and instance of AVCaptureDeviceInput class using the previous device object
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            //initialize captureSession object
            captureSession = AVCaptureSession()
            
            //set the input device
            captureSession?.addInput(input)
            
            //get instance of AVCapturePhotoOutput class
            capturePhotoOutput = AVCapturePhotoOutput()
            capturePhotoOutput?.isHighResolutionCaptureEnabled = true
            
            //set output on capture session
            captureSession?.addOutput(capturePhotoOutput!)
            captureSession?.sessionPreset = .high

            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            
            
            captureSession?.startRunning()
        }
        catch
        {
            //if an error occurs...
            print(error)
            return
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigattionBarHidden(true, animated: false)
        self.captureSession?.startRunning()
    }
    
    func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice?
    {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
        for device in discoverySession.devices {
            if device.position == position
            {
                return device
            }
    }
     
        return nil
        
    }
    
    
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection)
    {
        //check metadataObjects array contains at least one object
        if metadataObjects.count == 0
        {
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr
        {
            if let outputString = metadataObj.stringValue
            {
                DispatchQueue.main.async
                {
                    print(outputString)
                    self.lblOutput.text = outputString
                }
            }
        }
        
    }

}
