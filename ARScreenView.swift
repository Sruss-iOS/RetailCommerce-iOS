//
//  ARScreenView.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 3/21/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import AVFoundation
import ARKit
import RealityKit
import AVKit

struct ARScreenView : View {
    @ObservedObject var arViewModel : ARViewModel = ARViewModel()
    @State private var player = AVPlayer()
    @State var isShowVideoPlayer : Bool = false
    
    var body: some View {
        ZStack {
            ARViewContainer(arViewModel: arViewModel, isShowVideoPlayer: $isShowVideoPlayer).edgesIgnoringSafeArea(.all)
            VStack {
                switch arViewModel.imageRecognizedVar {
                case true:
                    Button(action: {
                        isShowVideoPlayer = true
                    }){
                        Image(systemName: "play")
                            .padding(10)
                    }
                    if isShowVideoPlayer {
                        VStack{
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
                            Button(action: {
                                isShowVideoPlayer = false
                                arViewModel.startSessionDelegate()
                            }){
                                Image(systemName: "xmark.circle")
                                    .padding(10)
                            }
                        }
                    }
                case false:
                    EmptyView()
                }
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    var arViewModel: ARViewModel
    @Binding var isShowVideoPlayer: Bool
    
    func makeUIView(context: Context) -> ARView {
        arViewModel.startSessionDelegate()
        return arViewModel.arView
    }
    
    func restartView(){
        arViewModel.startSessionDelegate()
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
}

#if DEBUG
//struct ARScreenView_Previews : PreviewProvider {
//    static var previews: some View {
//        ContentView(path: .constant([]))
//    }
//}
#endif

