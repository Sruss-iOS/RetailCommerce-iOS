//
//  SuccessScreen.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 3/7/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct SuccessScreen: View {
    
    @State var isPresented : Bool = false
    
    var body: some View {
        VStack {
            Image("cornershopimg")
                .aspectRatio(contentMode: .fit)
                .padding(.top, 40)
            
            VStack{
                Image("successImg")
                    .frame(width: 282, height: 268)
                    .aspectRatio(contentMode: .fit)
                Text("Success")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 30)
                Text("Your password has been changed.")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.padding(16)
            
            Button {
                isPresented = true
            } label: {
                Text("Login")
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
        .navigationDestination(isPresented: $isPresented) {
            WelcomeView(viewmodel: CSApiViewModel(), rootmodel: rootViewModel())
        }
    }
}

struct SuccessScreen_Previews: PreviewProvider {
    static var previews: some View {
        SuccessScreen()
    }
}
