//
//  SpeechRecognizer.swift
//  iosApp
//
//  Created by pratidnya on 11/02/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import Speech
import AVFoundation

class SpeechRecognizer: ObservableObject {
    @Published var recognizedText: String = ""
    
    private let speechRecognizer = SFSpeechRecognizer()
    var audioEngine = AVAudioEngine()
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    
    func requestPermissions() {
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                if status != .authorized {
                    print("Speech recognition permission denied ❌")
                }
            }
        }
        
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            DispatchQueue.main.async {
                if !granted {
                    print("Microphone permission denied ❌")
                }
            }
        }
    }
    
    func startListening() {
        recognizedText = "" // Clear previous text
        
        // Check if speech recognition is available
        guard let recognizer = speechRecognizer, recognizer.isAvailable else {
            print("Speech recognizer not available ❌")
            return
        }
        
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.record, mode: .measurement, options: .duckOthers)
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
            return
        }
        
        request = SFSpeechAudioBufferRecognitionRequest()
        guard let request = request else { return }
        request.shouldReportPartialResults = true
        
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            request.append(buffer)
        }
        
        recognitionTask = recognizer.recognitionTask(with: request) { result, error in
            if let result = result {
                DispatchQueue.main.async {
                    self.recognizedText = result.bestTranscription.formattedString
                    print("User Said: \(self.recognizedText)") // ✅ PRINT SPEECH TEXT
                }
            }
            
            if error != nil {
                self.stopListening()
            }
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
            print("🎤 Listening for speech...")
        } catch {
            print("Failed to start audio engine: \(error.localizedDescription)")
        }
    }
    
    func stopListening() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        request?.endAudio()
        recognitionTask?.cancel()
        request = nil
        recognitionTask = nil
        print("🛑 Stopped listening.")
    }
}

