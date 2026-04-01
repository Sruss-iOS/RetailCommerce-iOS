//
//  CameraPreview.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 5/3/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    let onBuffer: (CMSampleBuffer) -> Void

    func makeUIView(context: Context) -> CameraPreviewView {
        let cameraView = CameraPreviewView()
        cameraView.delegate = context.coordinator
        return cameraView
    }

    func updateUIView(_ uiView: CameraPreviewView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(onBuffer: onBuffer)
    }

    class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        let onBuffer: (CMSampleBuffer) -> Void

        init(onBuffer: @escaping (CMSampleBuffer) -> Void) {
            self.onBuffer = onBuffer
        }

        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            onBuffer(sampleBuffer)
        }
    }
}

class CameraPreviewView: UIView {
    weak var delegate: AVCaptureVideoDataOutputSampleBufferDelegate?

    private let session = AVCaptureSession()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCamera()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCamera() {
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else {
            return
        }

        if session.canAddInput(input) {
            session.addInput(input)
        }

        let output = AVCaptureVideoDataOutput()
        output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        output.setSampleBufferDelegate(delegate, queue: DispatchQueue(label: "cameraQueue"))

        if session.canAddOutput(output) {
            output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String : Int(kCVPixelFormatType_32BGRA)]
            session.addOutput(output)
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = bounds
        layer.addSublayer(previewLayer)

        session.startRunning()
    }
}

