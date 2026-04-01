//
//  ScanTFLiteView.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 4/3/24.
//  Copyright © 2024 orgName. All rights reserved.
//

//import SwiftUI
//import AVFoundation
//import TensorFlowLiteTaskVision
//
//struct ScanTFLiteView: View {
//    @ObservedObject var objectDetector : ObjectDetectorHelper
//
//    var body: some View {
//        CameraPreview { pixelBuffer in
//            objectDetector.predict(pixelBuffer: pixelBuffer as! CVPixelBuffer)
//        }
//        .overlay(drawObjects(objectDetector.detectedObjects))
//        .edgesIgnoringSafeArea(.all)
//    }
//
//    private func drawObjects(_ objects: [DetectedObject]) -> some View {
//        var views: [AnyView] = []
//
//        for object in objects {
//            let rect = object.rect
//            let label = object.label
//
//            let shape = Rectangle()
//                .stroke(Color.red, lineWidth: 2)
//                .frame(width: rect.width, height: rect.height)
//                .position(x: rect.midX, y: rect.midY)
//
//            let text = Text(label)
//                .foregroundColor(.red)
//                .position(x: rect.midX, y: rect.midY + rect.height / 2 + 15)
//
//            views.append(AnyView(shape))
//            views.append(AnyView(text))
//        }
//
//        return ZStack(content: {
//            ForEach(views.indices, id: \.self) { index in
//                views[index]
//            }
//        })
//    }
//}
//
//struct ScanTFLiteView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScanTFLiteView(objectDetector: ObjectDetectorHelper()!)
//    }
//}
//
