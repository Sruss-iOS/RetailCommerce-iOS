//
//  CartDetailView.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 4/9/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import shared
import NukeUI
import FirebaseAnalytics

struct PaymentView: View {
    @StateObject var paymentHandler = PaymentHandler()
    @ObservedObject var viewmodel: CSApiViewModel
    let totalPrice: Double
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                HStack {
                    Text("Total:")
                        .font(.custom("Ubuntu-Regular", size: 18))
                        .frame(alignment: .leading)
                    Text("₹\(String(format: "%.2f", totalPrice))")
                        .font(.custom("Ubuntu-Bold", size: 22))
                }
                
                Text("(Incl. of all taxes)")
                    .font(.custom("Ubuntu-Regular", size: 14))
            }
            Spacer()
            Button(action: {
                // firebase events logBeginCheckoutEvent
                
                // Handle payment action
                paymentHandler.startPayment(price: Int(truncating: totalPrice as NSNumber))
            }) {
                Text("Pay Now")
                    .font(.custom("Ubuntu-Medium", size: 18))
                    .foregroundColor(.white)
                    .frame(maxWidth: 165, minHeight: 44)
                    .background(Color(red: 0/255, green: 87/255, blue: 171/255))
                    .cornerRadius(5)
            }
        }
        .padding()
        .background(Color.white)
        NavigationLink(destination: PaymentDoneView(viewmodel: viewmodel, paymentHandler: paymentHandler).navigationBarBackButtonHidden(true), isActive: $paymentHandler.isPaymentSuccessful) {
        }
        NavigationLink(destination: PaymentFail(viewmodel: viewmodel, paymentHandler: paymentHandler).navigationBarBackButtonHidden(true), isActive: $paymentHandler.isPaymentFail) {
        }
    }
}

struct LoadingViewWithBackground: View {
    let isLoading: Bool
    var body: some View {
        if isLoading {
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2) // Bigger loader
                    .tint(
                        Color(red: 0/255, green: 112/255, blue: 173/255)
//                        Color(
//                            red: 207 / 255.0,
//                            green: 118 / 255.0,
//                            blue: 27 / 255.0,
//                            opacity: 1.0
//                        )
)
//                Text("Loading...")
//                    .font(.custom("Ubuntu-Regular", size: 18))
//                    .padding(.top, 10)
//                    .frame(width: 100)
            }
        }
    }
}

struct LoadingOverlay: View {
    let isLoading: Bool

    var body: some View {
        if isLoading {
            ZStack {
                Color.white.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2) // Bigger loader
                    .tint(
                        Color(red: 0/255, green: 112/255, blue: 173/255)
//                        Color(
//                            red: 207 / 255.0,
//                            green: 118 / 255.0,
//                            blue: 27 / 255.0,
//                            opacity: 1.0
//                        )
)
                   
            }
        } else {
            EmptyView()
        }
    }
}


// MARK: - cart Header view
struct CartHeaderView: View {
    @State var isShowBack: Bool
    @ObservedObject var viewmodel: CSApiViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
//            if isShowBack {
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    Image("Arrows")
//                        .resizable()
//                        .frame(width: 26, height: 28) // Keep the heart small
//                        .scaledToFit()
//                        .padding(6)
//                        .foregroundColor(.black)
//                        .background(Color.white)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
//                }
//            }
            Text("Cart")
                .font(.custom("Ubuntu-Medium", size: 22))
                .foregroundColor(.black)
                .padding(.leading, 5)
            
            Spacer() // Pushes the icons to the right
            
            HStack(spacing: 16) {
                NavigationLink(destination: WishlistView(viewmodel: viewmodel, isLoading: true, isShowBack: true, isActive: $isShowBack)) {
//                    Image("CS - Favroites")
//                        .resizable()
//                        .frame(width: 30, height: 30) // Keep the heart small
//                        .scaledToFit()
//                        .padding(8)
//                        .foregroundColor(.red)
//                        .background(Color.white)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                        .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
                    ImgView(imgName: "Add To Wishlist", width: 50)
                        .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
                }

                Button(action: {
                    // Handle QR code action
                }) {
//                    Image("Scan Product")
//                        .foregroundColor(.blue)
                    ImgView(imgName: "Scan Product 1", width: 50)
                }
            }
        }
        
        
    }
}

struct CartHeader1View: View {
    @State private var showWishlist = false
    @Environment(\.presentationMode) var presentationMode
    @State var isShowBack: Bool
    @ObservedObject var viewmodel: CSApiViewModel
    @State private var selectedTab = 0
    @State private var navigateToScanner = false
    
    var body: some View {
        HStack {
            if isShowBack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image("Arrows")
                        .resizable()
                        .frame(width: 26, height: 28) // Keep the heart small
                        .scaledToFit()
                        .padding(6)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                }
            }
            Text("Cart")
                .font(.custom("Ubuntu-Medium", size: 22))
                .foregroundColor(.black)
                .padding(.leading, 5)
            
            Spacer() // Pushes the icons to the right
            
            HStack(spacing: 16) {
//                NavigationLink(destination: WishlistView(viewmodel: viewmodel, isLoading: true, isShowBack: true, isActive: $isShowBack)) {
//                    Image("CS - Favroites")
//                        .resizable()
//                        .frame(width: 26, height: 24) // Keep the heart small
//                        .scaledToFit()
//                        .padding(8)
//                        .foregroundColor(.red)
//                        .background(Color.white)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
//                }

//                Button(action: {
//                    // Handle wishlist action
//                    showWishlist = true
//                }) {
//                    Image("CS - Favroites")
//                        .resizable()
//                        .frame(width: 26, height: 24) // Keep the heart small
//                        .scaledToFit()
//                        .padding(8)
//                        .foregroundColor(.red)
//                        .background(Color.white)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
//                    
//                }
//                
//                NavigationLink(
//                                            destination: WishlistView(
//                                                viewmodel: viewmodel,
//                                                isLoading: false,
//                                                selectedTab: selectedTab,
//                                                isShowBack: true,
//                                                isActive: $showWishlist
//                                            ),
//                                            isActive: $showWishlist,
//                                            label: { EmptyView() }
//                                        )
                Button(action: {
                    print("Initializing scanner...")
                    navigateToScanner = true
                }) {
                    ImgView(imgName: "Scan Product 1", width: 50)
                        .shadow(color: Color(red: 0.19, green: 0.19, blue: 0.19).opacity(0.15), radius: 2.5, x: 1, y: 2)
                }
                
                // Hidden NavigationLink for Scanner
                NavigationLink(
                    destination: CamerasView()
                        .edgesIgnoringSafeArea(.all),
                    isActive: $navigateToScanner,
                    label: { EmptyView() }
                )
                
            }
        }
        
        
    }
}


// MARK: - Cart Item Component
struct CartItemView: View {
    let image: String
    let name: String
    let shortDesc: String
    let oldPrice: Double
    let newPrice: Double
    let productID : String
    @Binding var selectedQuantity: Int
    @ObservedObject var viewmodel: CSApiViewModel
    var onUpdate: () -> Void
    @State var isLoading : Bool = false
    
    var body: some View {
        HStack {
                     
           AsyncImage(url: URL(string: image)) { phase in
               switch phase {
               case .empty:
                   ProgressView() // Show loading indicator
               case .success(let image):
                   image
                       .resizable()
                       .scaledToFit()
                       .frame(width: 80, height: 80)
                       .cornerRadius(8)
               case .failure:
                   Image(systemName: "photo") // Placeholder image
                       .resizable()
                       .scaledToFit()
                       .frame(width: 80, height: 80)
                       .cornerRadius(8)
               @unknown default:
                   EmptyView()
                       
               }
           }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(.custom("Ubuntu-Medium", size: 12))
                    .lineLimit(1)
                Text("\(shortDesc)")
                    .font(.custom("Ubuntu-Regular", size: 12))
                HStack(spacing: 5) {
                    
                    Text("₹ \(String(format: "%.2f", oldPrice))")
                        .font(.custom("Ubuntu-Regular", size: 12))
                        .strikethrough()
                        .foregroundColor(.red)
                    Text("\(String(format: "%.2f", newPrice))")
                        .font(.custom("Ubuntu-Regular", size: 12))
                }
            }
            .padding(.leading, 3)
            
            Spacer()
            
            // Quantity Selector
            QuantityStepView(quantity: $selectedQuantity , isShowAddtoCart: $isLoading){ newQuantity, isAdding  in
                isLoading = true
                if isAdding {
                    if let cartList = viewmodel.cartProductList {
                        if let index = cartList.firstIndex(where: { $0.productid == productID }) {
                            let cartlist = ProductsToCartRequest(quantity: KotlinInt(int: 1), productId: productID, variantId: 1, offerPrice: cartList[index].discountedPrice ?? 0)
                            viewmodel.requestViewCart(addtocartrequest: [cartlist]) { result in
                                if result {
                                    isLoading = false
                                    FirebaseEvents().logViewCartEvent(productId: productID, productName: name, category: "grocery", subcategory: "grocery", currency: "INR", price: CGFloat(newPrice), quantity: 1, priceBeforeDiscount: CGFloat(oldPrice), discountPercentage: 25, stock: 2, variantId: 2, variantSku: "2")
                                }
                            }
                        }
                    }
                    
                } else {
                    isLoading = true
                    if let cartList = viewmodel.cartProductList {
                        if let index = cartList.firstIndex(where: { $0.productid == productID }) {
                            let lineid = cartList[index].lineId ?? ""
                            let removecartList = RemoveProductsRequestItem(quantity: 1, lineItemId: lineid)
                            viewmodel.removeCartProduct(removeRequest: [removecartList]) { result in
                                if result {
//                                    FirebaseEvents().logRemoveFromCartEvent(productId: productID, productName: name, category: "grocery", subcategory: "grocery", price: CGFloat(newPrice), priceBeforeDiscount: CGFloat(oldPrice), discountPercentage: 25, stock: 2, variantId: 2, variantSku: "2")
                                    isLoading = false
                                    if selectedQuantity > 1 {
                                        selectedQuantity -= 1
                                    } else {
                                        
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
            Button(action: {
                isLoading = true
                if let cartList = viewmodel.cartProductList {
                    if let index = cartList.firstIndex(where: { $0.productid == productID }) {
                        let lineid = cartList[index].lineId ?? ""
                        let quantity = cartList[index].quantiy ?? 0
                        let removeCartItem = RemoveProductsRequestItem(quantity: quantity, lineItemId: lineid)
                        viewmodel.removeCartProduct(removeRequest: [removeCartItem]) { result in
                            if result {
                                isLoading = false
                                selectedQuantity = 0 // Optional: reset quantity
                            }
                            else {
                                                isLoading = false
                                            }
                        }
                    } else {
                        isLoading = false
                    }
                } else {
                    isLoading = false
                }
            }) {
                Image("Vector")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.leading, 3)
            }

            
        }
        .frame(height: 80, alignment: .center)
        .background(Color.white)
    }
}

// MARK: - Order Summary Row
struct OrderRowView: View {
    var item: String
    var price: String
    
    var body: some View {
        HStack {
            Text(item)
                .font(.custom("Ubuntu-Regular", size: 12))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Text(price)
                .font(.custom("Ubuntu-Medium", size: 12))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
        }
    }
}


// MARK: - Sustainability Points View
import SwiftUI

struct SustainabilityPointsView: View {
    let cartList: [ProductsItem]

    var totalPoints: Int {
        cartList.count * 10 // Assuming 10 points per product
    }
    
    var body: some View {
        ZStack() {
            Image("Sustainibility points background")
                .scaledToFill()
                .ignoresSafeArea()
                .clipped()

            VStack(alignment: .leading, spacing: 8) {
                Text("Sustainability Points")
                    .font(.custom("Ubuntu-Bold", size: 18))

                ForEach(cartList.indices, id: \.self) { index in
                    HStack {
                        Text(cartList[index].name ?? "Unknown")
                            .font(.custom("Ubuntu-Regular", size: 16))
                            .lineLimit(1)
                        Spacer()
                        Text("\(10) points") // Replace with actual calculation
                            .font(.custom("Ubuntu-Regular", size: 16))
                    }
                }
                
                Divider()
                
                HStack {
                    Text("Total Points")
                        .font(.custom("Ubuntu-Regular", size: 18))
                    Spacer()
                    Text("\(totalPoints) Points")
                        .font(.custom("Ubuntu-Regular", size: 18))
                }
                
                HStack {
                    Spacer()
                    Text("Redeem it Now +")
                        .font(.custom("Ubuntu-Regular", size: 14))
                        .underline()
                        .foregroundColor(Color(hex: 0x0070ad))
                }
            }
            .padding(12)
            .cornerRadius(10)
        }
        .cornerRadius(10)
    }
}

struct SustainabilityPointsViewNew: View {
    let cartList: [ProductsItem]
    var totalPoints: Int {
        cartList.count * 10 // 10 points per product
    }
   @State var isClicked: Bool = false

    
    var body: some View {
        ZStack {
            Image("Sustainibilitybackground")
                .resizable()
                .frame(height: 90)
            
            HStack(alignment: .center, spacing: 12) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Sustainability Points")
                        .font(.custom("Ubuntu-Bold", size: 15))
                        .foregroundColor(.black)
                    
                    Text("(Total \(totalPoints) Points)")
                        .font(.custom("Ubuntu-Regular", size: 12))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Button(action: {
                    isClicked = true
                }) {
                    if (!isClicked) {
                        Text("Redeem Now")
                            .font(.custom("Ubuntu-Medium", size: 12))
                            .foregroundColor(Color(red: 0, green: 0.44, blue: 0.68))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .frame(width: 130, height: 50, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 0, green: 0.44, blue: 0.68), lineWidth: 1))
                    } else {
                        HStack {
                            Text("Redeemed")
                                .font(.custom("Ubuntu-Medium", size: 12))
                                .foregroundColor(Color(red: 0, green: 0.44, blue: 0.68))
                            Image("Vector 1")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .padding(4)
                                .overlay(Circle().stroke(Color(red: 0, green: 0.44, blue: 0.68), lineWidth: 1))
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .frame(width: 130, height: 50, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 0, green: 0.44, blue: 0.68), lineWidth: 1))
                    }
                }
            }
            .padding()
            .background(Color.clear) // Optional overlay
        }
    }
}




struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewmodel: CSApiViewModel(), isShowBack: false)
    }
}

struct CartView: View {
    @ObservedObject var viewmodel: CSApiViewModel
    @State var isloading : Bool = false
    @State var isShowBack: Bool
    @Environment(\.presentationMode) var presentationMode
    @State var isShowPaymentScreen: Bool = false
    @State var isRedeemed: Bool = false
    @State var isClicked: Bool = false
    @State private var refreshTrigger = UUID()
    
    var body: some View {
        VStack {
            // MARK: - Navigation Bar
            HStack {
                if let cartItems = viewmodel.cartProductList, !cartItems.isEmpty {
                    if isShowBack { // when coming from product detail page
                        CartHeader1View(isShowBack: true, viewmodel: viewmodel)
                    } else{ // when clicked on cart button on custom tab bar
                        CartHeaderView(isShowBack: true, viewmodel: viewmodel)
                    }
                    
                } else {
                    if !isloading {
                        EmptyCartView()
                    }
                }
            }
            .padding()
            .background(Color.white)
            var totalPrice = isRedeemed ? Double(viewmodel.redeemcartDetails?.totalDiscountedPrice ?? 0) : Double(viewmodel.cartList?.totalDiscountedPrice ?? 0)
            ZStack {
                ScrollView {
                    VStack(spacing: 10) {
                        if let cartItems = viewmodel.cartProductList, !cartItems.isEmpty {
                            // MARK: - Cart Items
                            VStack(spacing: 10) {
                                ForEach(0..<(cartItems.count), id: \.self) { item in
                                    let count = cartItems[item].quantiy ?? 0
                                    CartItemView(image: cartItems[item].imageUrl ?? "", name: cartItems[item].name ?? "", shortDesc: cartItems[item].shortDescription ?? "", oldPrice: Double(cartItems[item].itemPrice ?? 0), newPrice: Double(cartItems[item].discountedPrice ?? 0), productID: cartItems[item].productid ?? "", selectedQuantity: .constant(Int(count)), viewmodel: viewmodel, onUpdate: {
                                        refreshTrigger = UUID()
                                    })
                                    
                                }
                            }
//                            Analytics.logEvent("view_cart", parameters: nil )
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(10)
                            
                            // MARK: - Order Summary
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Order Summary")
                                    .font(.custom("Ubuntu-Bold", size: 15))
                                
                                OrderRowView(item: "Price", price: "\u{20B9}"+"\(String(format: "%.2f",Double(viewmodel.cartList?.totalPriceWithoutTax ?? 0)))")
                                OrderRowView(item: "Discount", price: "- \u{20B9}"+"\(String(format: "%.2f",Double(viewmodel.cartList?.totalDiscount ?? 0)))")
                                if (isRedeemed) {
                                    OrderRowView(item: "Redeemed Points", price: "- \u{20B9}"+"\(String(format: "%.2f", Double(viewmodel.redeemcartDetails?.redeemedPoints ?? 0)))")
                                }
                                OrderRowView(item: "Total Tax", price: "\u{20B9}"+"\(String(format: "%.2f", Double(viewmodel.cartList?.totalTax ?? 0)))")
                                
                                Divider()
                                
                                HStack {
                                    Text("Total Amount")
                                        .font(.custom("Ubuntu-Medium", size: 15))
                                    Spacer()
                                    Text("₹ \(String(format: "%.2f", totalPrice))")
                                        .font(.custom("Ubuntu-Medium", size: 15))
                                }
                                HStack {
                                    Spacer()
                                    Text("You have saved ₹ \(viewmodel.cartList?.totalDiscount ?? 0)")
                                        .font(.custom("Ubuntu-Regular", size: 10))
                                        .foregroundColor(Color(hex: 0x30b400))
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                // MARK: - Sustainability Points
                                ZStack {
                                    Image("Sustainibilitybackground")
                                        .resizable()
                                        .frame(height: 90)
                                    
                                    HStack(alignment: .center, spacing: 8) {
//                                        Image("Frame 1410125647")
//                                            .resizable()
//                                            .frame(width: 40, height: 40)
                                        
                                        VStack(alignment: .leading) {
                                            Text("Sustainability Points")
                                                .font(.custom("Ubuntu-Bold", size: 15))
                                                .foregroundColor(.black)
                                            
                                            if (isRedeemed) {
                                                Text("(Total 0 Points)")
                                                    .font(.custom("Ubuntu-Regular", size: 12))
                                                    .foregroundColor(.black)
                                            } else {
                                                Text("(Total \(viewmodel.redeemcartDetails?.redeemedPoints ?? 0) Points)")
                                                    .font(.custom("Ubuntu-Regular", size: 12))
                                                    .foregroundColor(.black)
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            isClicked = true
                                            isRedeemed = true
                                        }) {
                                            if (!isClicked) {
                                                Text("Redeem Now")
                                                    .font(.custom("Ubuntu-Medium", size: 12))
                                                    .foregroundColor(Color(red: 0/255, green: 87/255, blue: 171/255))
                                            } else {
                                                HStack {
                                                    Text("Redeemed")
                                                        .font(.custom("Ubuntu-Medium", size: 12))
                                                        .foregroundColor(Color(red: 0/255, green: 87/255, blue: 171/255))
                                                    Image("Vector 1")
                                                        .resizable()
                                                        .frame(width: 10, height: 10)
                                                        .padding(4)
                                                        .overlay(Circle().stroke(Color(red: 0/255, green: 87/255, blue: 171/255), lineWidth: 2))
                                                }
                                            }
                                        }
                                        .frame(width: 100, height: 40, alignment: .center)
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(red: 0/255, green: 87/255, blue: 171/255), lineWidth: 1))
                                    }
                                    .padding()
                                    .background(Color.clear)
                                }
//                                .padding()
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
            
            if let cartItems = viewmodel.cartProductList, !cartItems.isEmpty {
                // MARK: - Payment Section
                PaymentView(viewmodel: viewmodel, totalPrice: Double(totalPrice))
            }
        }
        .navigationBarBackButtonHidden(true)
        .overlay(
            LoadingViewWithBackground(isLoading: isloading)
        )
        .background(
            (viewmodel.cartProductList?.isEmpty == false) ? Color(UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1))
            : Color.white
        )
        .onAppear {
            isloading = true
            viewmodel.getCart { success in
//                refreshTrigger.toggle()
                print("Cart loaded: \(success), count: \(viewmodel.cartProductList?.count ?? 0)")
            }
            viewmodel.redeemPoints { success in
                print("redeem details: \(success), \(viewmodel.redeemcartDetails)")
            }
            viewmodel.saveAddress(streetName: "GreenVilla", apartment: "HappyHome", city: "Hyderdabad", countryCode: "IN") { result in
                DispatchQueue.main.async {
                    isloading = !result
                }
            }
        }
    }
}

