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
}

class ExposureMeterUIView: UIView {
    private let session = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var device: AVCaptureDevice?
    
    var onExposureValueUpdate: ((Exposure) -> Void)?
    var onStabilized: (() -> Void)?
    var onUnstabilized: (() -> Void)?
    
    private var hasConfigured = false
    private var isCurrentlyStabilized = false
    private var isPaused = false
    
    private var evHistory: [(value: Double, timestamp: Date)] = []
    private let stabilizationThreshold: Double = 1.0
    private let stabilizationDuration: TimeInterval = 3.0
    
    private var readTimer: Timer?
    
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
        guard !hasConfigured else { return }
        hasConfigured = true
        
        configureSession()
        setPreviewLayer()
        finishSessionSetting()
    }
    
    func configureSession() {
        session.beginConfiguration()
        session.sessionPreset = .photo
        
        addCameraInput()
        addVideoOutput()
        
        session.commitConfiguration()
    }
    
    func setPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.videoGravity = .resizeAspectFill
        
        if let previewLayer = previewLayer {
            self.layer.addSublayer(previewLayer)
        }
    }
    
    func finishSessionSetting() {
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
        }
        
        DispatchQueue.main.async {
            self.startReadingEV()
        }
    }
    
    func addCameraInput() {
        guard let camera = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: .back
        ) else {
            print("@Log - Can't find camera")
            return
        }
        
        device = camera
        
        do {
            let input = try AVCaptureDeviceInput(device: camera)
            if session.canAddInput(input) {
                session.addInput(input)
            }
        } catch {
            print("@Log - Camera error: \(error)")
        }
    }
    
    func addVideoOutput() {
        let videoOutput = AVCaptureVideoDataOutput()
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }
    }
    
    private func startReadingEV() {
        stopReadingEV()
        readTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.readEV()
        }
        RunLoop.main.add(readTimer!, forMode: .common)
    }
    
    private func stopReadingEV() {
        readTimer?.invalidate()
        readTimer = nil
    }
    
    private func readEV() {
        guard !isPaused, let device = device else { return }
        
        let iso = device.iso
        let exposure = device.exposureDuration.seconds
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
            ev: ev
        )

        onExposureValueUpdate?(exposureValue)
        checkStabilization(ev: ev)
    }
    
    private func checkStabilization(ev: Double) {
        let now = Date()
        
        evHistory.append((value: ev, timestamp: now))
        
        evHistory.removeAll { now.timeIntervalSince($0.timestamp) > stabilizationDuration }
        
        guard evHistory.count >= 5 else {
            if isCurrentlyStabilized {
                isCurrentlyStabilized = false
                onUnstabilized?()
            }
            return
        }
        
        let values = evHistory.map { $0.value }
        
        guard let minEV = values.min(),
              let maxEV = values.max() else {
            return
        }
        
        let diff = maxEV - minEV
        
        if diff <= stabilizationThreshold {
            if !isCurrentlyStabilized {
                isCurrentlyStabilized = true
                onStabilized?()
            }
        } else {
            if isCurrentlyStabilized {
                isCurrentlyStabilized = false
                onUnstabilized?()
            }
        }
    }
    
    func setPaused(_ paused: Bool) {
        guard paused != isPaused else { return }
        isPaused = paused
        if paused {
            pause()
        } else {
            resume()
        }
    }
    
    private func pause() {
        previewLayer?.connection?.isEnabled = false
        stopReadingEV()
        if session.isRunning {
            DispatchQueue.global(qos: .background).async {
                self.session.stopRunning()
            }
        }
    }
    
    private func resume() {
        if !session.isRunning {
            DispatchQueue.global(qos: .background).async {
                self.session.startRunning()
            }
        }
        previewLayer?.connection?.isEnabled = true
        startReadingEV()
    }
}
