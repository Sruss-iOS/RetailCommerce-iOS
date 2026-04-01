//
//  InputFieldView.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 3/5/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import shared

struct LoginModifier: ViewModifier {

    var borderColor: Color = Color.gray

    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }
}

struct SecureTextFieldWithReveal: View {
    
    @FocusState var focus1: Bool
    @FocusState var focus2: Bool
    @State var showPassword: Bool = true
    @Binding var text: String
    @State var titleStr: String = ""
    
    var body: some View {
        HStack {
            ZStack(alignment: .trailing) {
                SecureField(titleStr, text: $text)
                    .modifier(LoginModifier())
                    .textContentType(.password)
                    .focused($focus2)
                    .opacity(showPassword ? 1 : 0)
                TextField(titleStr, text: $text)
                    .modifier(LoginModifier())
                    .textContentType(.password)
                    .focused($focus1)
                    .opacity(showPassword ? 0 : 1)
                Button(action: {
                    showPassword.toggle()
                    if showPassword { focus1 = true } else { focus2 = true }
                }, label: {
                    Image(systemName: self.showPassword ? "eye.slash.fill" : "eye.fill").font(.system(size: 16, weight: .regular))
                        .foregroundColor(.secondary)
                        //.padding()
                })
            }
        }
    }
}

struct InputFieldView: View {
    @Binding var data: String
    var title: String?
    
    var body: some View {
        ZStack{
            TextField("Password", text: $data)
                .padding(.horizontal, 10)
                .frame(height: 42)
                .background(.thinMaterial)
                .cornerRadius(10)
            .padding(.leading, 8)
        }.padding(4)
    }
}

struct addButtonView: View {
    @Binding var isAddButtonVisible : Bool
    
    var body: some View {
        Button {
            isAddButtonVisible = false
        } label: {
            Text("Add")
                .frame(maxWidth: .infinity)
                .font(.system(size: 14))
                .foregroundColor(Color(hex: 0x00d6be))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                          .stroke(Color(hex: 0x00d6be), lineWidth: 1)
                    )
                .padding(.trailing, 5)
        }
        .frame(maxHeight: 45)
    }
}

struct StepperCartView: View {
    @Binding var count: Int
    @ObservedObject var viewmodel: CSApiViewModel
    @Binding var prodId: String
    @Binding var isLoading: Bool
    @Binding var lineid: String
    @Binding var cartProductList: [ProductsItem]

    var body: some View {
        VStack{
            HStack {
                Button {
                    if count > 0 {
                        count -= 1
                        isLoading = true
                        let removecartList = RemoveProductsRequestItem(quantity: 1, lineItemId: lineid)
                        self.viewmodel.removeCartProduct(removeRequest: [removecartList]){ result in
                            
                        }
                    }
                } label: {
                    Image(systemName: "minus")
                        .foregroundColor(.gray)
                }
                .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 5))
                
                Text("\(count)")
                    .foregroundColor(.gray)
                
                Button {
                    count += 1
                    isLoading = true
                    if let cartlist = viewmodel.cartProductList {
                        if let index = cartlist.firstIndex(where: { $0.productid == prodId }) {
                            let cartList = ProductsToCartRequest(quantity: 1, productId: prodId, variantId: 1, offerPrice: cartlist[index].discountedPrice ?? 0)
                            self.viewmodel.requestViewCart(addtocartrequest: [cartList]){ result in
                                if result{ isLoading = false}}
                        }
                    }
                    
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.gray)
                }
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 2))
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
//            .onChange(of: viewmodel.viewCartValidate) { viewCartValidate in
//                if viewCartValidate {
//                    isLoading = false
//                }
//            }
        }
    }
}

struct InputFieldView_Previews: PreviewProvider {
    @State static var data: String = ""
    
    static var previews: some View {
        InputFieldView(data: $data, title: "Password")
    }
}

