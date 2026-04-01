//
//  PaymentFail.swift
//  iosApp
//
//  Created by Vamsi on 21/10/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct PaymentFail: View {
    
    @ObservedObject var viewmodel: CSApiViewModel
    @State var isShowHome: Bool = false
    @State var isLoading: Bool = false
    @StateObject var paymentHandler : PaymentHandler
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            VStack(spacing: 12)  {
                Spacer()
                Image("CS - Fail")
                    .resizable()               // ✅ Works fine now!
                    .scaledToFit()
                    .frame(width: 120, height: 120, alignment: .center)
                Text("Payment Error")
                    .foregroundColor(Color(hex: 0xC90606))
                    .fontWeight(.bold)
                    .font(.system(size: 22))
                Text("We are unable to process your payment right now. \(paymentHandler.paymentFailReason ?? "User cancelled")")
                    .foregroundColor(Color(hex: 0x4f4f4f))
                    .font(.custom("Ubuntu-Regular", size: 16))
                Text("Code : \(paymentHandler.paymentFailCode ?? 0)")
                    .foregroundColor(Color(hex: 0x4f4f4f))
                    .font(.custom("Ubuntu-Regular", size: 16))
                Spacer()
                
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
        
            Spacer()
            
            VStack {
                Button {
                    // Action for Try Again
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Try Again")
                        .font(.custom("Ubuntu-Regular", size: 16))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: 0x0070ad))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.leading, 20) // Adds leading padding
                .padding(.trailing, 20) // Adds trailing padding
                
                Button {
                    // Action for Back to Home
                    
                    isShowHome = true
                } label: {
                    Text("Return to Home")
                        .frame(maxWidth: .infinity)
                        .font(.custom("Ubuntu-Regular", size: 16))
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(hex: 0x0070ad), lineWidth: 2))
                        .foregroundColor(Color(hex: 0x0070ad))
                }
                .padding(.leading, 20) // Adds leading padding
                .padding(.trailing, 20) // Adds trailing padding
            }

        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $isShowHome) {
            CustomTabView(viewmodel: viewmodel)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Payment Fail")
        .onAppear(perform: {
            isLoading = true
            viewmodel.postPaymentStatus(paymentInterface: "Razorpay", type: "Charge", interfaceId: "", method: "Razorpay", state: "Failure") { result in
                if result{
                    isLoading = false
                }else{
                    isLoading = false
                }
            }
        })
        .overlay(
            Group {
            }
        )
    }
}

struct PaymentFail_Previews: PreviewProvider {
    static var previews: some View {
        PaymentFail(viewmodel: CSApiViewModel(), paymentHandler : PaymentHandler())
    }
}
