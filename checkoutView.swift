//
//  checkoutView.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 4/1/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import shared

//struct checkoutView: View {
//    
//    @ObservedObject var viewmodel: CSApiViewModel
//    @State private var showSelectAddPage = false
//    @State var isShowAddScreen : Bool = false
//    @State var showCartDetailPage : Bool = false
//    @State var isLoading : Bool = false
//    @Binding var cartProductList: [ProductsItem]
//    @Environment(\.presentationMode) var presentationMode
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .leading, spacing: 16) {
//                //back bar button
//                HStack{
//                    Button(action: {
//                        // Handle back action
//                        presentationMode.wrappedValue.dismiss()
//                    }) {
//                        Image(systemName: "chevron.left")
//                            .font(.title2)
//                            .foregroundColor(.black)
//                    }
//                    .padding()
//                    .frame(width: 34, height: 34)
//                    .background(Color.white)
//                    .clipShape(RoundedRectangle(cornerRadius: 5))
//                    .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
//                }
//                .padding()
//                if (viewmodel.cartProductList?.count ?? 0) > 0 {
//                    ScrollView(.vertical, showsIndicators: false) {
//                        LazyVGrid(columns: [GridItem(.flexible())], spacing: 7) {
//                            ForEach(0..<(viewmodel.cartProductList?.count ?? 0), id: \.self) { item in
//                                HStack {
//                                    AsyncImage(url: URL(string: "\(viewmodel.cartProductList?[item].imageUrl ?? "")")) { image in
//                                        image.resizable()
//                                            .frame(width: 90, height: 90)
//                                            .clipped()
//                                            .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 0))
//                                    } placeholder: {
//                                        ProgressView()
//                                    }
//                                    
//                                    VStack(spacing: 3) {
//                                        Text(viewmodel.cartProductList?[item].name ?? "")
//                                            .padding(EdgeInsets(top: 5, leading: 4, bottom: 0, trailing: 4))
//                                            .foregroundColor(.black)
//                                            .font(.system(size: 15))
//                                            .fontWeight(.semibold)
//                                            .frame(maxWidth: .infinity, alignment: .leading)
//                                        
//                                        Text(viewmodel.cartProductList?[item].category ?? "")
//                                            .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
//                                            .font(.system(size: 13))
//                                            .foregroundColor(.gray)
//                                            .fontWeight(.regular)
//                                            .frame(maxWidth: .infinity, alignment: .leading)
//                                        
//                                        Text(viewmodel.cartProductList?[item].shortDescription ?? "")
//                                            .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
//                                            .foregroundColor(.black)
//                                            .fontWeight(.regular)
//                                            .font(.system(size: 13))
//                                            .frame(maxWidth: .infinity, maxHeight: 12, alignment: .leading)
//                                        VStack{
//                                            HStack {
//                                                let count = viewmodel.cartProductList?[item].itemPrice ?? 125
//                                                let quantity = viewmodel.cartProductList?[item].quantiy ?? 0
//                                                let prize: Int = Int(truncating: count) * Int(truncating: quantity)
//                                                
//                                                Text("\u{20B9}"+"\(prize)")
//                                                    .foregroundColor(.black)
//                                                    .fontWeight(.semibold)
//                                                    .font(.system(size: 14))
//                                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                                
//                                                StepperCartView(count: .constant(Int(truncating: quantity)), viewmodel: viewmodel, prodId: .constant(String(viewmodel.cartProductList?[item].productid ?? "")), isLoading: $isLoading, lineid: .constant(String(viewmodel.cartProductList?[item].lineId ?? "")), cartProductList: $cartProductList)
//                                                    .background(.thinMaterial)
//                                                    .cornerRadius(5)
//                                                    .frame(width: 150, alignment: .trailing)
//                                            }.padding(EdgeInsets(top: 0, leading: 4, bottom: 10, trailing: 10))
//                                            
//                                        }
//                                    }.padding(.top, 10)
//                                }
//                                .background(
//                                    Rectangle()
//                                        .fill(Color.white)
//                                        .cornerRadius(10)
//                                        .shadow(
//                                            color: Color.gray.opacity(0.2),
//                                            radius: 8,
//                                            x: 0,
//                                            y: 0
//                                        )
//                                )
//                                .padding(EdgeInsets(top: 5, leading: 16, bottom: 0, trailing: 16))
//                            }
//                        }
//                    }
//                    
//                    Spacer()
//                    selectAdd
//                } else {
//                    NavigationLink {
//                        EmptyCartView(viewmodel: viewmodel)
//                    } label: {
//                        EmptyCartView(viewmodel: viewmodel)
//                    }
//                }
//            Spacer()
//            }.sheet(isPresented: $showSelectAddPage) {
//                if #available(iOS 16.0, *) {
//                    SelectAddressScreen(isShowAddScreen: $isShowAddScreen, viewmodel: viewmodel, showSelectAddPage: $showSelectAddPage, showCartDetailPage: $showCartDetailPage)
//                        .presentationDetents([.height(400)])
//                }
//            }
//            .navigationDestination(isPresented: $showCartDetailPage) {
//                //CartDetailView(viewmodel: viewmodel, cartProductList: $cartProductList)
//                CartView(viewmodel: viewmodel, isShowBack: true)
//                    .navigationBarBackButtonHidden(true)
//            }
//            .navigationDestination(isPresented: $isShowAddScreen) {
//                AddressScreenView(viewmodel: viewmodel)
//            }
//            .overlay(
//                Group {
//                    if isLoading {
//                        Color.white.opacity(0.5)
//                            .blur(radius: 10)
//                            .edgesIgnoringSafeArea(.all)
//                        ProgressView()
//                            .progressViewStyle(CircularProgressViewStyle())
//                    }
//                }
//            )
//        }
//    }
//    
//    private var selectAdd: some View {
//        VStack {
//            Button {
//                showSelectAddPage = true
//            } label: {
//                Text("Select Address")
//                    .font(.title3)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .foregroundColor(.black)
//                    .background(Color(hex: 0x00d6be))
//                    .cornerRadius(10)
//            }.padding(16)
//        }
//    }
//}
//



//struct checkoutView: View {
//    
//    @ObservedObject var viewmodel: CSApiViewModel
//    @State var isloading : Bool = true
//    @Environment(\.presentationMode) var presentationMode
//    @State var quantity: Int = 0
//    @State var productid: String
//    @State private var showSelectAddPage = false
//    @State var isShowAddScreen : Bool = false
//    @State var showCartDetailPage : Bool = false
//    
//    var body: some View {
//        VStack{
//            // MARK: - Navigation Bar
//            HStack{
//                Button(action: {
//                    // Handle back action
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    Image(systemName: "chevron.left")
//                        .font(.title2)
//                        .foregroundColor(.black)
//                }
//                .padding()
//                .frame(width: 34, height: 34)
//                .background(Color.white)
//                .clipShape(RoundedRectangle(cornerRadius: 5))
//                .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
//                
//                CheckoutHeaderView()
//            }
//            .padding()
//            .background(Color.white)
//            
//            ScrollView {
//                VStack(spacing: 10) {
//                    if let cartItems = viewmodel.cartProductList, !cartItems.isEmpty {
//                        // MARK: - Cart Items
//                        VStack {
//                            ForEach(0..<(cartItems.count ?? 0), id: \.self) { item in
//                                CartItemView(
//                                    image: cartItems[item].imageUrl ?? "",
//                                    name: cartItems[item].name ?? "",
//                                    oldPrice: Int(cartItems[item].itemPrice ?? 0),
//                                    newPrice: Int(cartItems[item].discountedPrice ?? 0)
//                                )
//                            }
//                            
//                        }
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(10)
//                    }
//                }
//            }
//            
//            Spacer()
//            selectAdd
//        }
//        .sheet(isPresented: $showSelectAddPage) {
//            if #available(iOS 16.0, *) {
//                SelectAddressScreen(isShowAddScreen: $isShowAddScreen, viewmodel: viewmodel, showSelectAddPage: $showSelectAddPage, showCartDetailPage: $showCartDetailPage)
//                    .presentationDetents([.height(400)])
//            }
//        }
//        .navigationDestination(isPresented: $isShowAddScreen) {
//            AddressScreenView(viewmodel: viewmodel)
//        }
//        .overlay(
//            LoadingOverlay(isLoading: isloading)
//        )
//        .onAppear {
//            getCartDetails()
//        }
//    }
//    
//    func getCartDetails() {
//        let cartlist = ProductsToCartRequest(quantity: KotlinInt(int: Int32(quantity)), productId: productid, variantId: 1)
//        viewmodel.requestViewCart(addtocartrequest: [cartlist]) { result in
//            if result {
//                isloading = false
//            }
//        }
//    }
//    
//    private var selectAdd: some View {
//        VStack {
//            Button {
//                showSelectAddPage = true
//            } label: {
//                Text("Select Address")
//                    .font(.title3)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .foregroundColor(.black)
//                    .background(Color(hex: 0x00d6be))
//                    .cornerRadius(10)
//            }.padding(16)
//        }
//    }
//}

// MARK: - checkout Header view
struct CheckoutHeaderView: View {
    
    var body: some View {
        HStack {
            
            Text("Checkout")
                .font(.custom("Ubuntu-Bold", size: 20))
                .foregroundColor(.black)
            
            Spacer() // Pushes the icons to the right
            
            HStack(spacing: 16) {
                Button(action: {
                    // Handle wishlist action
                }) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    // Handle QR code action
                }) {
                    Image("Scan Product")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}


//struct checkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        checkoutView(viewmodel: CSApiViewModel(), productid: "")
//    }
//}
