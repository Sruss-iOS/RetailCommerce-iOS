//
//  WelcomeView.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 3/5/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    
    @State var username : String = ""
    @State var isPresented : Bool = false
    @EnvironmentObject var vm: UserAuthModel
    @ObservedObject var viewmodel: CSApiViewModel
    @ObservedObject var rootmodel: rootViewModel
    @State var isShowForgetPasswordScreen : Bool = false
    @State var isShowCreateAccScreen : Bool = false
    @State var isShowLandingScreen : Bool = false
    @State var showAlert : Bool = false
    @State var isLoading : Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("cornershopimg")
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 24)
                
                VStack {
                    Text("Welcome!")
                        .font(Font.custom("SFPro-Bold", size: 32))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 40)
                    
                    Text("Sign in or create account")
                        .font(Font.custom("SFPro-Semibold", size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack {
                    TextField("Enter mobile number or email", text: $username)
                        .font(Font.custom("SFPro-Regular", size: 17))
                        .textInputAutocapitalization(.never)
                        .padding(.horizontal, 10)
                        .frame(height: 42)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                }
                .padding(.top, 16)
                
                VStack {
                    Button {
                        isShowForgetPasswordScreen = true
                    } label: {
                        Text("Forgot password?")
                            .font(Font.custom("SFPro-Regular", size: 15))
                            .foregroundColor(Color(hex: 0x007aff))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 10)
                    }
                }
                .padding(.top, 16)
                
                Button {
                    if username == "" {
                        showAlert = true
                    } else {
                        isPresented = true
                    }
                } label: {
                    Text("Sign In")
                        .font(Font.custom("SFPro-Regular", size: 17))
                        .frame(maxWidth: .infinity, minHeight: 50.0)
                        .foregroundColor(.black)
                        .background(Color(hex: 0x00d6be))
                        .cornerRadius(10)
                }
                .padding(.top, 16)
                
                LabelledDivider(label: "Or")
                    .padding(.top, 16)
                
                Button {
                    vm.signIn()
                } label: {
                    HStack{
                        Image("googleImg")
                        Text("Sign in with Google")
                            .foregroundColor(.black)
                            .font(Font.custom("SFPro-Regular", size: 15))
                    }
                    .frame(maxWidth: .infinity, minHeight: 50.0)
                    .background(Color(hex: 0xF2F2F2))
                    .cornerRadius(10)
                }
                .padding(.top, 16)
                
                Spacer()
                
                Text("If you don't have an account with CornerShop")
                    .font(Font.custom("SFPro-Regular", size: 16))
                    .padding(.bottom, 10)
                
                Button {
                    isShowCreateAccScreen = true
                } label: {
                    Text("Create new account")
                        .font(Font.custom("SFPro-Regular", size: 17))
                        .foregroundColor(Color(hex: 0x007aff))
                }
            }
            .padding(.all, 16)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isShowForgetPasswordScreen) {
                ForgotPassword(isShowForgetPasswordScreen: $isShowForgetPasswordScreen, viewmodel: viewmodel)
            }
            .navigationDestination(isPresented: $isPresented) {
                LoginScreenView(username: $username, viewmodel: CSApiViewModel())
            }
            .navigationDestination(isPresented: $isShowLandingScreen) {
                //HomeScreenView(viewmodel: rootmodel.csviewmodel)
                //CustomTabView(path: $)
            }
            .navigationDestination(isPresented: $isShowCreateAccScreen) {
                //CreateNewAccView(viewmodel: CSApiViewModel(), rootmodel: RootViewModel())
            }
            // Temp commented by MD
//            .onChange(of: vm.isLoggedIn){ isLoggedIn in
//                if isLoggedIn {
//                    isLoading = true
//                    viewmodel.googleLoginValidate = false
//                    viewmodel.showAlert = false
//                    rootmodel.checklogin(username: vm.givenName, email: vm.email)
//                }
//            }
            .onChange(of: rootmodel.csviewmodel.homeScreenValidate){ loginValidate in
                if loginValidate {
                    isLoading = false
                    rootmodel.csviewmodel.getCookieValue(page: "Register")
                    isShowLandingScreen = true
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Please enter valid email id"),
                    primaryButton: .default(Text("OK")) {
                        // Action to perform when the user taps the primary button
                    }, secondaryButton: .cancel()
                )
            }
            .onAppear(){
                
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
        }
    }
}

struct LabelledDivider: View {

    let label: String
    let horizontalPadding: CGFloat
    let color: Color

    init(label: String, horizontalPadding: CGFloat = 2, color: Color = .black) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }

    var body: some View {
        HStack {
            line
            Text(label).foregroundColor(color).padding(5)
            line
        }
    }

    var line: some View {
        VStack { Divider().background(color) }.padding(horizontalPadding)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(viewmodel: CSApiViewModel(), rootmodel: rootViewModel())
    }
}
