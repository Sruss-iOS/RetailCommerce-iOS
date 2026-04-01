//
//  AddCardDetailsView.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 4/26/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct AddCardDetailsView: View {
    
    @State var cardNo: String = ""
    @State var expMonth: String = ""
    @State var expYear: String = ""
    @State var cvvNo: String = ""
    @State var cardName: String = ""
    @State var nickName: String = ""
    @State private var showGreeting = true
    
    @ObservedObject var viewmodel: CSApiViewModel
    
    var body: some View {
        NavigationLink {
            PaymentDoneView(viewmodel: viewmodel, paymentHandler: PaymentHandler())
        } label: {
            VStack{
                ScrollView{
                    VStack {
                        VStack {
                            Text("Card Number")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextField("-", text: $cardNo)
                                .padding(.horizontal, 10)
                                .frame(height: 42)
                                .background(.thinMaterial)
                                .cornerRadius(10)
                        }.padding(.top, 16)
                        HStack{
                            VStack {
                                Text("Valid Through (MM/YY)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    Spacer()
                                    TextField("-", text: $expMonth)
                                        .padding(.horizontal, 10)
                                        .frame(height: 42)
                                        .background(.thinMaterial)
                                        .cornerRadius(10)
                                    Text("/")
                                        .font(.title3)
                                    TextField("-", text: $expYear)
                                        .padding(.horizontal, 10)
                                        .frame(height: 42)
                                        .background(.thinMaterial)
                                        .cornerRadius(10)
                                    Spacer()
                                }
                            }.padding(.top, 10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            VStack {
                                Text("CVV")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                TextField("-", text: $cvvNo)
                                    .padding(.horizontal, 10)
                                    .frame(height: 42)
                                    .background(.thinMaterial)
                                    .cornerRadius(10)
                            }.padding(.top, 10)
                                .frame(maxWidth: 120, alignment: .trailing)
                        }
                        VStack {
                            Text("Name On Card")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextField("-", text: $cardName)
                                .padding(.horizontal, 10)
                                .frame(height: 42)
                                .background(.thinMaterial)
                                .cornerRadius(10)
                        }.padding(.top, 10)
                        VStack {
                            Text("Card Nickname")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextField("-", text: $nickName)
                                .padding(.horizontal, 10)
                                .frame(height: 42)
                                .background(.thinMaterial)
                                .cornerRadius(10)
                        }.padding(.top, 10)
                        
                        Spacer()
                        
                    }
                }
                VStack{
                    //Toggle("Save Card as per RBI Guidelines", isOn: $showGreeting)
                    Toggle(isOn: $showGreeting) {
                        Text("Save Card as per RBI Guidelines")
                    }
                    Text("Proceed")
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color(hex: 0x00d6be))
                        .cornerRadius(10)
                }
            }
            .foregroundColor(.black)
            .navigationTitle("Add New Card")
        }.padding(16)
    }
}

struct AddCardDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardDetailsView(viewmodel: CSApiViewModel())
    }
}
