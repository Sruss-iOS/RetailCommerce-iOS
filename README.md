# RetailCommerce-iOS

<img width="193" height="552" alt="Onboarding Intro Screen 2" src="https://github.com/user-attachments/assets/2c05ad10-2dd8-451f-aae6-5d7da1f437e1" />

<img width="193" height="552" alt="FINAL" src="https://github.com/user-attachments/assets/b8690797-ac5b-4560-a4e6-6d335e6bb101" />

<img width="193" height="552" alt="Off-Store" src="https://github.com/user-attachments/assets/d486324d-0a71-40d6-a3dd-ec69012b8412" />

<img width="193" height="552" alt="Final" src="https://github.com/user-attachments/assets/1ef61802-0068-4856-b1a7-1f823935dc26" />

<img width="193" height="552" alt="Cart" src="https://github.com/user-attachments/assets/b0ac5058-7fe4-4e76-9e3c-df8218ddb095" />

<img width="193" height="552" alt="Payment option" src="https://github.com/user-attachments/assets/5cb0de0a-c60d-4c36-9bf5-e5070fabc9fc" />

<img width="193" height="552" alt="NEW Revamp" src="https://github.com/user-attachments/assets/955f1506-9ef8-4317-9150-d692a26e0a2a" />

<img width="193" height="552" alt="NEW Revamp" src="https://github.com/user-attachments/assets/096b2e88-5465-4683-bd47-855042dacf32" />



This repository contains the iOS app for CornerShop, a retail mobile experience that includes multiple features such as an on-device object-detection pipeline, a conversational chatbot (ADK), product listings and detail pages, and payment integrations.

This README is intended to be the single project-level entry point. For focused developer documentation about specific features check the per-feature READMEs linked below.

Quick links

- Project root (iOS app): `iosApp/`
- Feature READMEs:
  - Chatbot (project-level): `iosApp/iosApp/CHATBOT_PROJECT_README.md`
  - ChatBot view doc: `iosApp/iosApp/View/ChatBotView/README.md`
  - Object detection notes (earlier version): `iosApp/README.md` (this file previously focused on object detection; per-feature docs may still exist in the repo)

Goals

- Provide an extensible iOS codebase for retail scenarios: search, product discovery, chat-driven assistance, and on-device object detection.
- Keep UI in SwiftUI and business logic in ViewModels with light Core Data usage for product metadata.
- Integrate third-party libraries through CocoaPods (TensorFlowLite, MediaPipe, Razorpay, etc.) and keep native performance on devices.

Key features

- Chatbot (ADK): Conversational assistant that can return text, quick-reply buttons, product lists, and rich route/gif responses.
- On-device object detection: TensorFlow Lite model for detecting products in camera feed and showing bounding boxes with product cards.
- Product browsing & detail views: Product list, detail pages, and add-to-cart flows (Core Data/remote sync visible in code).
- Payments: Razorpay integration (present in Pods) for checkout flows.

Repository layout (high level)

- iosApp/
  - iosApp/ — Xcode app target sources
    - App entry: `iOSApp.swift`, `AppDelegate` (if present), `Info.plist`
    - View/ — SwiftUI views (ChatBotView, product list, bounding boxes, etc.)
    - ViewModel/ — View models that contain app logic and remote calls
    - Model/ — Data model objects and Core Data helpers
    - Assets.xcassets/ — Images and vector assets
    - Model files: `cornershopmodel.tflite` (packed model for on-device detection)
    - Config files: `Dev.xcconfig`, `Prod.xcconfig`
    - README & docs: `CHATBOT_PROJECT_README.md`, and per-view READMEs under `View/`
  - iosApp.xcodeproj/ and iosApp.xcworkspace/ — Xcode project & workspace files
  - Pods/ — CocoaPods dependencies (this workspace already includes `Pods/` and `Podfile.lock`)
  - iosAppTests/ — Unit test targets

Dependencies

- Xcode (recommended: Xcode 14+; confirm project settings for the exact minimum)
- CocoaPods for dependency management (Pods directory already present)
- Third-party libraries included in `Pods/` (examples seen in this workspace):
  - TensorFlowLite / TensorFlowLiteSwift
  - MediaPipeTasksVision / MediaPipeTasksCommon
  - GoogleAPIClientForREST, GTMSessionFetcher
  - Razorpay SDK
  - NukeUI (image loading)

Setup & Build (local macOS)

1. Install prerequisites (if not already present):

```bash
# Install CocoaPods (if not installed)
sudo gem install cocoapods

# Ensure Xcode command line tools are available
xcode-select --install
```

2. From the project iOS root, (optional) refresh CocoaPods and open the workspace:

```bash
cd "/Users/srushtichoudhari/Desktop/Retail X/CornerShopAppMobileAndroid/iosApp/"
# Only necessary if you want to update/restore Pods
pod install --repo-update

# Open the workspace (always open the workspace not the project)
open iosApp.xcworkspace
```

3. Pick a scheme and run on a simulator or a real device.

Important note: If you use the camera or certain platform features, test on a physical device for accurate performance and access to hardware sensors.

Runtime & permissions

- Camera: `NSCameraUsageDescription` must be present in `Info.plist` if running object-detection features.
- Microphone: If using speech recognition (voice input), `NSSpeechRecognitionUsageDescription` / `NSMicrophoneUsageDescription` may be required.
- Networking: Ensure appropriate App Transport Security (ATS) rules if loading non-HTTPS resources; use secure URLs where possible.

Feature-specific docs

- Chatbot
  - High-level: `iosApp/iosApp/CHATBOT_PROJECT_README.md` — architecture, API interactions, and developer notes.
  - Chat view: `iosApp/iosApp/View/ChatBotView/README.md` — UI components, integration points, and tips.

- Object detection
  - The older object-detection-focused README content has been merged into this file. Look for `cornershopmodel.tflite` in `iosApp/iosApp/` and the UI views in `View/TensorFlowOB/`.

Testing

- Unit tests: Run tests from Xcode (Product → Test) or with xcodebuild:

```bash
# Example — run all tests for the iosApp scheme
xcodebuild -workspace iosApp.xcworkspace -scheme iosApp -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 14' test
```

- UI tests: add or run UI tests on a simulator or device. Network interactions can be mocked by stubbing network layer responses in `ViewModel` or `ChatApiClient`.

Troubleshooting

- CocoaPods / missing frameworks:
  - Ensure you're opening `iosApp.xcworkspace` not `iosApp.xcodeproj`.
  - Clean derived data and the build folder if you encounter missing header or linker errors.

- Model not loading at runtime:
  - Confirm `cornershopmodel.tflite` is added to the app target resources and filename matches exactly.

- Camera feed blank or missing permission:
  - Make sure `NSCameraUsageDescription` exists in `Info.plist`. If the user denied access earlier, enable it in Settings.

- GIF playback or large images:
  - Network GIFs are loaded and decoded on background threads. If large GIFs cause memory spikes, consider downsampling or switching to a streaming/animated-image framework.

CI / Automation suggestions

- Add a small CI job that runs unit tests using `xcodebuild` on every PR.
- Add a linting step (SwiftLint) to ensure consistent style across the codebase.

Contributing

- Fork the repository and open a PR with a clear description. Keep changes focused (UI vs model vs infra).
- Add unit tests for new features and update existing tests when behavior changes.

Security & secrets

- Do not commit API keys or secrets. The repository contains `GoogleService-Info.plist` (used for Firebase or Google services); keep production credentials out of public repos and use environment-specific config files.

License

- There is no LICENSE file in this repository. If you plan to share or accept outside contributions, add a LICENSE describing the terms.

Contact / next steps

If you'd like, I can also:

- Generate a short developer guide that traces the chatbot flow end-to-end (which file sends messages, where responses are parsed, and how product results map to the product detail view).
- Add a CONTRIBUTING.md and a LICENSE file.
- Add SwiftLint and a minimal GitHub Actions workflow to run tests on PRs.

---

Last updated: 2026-04-01
