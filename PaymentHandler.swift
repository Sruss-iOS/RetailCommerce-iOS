//
//  PaymentHandler.swift
//  iosApp
//
//  Created by Vamsi on 14/10/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import Razorpay

class PaymentHandler: NSObject, RazorpayPaymentCompletionProtocol, ObservableObject {
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]) {
        
    }
    
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]) {
        
    }
    
    
    @Published var isPaymentSuccessful: Bool = false
    @Published var isPaymentFail: Bool = false
    @Published var paymentID: String?
    @Published var paymentFailCode: Int?
    @Published var paymentFailReason: String?
    var razorpay: RazorpayCheckout!

    override init() {
        super.init()
        // Replace YOUR_KEY_ID with the key you get from Razorpay dashboard
        razorpay = RazorpayCheckout.initWithKey("rzp_test_aMlgn7TKen58EW", andDelegate: self)
    }
    
    func startPayment(price : Int) {
        // firebase event logAddPaymentInfoEvent
        
        let options: [String: Any] = [
            "amount": "\(price*100)", // Amount in paise
            "currency": "INR",
            "description": "Test Payment",
            //"image": "https://example.com/logo.png", // Optional image URL
            "name": "CornerShop",
            "prefill": [
                "contact": "1234567890",
                "email": "test@example.com"
            ],
            "theme": [
                "color": "#01A78F" // Customize the color as per your needs
            ]
        ]
        razorpay.open(options)
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        print("Payment successful with ID: \(payment_id)")
        paymentID = payment_id
        isPaymentSuccessful = true // This will trigger the navigation in SwiftUI
    }
    
    func onPaymentError(_ code: Int32, description str: String) {
        print("Payment failed with code: \(code), description: \(str)")
        paymentFailCode = Int(code)
        paymentFailReason = str
        isPaymentFail = true
    }
}
