//
//  HeaderBackButtonView.swift
//  iosApp
//
//  Created by Srushti Choudhari on 30/06/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct HeaderBackButtonView: View {
    @ObservedObject var viewmodel: CSApiViewModel
//    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    var isShowBack: Bool
    @EnvironmentObject var vm: UserAuthModel
    @State private var navigateToScanner1 = false
    var onBack: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            if isShowBack {
                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
                    onBack()
                }) {
//                    Image("Arrows")
//                        .resizable()
//                        .frame(width: 26, height: 28) // Keep the heart small
//                        .scaledToFit()
//                        .padding(6)
//                        .foregroundColor(.black)
//                        .background(Color.white)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                    Image("Action Arrows")
                }
            }
            
            
//            Image("cornershopimg")
            Image("Asset") //changed by sudipa
                .resizable()
                .frame(width: 42, height: 48)
                .padding(.leading, 5)
            
            Spacer()
            
//            Button(action: {
//                vm.signOut()
//            }, label: {
//                ImgView(imgName: "CS - Navigate to Product", width: 8)
//                    .padding()
//                    .shadow(color: Color(red: 0.19, green: 0.19, blue: 0.19).opacity(0.15), radius: 2.5, x: 1, y: 2)
//                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(red: 0, green: 0.45, blue: 0.42), lineWidth: 1))
//                    .padding(.trailing, 10)
//                
//                    
//            })
            
            Button(action: {
                
            }, label: {
                ImgView(imgName: "In-Store Navigation BUTTON", width: 55)
//                ImgView(imgName: "CS - Navigate to Product", width: 25)
//                    .padding()
//                    .frame(width: 40, height: 40, alignment: .center)
//                    .background(.white)
//                    .cornerRadius(5)
//                    .shadow(color: Color(red: 0.19, green: 0.19, blue: 0.19).opacity(0.15), radius: 2.5, x: 1, y: 2)
//                    .overlay(
//                    RoundedRectangle(cornerRadius: 5)
//                    .inset(by: 0.5)
//                    .stroke(Color(red: 0, green: 0.45, blue: 0.42), lineWidth: 1)
//
//                    )
//                    .padding(.trailing, 10)
            })
            
            Button(action: {
                print("Initializing scanner...")
                navigateToScanner1 = true
            }) {
                ImgView(imgName: "Scan Product 1", width: 55)
//                ImgView(imgName: "Scan Product", width: 40)
//                    .shadow(color: Color(red: 0.19, green: 0.19, blue: 0.19).opacity(0.15), radius: 2.5, x: 1, y: 2)
            }
            
            // Hidden NavigationLink for Scanner
            NavigationLink(
                destination: ARViewWithOverlay(viewType: .contentView)
                    .edgesIgnoringSafeArea(.all),
                isActive: $navigateToScanner1,
                label: { EmptyView() }
            )
        }
        .frame(height: 50)
        .padding(.horizontal)
    }
}

