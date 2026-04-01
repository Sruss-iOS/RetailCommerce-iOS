//
//  OrderSummeryView.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 4/24/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct OrderSummeryView: View {
    
    @ObservedObject var viewmodel: CSApiViewModel
    @Environment(\.dismiss) private var dismiss
    @State var isShowHome: Bool = false
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                orderView
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 7) {
                    ForEach(0..<(viewmodel.cartProductList?.count ?? 3), id: \.self) { item in
                        HStack {
                            AsyncImage(url: URL(string: "\(viewmodel.cartProductList?[item].imageUrl ?? "")")){ image in
                                image.resizable()
                                    .frame(width: 90, height: 90)
                                    .clipped()
                                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 0))
                            } placeholder: {
                                ProgressView()
                            }
                            
                            VStack {
                                Text(viewmodel.cartProductList?[item].name ?? "Red bull Energy Drink")
                                    .padding(EdgeInsets(top: 5, leading: 4, bottom: 0, trailing: 4))
                                    .foregroundColor(.black)
                                    .font(.system(size: 14))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text(viewmodel.cartProductList?[item].category ?? "Energy Drink")
                                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                    .fontWeight(.thin)
                                    .font(.system(size: 12))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                HStack {
                                    Text("\(viewmodel.cartProductList?[item].shortDescription ?? "200ml") X \(viewmodel.cartProductList?[item].quantiy ?? 1)")
                                        .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                        .fontWeight(.thin)
                                        .font(.system(size: 11))
                                        .frame(maxWidth: .infinity, maxHeight: 12, alignment: .leading)
                                    let count = viewmodel.cartProductList?[item].itemPrice ?? 125
                                    let quantity = viewmodel.cartProductList?[item].quantiy ?? 0
                                    let prize: Int = Int(truncating: count) * Int(truncating: quantity)
                                    Text("\u{20B9}"+"\(prize)")
                                        .foregroundColor(.black)
                                        .font(.system(size: 14))
                                        .frame(alignment: .trailing)
                                }.padding(EdgeInsets(top: 2, leading: 4, bottom: 10, trailing: 10))
                            }
                        }
                        .background(
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(10)
                                .shadow(
                                    color: Color.gray.opacity(0.2),
                                    radius: 8,
                                    x: 0,
                                    y: 0
                                )
                        )
                        .padding(EdgeInsets(top: 5, leading: 16, bottom: 0, trailing: 16))
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("Total Summary")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    HStack {
                        Text("Item Total")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                        
                        Text("\u{20B9}"+"\(viewmodel.cartList?.totalPrice ?? 0)")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("Delivery Partner Fee")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                        
                        Text("\u{20B9}"+"\(viewmodel.cartList?.totalDiscountedPrice ?? 0)")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("Discount")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                        
                        Text("Free Delivery")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 16, bottom: 0, trailing: 16))
                
                VStack {
                    Divider()
                    
                    HStack {
                        Text("Grand Total")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                        
                        Text("\u{20B9}"+"\(viewmodel.cartList?.totalPrice ?? 0)")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    Text("Disclaimer -")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                    
                    Text("This is only a summary of the items purchased by you. For detailed tax invoice, please refer to this link")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                }
                .padding(EdgeInsets(top: 5, leading: 16, bottom: 0, trailing: 16))
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $isShowHome) {
            
            CustomTabView(viewmodel: viewmodel)
        }
        .navigationTitle("Order Summary")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    isLoading = true
                    viewmodel.getHomeDetails { result in
                        if result {
                            isLoading = false
                            isShowHome = true
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Home")
                    }
                }
            }
        }
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
    
    
    private var orderView: some View {
        VStack {
            VStack {
                Image("applogosmall")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer(minLength: 10)
                
                Text("Greetings from Cornershop 👋")
                    .fontWeight(.medium)
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer(minLength: 15)
                
                Text("Your order ID: \(viewmodel.cartSummaryList?.id ?? "") \n was successfully delivered.")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer(minLength: 10)
            
            VStack {
                Text("Bill No: ")
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer(minLength: 10)
            
            VStack {
                Text("Deliver to: ")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(viewmodel.shippingAddress?.streetName ?? ""), \(viewmodel.shippingAddress?.apartment ?? ""), \(viewmodel.shippingAddress?.city ?? ""), \(viewmodel.shippingAddress?.country ?? "")")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer(minLength: 20)
                
                Text("\(viewmodel.cartProductList?.count ?? 0) items in this order")
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(16)
    }
    
}

struct OrderSummeryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSummeryView(viewmodel: CSApiViewModel())
    }
}
