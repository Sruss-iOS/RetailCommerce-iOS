//
//  searchBarView.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 4/19/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import shared

struct SearchBarView: View {
    @State private var searchText = ""
    @State var isShowDetailPage: Bool = false
    @ObservedObject var viewmodel: CSApiViewModel

    var body: some View {
        List {
            ForEach(searchResults, id: \.self) { item in
                HStack{
                    AsyncImage(url: URL(string: "\(item.imageUrl ?? "")")){ image in
                        image.resizable()
                            .frame(maxWidth: 40, maxHeight: 40)
                          .clipped()
                          .clipShape(Circle())
                      } placeholder: {
                        EmptyView()
                      }
                    Text(item.name ?? "")
                }
                .onTapGesture {
                    viewmodel.getProductDetails(productid: item.id ?? "") { result in
                        if result {
                            isShowDetailPage = true
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .navigationDestination(isPresented: $isShowDetailPage) {
            ProductDetailView(viewmodel: viewmodel, isLoading: true, initialFavorite: false)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var searchResults: [ResponseItem] {
        let data: [ResponseItem] = viewmodel.productList ?? []
        return data.filter { $0.name?.range(of: searchText, options: .caseInsensitive) != nil }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(viewmodel: CSApiViewModel())
    }
}

struct SearchBar1View: View {
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Image("CS - Search NEW")
                    .foregroundColor(.gray)
                
                TextField("Search", text: $searchText)
                    .font(.custom("Ubuntu-Medium", size: 16))
                    .foregroundColor(Color(hex: 0xafbcc1))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, minHeight: 40)
                
                Image("microphone")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 12)
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0.25)
                            .stroke(Color(red: 0.72, green: 0.86, blue: 0.85), lineWidth: 0.5)
                            .shadow(color: Color.black.opacity(0.6), radius: 3, x: 2, y: 2)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    )
            )
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
            
        }
    }
}
