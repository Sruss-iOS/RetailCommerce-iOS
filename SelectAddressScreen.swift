//
//  SelectAddressScreen.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 4/10/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct SelectAddressScreen: View {
    
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: .infinity))
    ]
    @State var isLoading: Bool = false
    @Binding var isShowAddScreen: Bool
    @ObservedObject var viewmodel : CSApiViewModel
    @Binding var showSelectAddPage : Bool
    @Binding var showCartDetailPage : Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Divider()
                        .frame(width: 40, height: 4)
                        .background(.secondary)
                        .cornerRadius(2)
                    Spacer()
                }
                .padding(.top, 4)
                
                HStack {
                    Text("Choose a Delivery Address")
                        .foregroundColor(Color(hex: 0x00d6be))
                        .font(.system(size: 17, weight: .medium))
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16))
                }
                
                VStack {
                    Button {
                        isLoading = true
                        isShowAddScreen = true
                        showSelectAddPage = false
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(hex: 0x00d6be))
                        Text("Add Address")
                            .foregroundColor(Color(hex: 0x00d6be))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 20, leading: 16, bottom: 10, trailing: 0))
                    
                    Divider()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .background(.secondary)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: adaptiveColumn, spacing: 20) {
                            ForEach(0..<adddressData().addTitle.count, id: \.self) { item in
                                VStack {
                                    HStack {
                                        Image("locationImg")
                                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 10))
                                            .frame(width: 40, height: 40, alignment: .center)
                                        
                                        HStack(alignment: .center, content: {
                                            VStack(alignment: .leading, content: {
                                                Text(adddressData().addTitle[item])
                                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                                    .font(.system(size: 17))
                                                
                                                Text(adddressData().addDesc[item])
                                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                                    .foregroundColor(.secondary)
                                                    .font(.system(size: 12))
                                            })
                                        })
                                        
                                        Image("nextImg")
                                            .padding(.trailing, 20)
                                            .frame(alignment: .center)
                                            .frame(width: 24, height: 24)
                                    }
                                    Divider()
                                        .frame(maxWidth: .infinity, maxHeight: 1)
                                        .background(.secondary)
                                }
                                .onTapGesture {
                                    isLoading = true
                                    isShowAddScreen = false
                                    showSelectAddPage = false
                                    showCartDetailPage = true
                                    let addStr = "Tagore Nagar, Vikroli, Mumbai, IN"
                                    UserDefaults.standard.setValue(addStr, forKey: "currentAdd")
                                    //viewmodel.saveAddress(streetName: "Tagore Nagar", apartment: "Vikroli", city: "Mumbai", countryCode: "IN")
                                    
                                }
                            }
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .background(.white)
            }
            .background(Color(hex: 0xf3f3f3))
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
//                                Color(
//                                    red: 207 / 255.0,
//                                    green: 118 / 255.0,
//                                    blue: 27 / 255.0,
//                                    opacity: 1.0
//                                )
)
                            
                    }
                }
            )
//            .onChange(of: viewmodel.saveAddressValidate) { viewCartValidate in
//                if viewCartValidate {
//                    isLoading = false
//                    showCartDetailPage = true
//                }
//            }
        }
    }
}


struct SelectAddressScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectAddressScreen(isShowAddScreen: .constant(false), viewmodel: CSApiViewModel(), showSelectAddPage: .constant(false), showCartDetailPage: .constant(false))
    }
}
