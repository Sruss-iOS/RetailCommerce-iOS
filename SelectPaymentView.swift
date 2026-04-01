//
//  SelectPaymentView.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 4/25/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct SelectPaymentView: View {
    
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: .infinity))
        ]
    @ObservedObject var viewmodel: CSApiViewModel
    
    var body: some View {
        VStack{
            NavigationLink {
                AddCardDetailsView(viewmodel: viewmodel)
            } label: {
                VStack{
                    ScrollView(.vertical, showsIndicators: false){
                        LazyVGrid(columns: adaptiveColumn, spacing: 20){
                            ForEach(0..<paymentOptions().payopt.count, id: \.self) { item in
                                VStack{
                                    HStack{
                                        Text(paymentOptions().payopt[item])
                                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                            .font(.system(size: 17))
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Image("\(paymentOptions().payImg[item])")
                                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 10))
                                            .frame(width: 40, height: 40, alignment: .trailing)
                                    }
                                    Divider()
                                        .frame(maxWidth: .infinity, maxHeight: 1)
                                        .background(.secondary)
                                }
                            }
                        }
                    }
                    VStack{
                        HStack{
                            if (viewmodel.cartProductList?.count ?? 0) > 0{
                                //                            var count = viewmodel.productDetails?.itemPrice ?? 0
                                //                            var prize: Int = Int(count) * stepperValue
                                Text("\(viewmodel.cartProductList?.count ?? 0) Item")
                                    .foregroundColor(.black)
                                    .padding()
                                Button(action: {
                                    
                                }){
                                    Text("Total: 124")
                                        .font(.system(size: 18))
                                        .font(.title3)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding()
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        .background(Color(hex: 0x00d6be).clipShape(RoundedRectangle(cornerRadius: 10)))
                        .padding(16)
                    }
                    .background(
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(15)
                            .shadow(
                                color: Color.gray.opacity(0.2),
                                radius: 8,
                                x: 0,
                                y: 0
                            )
                    )
                }
            }
        }
        .navigationTitle("Select Payment Option")
    }
}

struct SelectPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPaymentView(viewmodel: CSApiViewModel())
    }
}
