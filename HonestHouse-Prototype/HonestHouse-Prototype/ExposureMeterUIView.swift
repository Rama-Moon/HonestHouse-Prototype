//
//  ExposureMeterUIView.swift
//  HonestHouse-Prototype
//
//  Created by Rama on 9/30/25.
//

import SwiftUI
import AVFoundation

struct Exposure {
    let iso: Float
    let exposureDuration: Double
    let aperture: Float
    let ev: Double
    let bias: Float
    let offset: Float
    let mode: AVCaptureDevice.ExposureMode
}

class ExposureMeterUIView: UIView {
    private let session = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var device: AVCaptureDevice?
    
    var onExposureValueUpdate: ((Exposure) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setCameraAuth()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = self.bounds
    }
    
    private func setCameraAuth() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setCameraSession()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.setCameraSession()
                    }
                }
            }
        default:
            print("@Log - 카메라 권한이 거부되었습니다")
        }
    }
    
    private func setCameraSession() {
        session.beginConfiguration()
        session.sessionPreset = .photo
        
        if let camera = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: .back
        ) {
            device = camera
            
            do {
                let input = try AVCaptureDeviceInput(device: camera)
                
                if session.canAddInput(input) {
                    session.addInput(input)
                }
            } catch {
                print("@Log - camera error: \(error)")
            }
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.videoGravity = .resizeAspectFill

        if let previewLayer = previewLayer {
            self.layer.addSublayer(previewLayer)
        }
        
        session.commitConfiguration()
        
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.readExposureValues()
        }
    }
    
    private func readExposureValues() {
        guard let device = device else { return }
        
        let iso = device.iso
        let exposure = device.exposureDuration.seconds
        let bias = device.exposureTargetBias
        let offset = device.exposureTargetOffset
        let mode = device.exposureMode
        let aperture = device.lensAperture
        
        let ev: Double
        
        if aperture > 0 && exposure > 0 {
            ev = log2((Double(aperture * aperture) / exposure) * (100.0 / Double(iso)))
        } else {
            ev = 0
        }
        
        let exposureValue = Exposure(
            iso: iso,
            exposureDuration: exposure,
            aperture: aperture,
            ev: ev,
            bias: bias,
            offset: offset,
            mode: mode
        )

        onExposureValueUpdate?(exposureValue)
    }
}
