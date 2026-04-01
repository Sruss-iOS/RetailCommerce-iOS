//
//  FilterView.swift
//  iosApp
//
//  Created by Srushti Choudhari on 11/07/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct FilterView: View {

    var body: some View {
        VStack {
            HStack {
                Text("Filters")
                    .font(.custom("Ubuntu-Medium", size: 22))
                
                Spacer()
                
                Image("close")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaledToFit()
            }
            .padding(.bottom, 1)
            
            
            Divider()
            
            HStack(alignment: .top) {
                //Previously Bought
                FilterItemView()
                Spacer()
                Divider()
                Spacer()
                
            }
        }
        .padding(.horizontal, 15)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    FilterView()
}

struct filterItem: View {
    let text: String
    let index: Int
    @Binding var selectedFilter: Int
    
    var body: some View {
        
        Button(action: {
            withAnimation {
                selectedFilter = index
                print(selectedFilter)
            }
        }) {
            if selectedFilter == index {
                Text(text)
                    .font(.custom("Ubuntu-Regular", size: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .frame(width: 150, height: 50)
                    .overlay(
                        Rectangle()
                            .stroke(Color.blue, lineWidth: 2)
                    )
            } else {
                Text(text)
                    .font(.custom("Ubuntu-Regular", size: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .frame(width: 150, height: 50)
                    .overlay(
                        Rectangle()
                            .background(Color.white)
                            .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
                    )
            }
        }
        
    }
}

struct FilterItemView: View {
    @State private var selectedFilter = 0
    var body: some View {
        VStack {
            filterItem(text: "Previously Bought", index: 0, selectedFilter: $selectedFilter)
            filterItem(text: "Categories", index: 1, selectedFilter: $selectedFilter)
            filterItem(text: "Gender", index: 2, selectedFilter: $selectedFilter)
            filterItem(text: "Age", index: 3, selectedFilter: $selectedFilter)
            filterItem(text: "Brand", index: 4, selectedFilter: $selectedFilter)
            filterItem(text: "Price", index: 5, selectedFilter: $selectedFilter)
            filterItem(text: "Discounts", index: 6, selectedFilter: $selectedFilter)
            filterItem(text: "Color", index: 7, selectedFilter: $selectedFilter)
        }
    }
}

