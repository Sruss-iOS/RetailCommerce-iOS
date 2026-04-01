//
//  AddressScreenView.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 4/8/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import shared

struct AddressScreenView: View {
    
    @State var houseNo: String = ""
    @State var buildingName: String = ""
    @State var landmarkName: String = ""
    @State var cityName: String = ""
    @ObservedObject var viewmodel: CSApiViewModel
    
    @State var countryCode: String = ""
    @State var isLoading: Bool = false
    @State var isShowCartDetail: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text("House No. & Floor")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("-", text: $houseNo)
                        .padding(.horizontal, 10)
                        .frame(height: 42)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                }.padding(.top, 16)
                
                VStack {
                    Text("Building & Block No.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("-", text: $buildingName)
                        .padding(.horizontal, 10)
                        .frame(height: 42)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                }.padding(.top, 10)
                
                VStack {
                    Text("Landmark & Area Name")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("-", text: $landmarkName)
                        .padding(.horizontal, 10)
                        .frame(height: 42)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                }.padding(.top, 10)
                
                VStack {
                    Text("City")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("-", text: $cityName)
                        .padding(.horizontal, 10)
                        .frame(height: 42)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                }.padding(.top, 10)
                
                VStack {
                    Text("Country *")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("-", text: $countryCode)
                        .padding(.horizontal, 10)
                        .frame(height: 42)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                }.padding(.top, 10)
                
                Spacer()
                
                Button {
                    if countryCode != "" {
                        isLoading = true
                        let addStr = AddressModel(houseNo: houseNo, landmarkName: landmarkName, buildingName: buildingName, cityName: cityName, countryCode: countryCode)
                        UserDefaults.standard.setValue(addStr, forKey: "currentAdd")
                        //viewmodel.saveAddress(streetName: "\(houseNo)\(landmarkName)", apartment: buildingName, city: cityName, countryCode: countryCode)
                        
                    }
                } label: {
                    Text("Save Address")
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color(hex: 0x00d6be))
                        .cornerRadius(10)
                }.padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
            }.padding(16)
        }
        .navigationTitle("Add Address")
        .navigationDestination(isPresented: $isShowCartDetail) {
            //CartDetailView(viewmodel: viewmodel, cartProductList: .constant([ProductsItem]()))
            CartView(viewmodel: viewmodel, isShowBack: true)
        }
    }
}

struct AddressScreenView_Previews: PreviewProvider {
    static var previews: some View {
        AddressScreenView(viewmodel: CSApiViewModel())
    }
}
