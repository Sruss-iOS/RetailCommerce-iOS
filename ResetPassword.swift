//
//  ResetPassword.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 3/7/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct ResetPassword: View {
    
    @State var pass : String = ""
    @State var confirmPass : String = ""
    @State private var showAlert = false
    
    @ObservedObject var viewmodel: CSApiViewModel
    @Binding var email: String
    @State var isShowSuccessSccreen: Bool = false
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack {
            Image("cornershopimg")
                .aspectRatio(contentMode: .fit)
                .padding(.top, 40)
            
            VStack{
                Text("Reset Password")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 30)
                
                Text("Set the new password for your account so you can login and access all the features.")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.padding(16)
            
            VStack{
                //TextField("Password", text: $pass)
                SecureTextFieldWithReveal(text: $pass, titleStr: "Password")
                    .padding(.horizontal, 10)
                    .frame(height: 42)
                    .background(.thinMaterial)
                    .cornerRadius(10)
                //TextField("Confirm Password", text: $confirmPass)
                SecureTextFieldWithReveal(text: $confirmPass, titleStr: "Confirm Password")
                    .padding(.horizontal, 10)
                    .frame(height: 42)
                    .background(.thinMaterial)
                    .cornerRadius(10)
            }.padding(16)
            
            Button {
                isLoading = true
                //viewmodel.resetPassword(email: email, newPassword: confirmPass, password: pass)
            } label: {
                Text("Reset Password")
                .font(.title3)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(Color(hex: 0x00d6be))
                .cornerRadius(10)
            }.padding(16)
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $isShowSuccessSccreen) {
            SuccessScreen()
        }
        .onChange(of: viewmodel.passValidate) { loginValidate in
            if loginValidate {
                self.isLoading = false
                isShowSuccessSccreen = true
            }
        }
        .onChange(of: viewmodel.showAlert) { showAlert in
            if showAlert {
                self.isLoading = false
                self.showAlert = true
                self.isShowSuccessSccreen = false
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
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(viewmodel.loginfailureData?.message ?? "Password did not match, please enter correct password"),
                primaryButton: .default(Text("OK")) {
                    // Action to perform when the user taps the primary button
                }, secondaryButton: .cancel()
            )
        }
    }
}

struct CreateNewPassword_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPassword(viewmodel: CSApiViewModel(), email: .constant(""))
    }
}

struct CreateNewPassword: View {
    
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewmodel: CSApiViewModel
    @Binding var email: String
    @State var isShowSuccessSccreen: Bool = false
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 16) {
                //custom nav bar
                CustomNavBar(title: "Create New Password"){
                    presentationMode.wrappedValue.dismiss() // Go back
                }
                
                Text("Please enter and confirm your new password. You will need to login after you reset.")
                    .font(.custom("Ubuntu-Medium", size: 14))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                
                UnderlinedSecureField(placeholder: "Enter your Password", title: "Password", text: $password, isVisible: $isPasswordVisible)
                UnderlinedSecureField(placeholder: "Re-enter your New Password", title: "Confirm Password", text: $confirmPassword, isVisible: $isConfirmPasswordVisible)
                
                
                Spacer()
                
                Button(action: {
                    resetpass()
                }) {
                    Text("Reset Password")
                        .font(.custom("Ubuntu-Regular", size: 16))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: 0x0070ad))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.bottom, 40)
            }
            .padding()
            .navigationDestination(isPresented: $isShowSuccessSccreen) {
                SuccessScreen()
            }
        }
    }
    
    func resetpass(){
        isLoading = true
        viewmodel.resetPassword(email: email, newPassword: password, password: confirmPassword){ success in
            if success{
                self.isLoading = false
                isShowSuccessSccreen = true
            }
        }
    }
}
