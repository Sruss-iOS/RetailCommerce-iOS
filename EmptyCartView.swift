//
//  EmptyCartView.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 4/24/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct EmptyCartView: View {

    var body: some View {
        VStack{
            
            Text("Cart is Empty")
                .foregroundColor(.black)
                .font(.custom("Ubuntu-Bold", size: 20))
            Spacer()
            Text("The product you are looking for doesn’t exist.")
                .foregroundColor(.gray)
                .font(.custom("Ubuntu-Regular", size: 14))
            Spacer(minLength: 200)
            
    
            Image("shopping cart")
                .resizable()               // ✅ Works fine now!
                .scaledToFit()
                .frame(width: 180, height: 180, alignment: .center)
            
            
            Spacer()
        }
        .frame(alignment: .top)

    }
}

struct EmptyCartView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyCartView()
    }
}
