//
//  QRScanView.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 3/22/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import AVFoundation
import ARKit
import RealityKit
import AVKit

// UIViewRepresentable for ARKit ARView
struct ARviewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        // Configure ARView properties
//        let anchor = AnchorEntity()
//        //let urlstring = "https://cornershop-bff-uajh2inwbq-el.a.run.app/api/v1/video/da6b1dde-d8dd-475b-8912-b15b4f13dae2"
//        if let url = Bundle.main.url(forResource: "da6b1dde-d8dd-475b-8912-b15b4f13dae2", withExtension: "mp4")
//        {
//            let player = AVPlayer(url: url)
//            let material = VideoMaterial(avPlayer: player)
//            let modelentity = ModelEntity(mesh: .generateBox(width: 2.0, height: 1.17, depth: 0.01), materials: [material])
//            player.play()
//            modelentity.position -= 2
//            modelentity.setParent(anchor)
//            arView.scene.addAnchor(anchor)
//        }
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Update ARView if needed
    }
}

struct CodeScannerView: UIViewRepresentable {
    let codeTypes: [AVMetadataObject.ObjectType]
    let completion: (Result<String, ScanError>) -> Void
    let simulatedData: String?

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.global(qos: .userInitiated).async {
            // Set up AVCaptureSession
            let captureSession = AVCaptureSession()
            
            // Configure AVCaptureDeviceInput for camera
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video),
                  let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice),
                  captureSession.canAddInput(videoInput) else {
                return
            }
            captureSession.addInput(videoInput)
            
            // Configure AVCaptureMetadataOutput to detect QR codes
            let metadataOutput = AVCaptureMetadataOutput()
            guard captureSession.canAddOutput(metadataOutput) else {
                return
            }
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
            
            // Configure AVCaptureVideoPreviewLayer for camera preview
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            DispatchQueue.main.async {
                previewLayer.frame = view.layer.bounds
                view.layer.addSublayer(previewLayer)
            }
            
            // Start AVCaptureSession
            captureSession.startRunning()
        }
        
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Update UIView if needed
    }

    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        let parent: CodeScannerView

        init(parent: CodeScannerView) {
            self.parent = parent
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            // Process detected metadataObjects to find QR codes
            if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
               let code = metadataObject.stringValue {
                parent.completion(.success(code))
            } else {
                parent.completion(.failure(.notFound))
            }
        }
    }

    enum ScanError: Error {
        case notFound
    }
}

// QRScanView
struct QRScanView: View {
    @State private var isShowingScanner = true
    @State private var scannedCode: String?
    
    @State private var isPlaying = false
    @State private var player = AVPlayer()
    
    var body: some View {
        VStack {
            if scannedCode != nil {
                ARviewContainer()
                    .overlay(
                        VideoPlayer(player: player)
                            .onAppear {
                                if let videoURL = Bundle.main.url(forResource: "da6b1dde-d8dd-475b-8912-b15b4f13dae2", withExtension: "mp4"){
                                    player = AVPlayer(url: videoURL)
                                }
                            }
                            .onDisappear {
                                player.pause()
                            }
                            .frame(width: 300, height: 300)
                    )
            } else {
                Button("Scan QR Code") {
                    isShowingScanner = true
                }
            }
        }
        .sheet(isPresented: $isShowingScanner) {
            // Present QR code scanner here
            CodeScannerView(codeTypes: [.qr], completion: self.handleScan, simulatedData: "")
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        switch result {
        case .success(let code):
            self.scannedCode = code
            print("scan code is \(scannedCode)")
            // Use the scanned code to load the video and display it in AR
        case .failure(let error):
            print("Scanning failed: \(error)")
        }
    }
}
