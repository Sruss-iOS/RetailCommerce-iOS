//
//  ProfileView.swift
//  iosApp
//
//  Created by Srushti Choudhari on 16/09/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewmodel: CSApiViewModel
    let customerName = UserDefaults.standard.string(forKey: "googlUsername") ?? "Guest"
    let customerEmail = UserDefaults.standard.string(forKey: "googleEmail") ?? "Null"
    let customerPhone = UserDefaults.standard.string(forKey: "googlePhone") ?? "Null"
    @State private var selectedTab = 0
    @EnvironmentObject var userAuth: UserAuthModel
//    @EnvironmentObject var rootmodel: rootViewModel
    @State private var showLogoutAlert = false
    @State private var navigateToHome = false
    @State private var showWishlist = false
    
    var body: some View {
//        NavigationView {
        VStack {
            // MARK: - Navigation Bar
            HStack {
                ProfileHeaderView(isShowBack: true, isLoading: true, viewmodel: viewmodel)
            }
            .padding()
            .background(Color.white)
            
            
            ZStack {
                ScrollView {
                    VStack(spacing: 10) {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 54, height: 50)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(self.customerName)
                                    .font(.custom("Ubuntu-Bold", size: 20))
                                    .foregroundColor(Color(hex: 0x0070ad))
                                Text(self.customerEmail)
                                    .font(.custom("Ubuntu-Regular", size: 12))
                                    .foregroundColor(.gray)
                                Text(self.customerPhone)
                                    .font(.custom("Ubuntu-Regular", size: 12))
                                    .foregroundColor(.gray)
                            }
                            .padding(.leading, 5)
                            
                            Spacer()
                            Image("CS - Customise")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .scaledToFit()
                                .padding(8)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        
                        HStack {
                            Spacer()
//                            NavigationLink(destination: WishlistView(viewmodel: viewmodel, isLoading: false, selectedTab: selectedTab, isShowBack: true)) {
//                                VStack {
//                                    Image("CS - list")
//                                        .resizable()
//                                        .frame(width: 34, height: 34)
//                                        .scaledToFit()
//                                        .padding(5)
//                                    
//                                    Text("My Lists")
//                                        .font(.custom("Ubuntu-Bold", size: 12))
//                                        .foregroundColor(Color(hex: 0x0070ad))
//                                }
//                            }
                            Button(action: {
                                showWishlist = true
                            }) {
                                VStack {
                                    Image("CS - list")
                                        .resizable()
                                        .frame(width: 34, height: 34)
                                        .scaledToFit()
                                        .padding(5)

                                    Text("My Lists")
                                        .font(.custom("Ubuntu-Bold", size: 12))
                                        .foregroundColor(Color(hex: 0x0070ad))
                                }
                            }

                            NavigationLink(
                                destination: WishlistView(viewmodel: viewmodel, isLoading: false, selectedTab: selectedTab, isShowBack: true, isActive: $showWishlist),
                                isActive: $showWishlist,
                                label: { EmptyView() }
                            )
                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        
                        VStack(spacing: 10) {
                            
                            //MARK: - Add payment method
                            HStack {
                                Image("fluent_payment-20-regular")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .scaledToFit()
                                    .padding(6)
                                
                                Text("Add Payment Method")
                                    .font(.custom("Ubuntu-Regular", size: 14))
                                
                                Spacer()
                                Button(action :{
                                    
                                }) {
                                    Image("arrow-right")
                                        .resizable()
                                        .frame(width: 10, height: 14)
                                        .scaledToFit()
                                        .padding(10)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                                }
                            }
                            
                            Divider()
                            
                            //MARK: - Address Book
                            HStack {
                                Image("CS - Map")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .scaledToFit()
                                    .padding(6)
                                
                                Text("Address Book")
                                    .font(.custom("Ubuntu-Regular", size: 14))
                                
                                Spacer()
                                Button(action :{
                                    
                                }) {
                                    Image("arrow-right")
                                        .resizable()
                                        .frame(width: 10, height: 14)
                                        .scaledToFit()
                                        .padding(10)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                                }
                            }
                            Divider()
                            
                            //MARK: - Sustainability Points
                            HStack {
                                Image("image 208")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .scaledToFit()
                                    .padding(6)
                                
                                Text("Your Sustainability Points")
                                    .font(.custom("Ubuntu-Regular", size: 14))
                                
                                Spacer()
                                Button(action :{
                                    
                                }) {
                                    Image("arrow-right")
                                        .resizable()
                                        .frame(width: 10, height: 14)
                                        .scaledToFit()
                                        .padding(10)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                                }
                            }
                            Divider()
                            
                            //MARK: - Language
                            HStack {
                                Image("Language")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .scaledToFit()
                                    .padding(6)
                                
                                Text("Select Language")
                                    .font(.custom("Ubuntu-Regular", size: 14))
                                
                                Spacer()
                                Button(action :{
                                    
                                }) {
                                    Image("arrow-right")
                                        .resizable()
                                        .frame(width: 10, height: 14)
                                        .scaledToFit()
                                        .padding(10)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                                }
                            }
                            Divider()
                            
                            //MARK: - Notification
                            HStack {
                                Image("Bell")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .scaledToFit()
                                    .padding(6)
                                
                                Text("Notification Alerts")
                                    .font(.custom("Ubuntu-Regular", size: 14))
                                
                                Spacer()
                                Button(action :{
                                    
                                }) {
                                    Image("arrow-right")
                                        .resizable()
                                        .frame(width: 10, height: 14)
                                        .scaledToFit()
                                        .padding(10)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                                }
                            }
                            Divider()
                            
                            //MARK: - Appearance
                            HStack {
                                Image("iconoir_sun-light")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .scaledToFit()
                                    .padding(6)
                                
                                Text("Change Appearance")
                                    .font(.custom("Ubuntu-Regular", size: 14))
                                
                                Spacer()
                                Button(action :{
                                    
                                }) {
                                    Image("arrow-right")
                                        .resizable()
                                        .frame(width: 10, height: 14)
                                        .scaledToFit()
                                        .padding(10)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                                }
                            }
                            Divider()
                            
                            //MARK: - About us
                            HStack {
                                Image("About Us")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .scaledToFit()
                                    .padding(6)
                                
                                Text("About Us")
                                    .font(.custom("Ubuntu-Regular", size: 14))
                                
                                Spacer()
                                Button(action :{
                                    
                                }) {
                                    Image("arrow-right")
                                        .resizable()
                                        .frame(width: 10, height: 14)
                                        .scaledToFit()
                                        .padding(10)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                                }
                            }
                            Divider()
                            
                            //MARK: - Help
                            HStack {
                                Image("CS - AR Mirror Info")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .scaledToFit()
                                    .padding(6)
                                
                                Text("Help")
                                    .font(.custom("Ubuntu-Regular", size: 14))
                                
                                Spacer()
                                Button(action :{
                                    
                                }) {
                                    Image("arrow-right")
                                        .resizable()
                                        .frame(width: 10, height: 14)
                                        .scaledToFit()
                                        .padding(10)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                                }
                            }
                            Divider()
                            
                            //MARK: - Log out
                            Button(action: {
                                showLogoutAlert = true
                            }) {
                                HStack {
                                    Image("mynaui_logout")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .scaledToFit()
                                        .padding(6)
                                    
                                    Text("Log Out")
                                        .font(.custom("Ubuntu-Regular", size: 14))
                                    
                                    Spacer()
                                }
                            }
                            
                            .alert(isPresented: $showLogoutAlert) {
                                Alert(
                                    title: Text("Confirm Logout"),
                                    message: Text("Are you sure you want to log out?"),
                                    primaryButton: .destructive(Text("Log Out")) {
                                        userAuth.signOut()
                                        //                                        rootModel.action = .loggedoff
                                        navigateToHome = true
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                            
                            
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom, 20)
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .background(
            Color(UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1))
        )
        
        NavigationLink(destination: Carousal1View(viewmodel: viewmodel), isActive: $navigateToHome) {
            EmptyView()
        }
//    }
    }
    
}


// MARK: - profile Header view
struct ProfileHeaderView: View {
    @State var isShowBack: Bool
    @State var isLoading: Bool
    @ObservedObject var viewmodel: CSApiViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showWishlist = false
    @State private var selectedTab = 0
    
    var body: some View {
        HStack {
            
            Text("Profile")
                .font(.custom("Ubuntu-Medium", size: 22))
                .foregroundColor(.black)
                .padding(.leading, 5)
            
            Spacer()
            
            HStack(spacing: 16) {
                Button(action: {
                    // Handle wishlist action
                    showWishlist = true
                }) {
                    Image("CS - Favroites")
                        .resizable()
                        .frame(width: 26, height: 24) // Keep the heart small
                        .scaledToFit()
                        .padding(8)
                        .foregroundColor(.red)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                    
                }
                
                NavigationLink(
                                            destination: WishlistView(
                                                viewmodel: viewmodel,
                                                isLoading: false,
                                                selectedTab: selectedTab,
                                                isShowBack: true,
                                                isActive: $showWishlist
                                            ),
                                            isActive: $showWishlist,
                                            label: { EmptyView() }
                                        )

                
                Button(action: {
                    // Handle QR code action
                }) {
                    Image("Bell")
                        .resizable()
                        .frame(width: 26, height: 24) // Keep the heart small
                        .scaledToFit()
                        .padding(8)
                        .foregroundColor(.red)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                }
            }
        }
    }
}
