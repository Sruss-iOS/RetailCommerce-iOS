//
//  PaymentDoneView.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 4/26/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct PaymentDoneView: View {
    
    @ObservedObject var viewmodel: CSApiViewModel
    @State var isShowProductListView: Bool = false
    @State var isShowCartSummary: Bool = false
    @State var isLoading: Bool = false
    @StateObject var paymentHandler : PaymentHandler
    @State var isPaymentSuccess: Bool = false
    
    var body: some View {
        VStack {
            VStack(spacing: 12) {
                Spacer()
                Image("CS - Check")
                    .resizable()               // ✅ Works fine now!
                    .scaledToFit()
                    .frame(width: 120, height: 120, alignment: .center)
                
                Text("Payment Successful!")
                    .foregroundColor(Color(hex: 0x30B400))
                    .fontWeight(.bold)
                    .font(.system(size: 26))
                
                Text("The order confirmation has been \n sent to your email address")
                    .foregroundColor(Color(hex: 0x4f4f4f))
                    .fontWeight(.regular)
                    .font(.system(size: 18))
                
                Text("Order ID:")
                    .foregroundColor(Color(hex: 0x4f4f4f))
                    .fontWeight(.regular)
                    .font(.system(size: 18))
                
                Text("\(viewmodel.cartSummaryList?.id ?? "")")
                    .foregroundColor(Color(hex: 0x4f4f4f))
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                
//                Text("Delivery: \(viewmodel.cartSummaryList?.orderState ?? "")")
//                    .foregroundColor(Color(hex: 0x4f4f4f))
//                    .fontWeight(.regular)
//                    .font(.system(size: 16))
                            
                Button {
                    isShowCartSummary = true
                } label: {
                    Text("View Order Summary")
                        .font(.title3)
                        .padding()
                        .foregroundColor(Color(hex: 0x0070ad))
                }
                Spacer()
            }
            .frame(alignment: .center)
            
            Spacer()
            VStack{
                HStack {
                    Spacer() // Adds space on the left
                    Button {
                        isShowProductListView = true
        
                    } label: {
                        
                        Text("Continue Shopping")
                            .font(.custom("Ubuntu-Regular", size: 16))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: 0x0070ad))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    Spacer() // Adds space on the left
                }.padding(.horizontal, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $isShowProductListView) {
           // ProductListView(viewmodel: viewmodel, isLoading: false)
            CustomTabView(viewmodel: viewmodel)
            
        }
        .navigationDestination(isPresented: $isShowCartSummary) {
            OrderSummeryView(viewmodel: viewmodel)
        }
        .onAppear(perform: {
            if !isPaymentSuccess{
                isLoading = true
                viewmodel.postPaymentStatus(paymentInterface: "Razorpay", type: "Charge", interfaceId: "\(paymentHandler.paymentID ?? "")", method: "Razorpay", state: "Success") { result in
                    if result{
                        viewmodel.getCartSummary { result in
                            if result {
                                print("Get Summary API")
                                isLoading = false
                                isPaymentSuccess = true
                            }else{
                                isLoading = false
                            }
                        }
                    }else{
                        isLoading = false
                    }
                }
            }
            
        })
        .overlay(
            Group {
                if isLoading {
                    Color.white.opacity(0.5)
                        .blur(radius: 10)
                        .edgesIgnoringSafeArea(.all)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2) // Bigger loader
                        .tint(
                            Color(red: 0/255, green: 112/255, blue: 173/255)
//                            Color(
//                                red: 207 / 255.0,
//                                green: 118 / 255.0,
//                                blue: 27 / 255.0,
//                                opacity: 1.0
//                            )
)
                        
                }
            }
        )
    }
}

struct PaymentDoneView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentDoneView(viewmodel: CSApiViewModel(), paymentHandler: PaymentHandler())
    }
}
