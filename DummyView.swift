//
//  DummyView.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 5/17/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct DummyView: View {
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<30, id: \.self) { item in
                    VStack {
                        GeometryReader { geometry in
                            let size = geometry.size.width
                            Image("salmon_small")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size, height: size)
                        }
                        .aspectRatio(1, contentMode: .fit)
                        
                        VStack{
                            Text("hi hello")
                                .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.black)
                                .font(.system(size: 14))
                                .lineLimit(1)
                            Text("ergrgrgrd")
                                .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fontWeight(.thin)
                                .font(.system(size: 12))
                                .lineLimit(1)
                            Text("rtgrdgerdgdr")
                                .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fontWeight(.thin)
                                .font(.system(size: 12))
                                .lineLimit(1)
                        }
                        HStack{
                            VStack(alignment: .leading, spacing: 2) {
                                Text("\u{20B9}"+"566")
                                    .strikethrough(true, color: .black)
                                    .font(.system(size: 14))
                                    .fontWeight(.thin)

                                Text("\u{20B9}"+"600")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14))
                            }
                            Spacer()
                            Button(action: {
                            }){
                                Text("Add")
                                    .padding(.horizontal, 7)
                                    .padding(.vertical, 7)
                                    .font(.system(size: 16))
                                    .foregroundColor(Color(hex: 0x00d6be))
                                    .fontWeight(.medium)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color(hex: 0x00d6be), lineWidth: 1)
                                    )
                            }
                        }.padding(EdgeInsets(top: 2, leading: 4, bottom: 10, trailing: 4))
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
            }
            .padding()
        }
    }
}

struct DummyView_Previews: PreviewProvider {
    static var previews: some View {
        DummyView()
    }
}

/*
struct OfferView: View {
    
    @State private var currentIndex = 0
    @ObservedObject var viewmodel: CSApiViewModel // viewmodel
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    let OfferScrollImgs: [String] = ["Nike Offer", "Nike Offer 2", "Nike Offer 1"]
    
    let discounts: [String] = ["Discount Coupon", "Discount Coupon 3", "Discount Coupon"]
    
    @Environment(\.presentationMode) var presentationMode
    @State var isShowBack: Bool
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    // Logo and Icons
                    HStack{
                        if isShowBack{
                            Button(action: {
                                // Handle back action
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.title2)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .frame(width: 34, height: 34)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                        }
                        HeaderView(viewmodel: viewmodel)
                    }
                    .padding(.leading, 12)
                    
                    // Search Bar
                    NavigationLink(destination: SearchBarView(viewmodel: viewmodel), label: {
                        searchView()
                    })
                    
                    // Section Title
                    VStack(alignment: .leading, spacing: 5) {
                        Text("NEW YEAR SALE IS ON")
                            .font(.custom("Ubuntu-BoldItalic", size: 20))
                        
                        Text("Hop in and grab Awesome deals")
                            .font(.custom("Ubuntu-Light", size: 14))
                    }
                    .padding(.leading)
                    .padding(.bottom, 10)
                    
                    // Banner Section
                    ScrollViewReader { scrollProxy in
                        VStack(alignment: .center){
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(0..<OfferScrollImgs.count, id: \.self) { index in
                                        if let bannerlist = viewmodel.discountBannersList, !bannerlist.isEmpty {
                                            ForEach(bannerlist.indices, id: \.self) { index in
                                                NavigationLink(destination: ProductListView(viewmodel: viewmodel, isLoading: true, isShowBack: true).navigationBarBackButtonHidden(true)) {
                                                    OfferBannerView(imageUrl: bannerlist[index].imageUrl ?? "", id: index)
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal, 12)
                            }
                            .onReceive(timer) { _ in
                                withAnimation {
                                    currentIndex = (currentIndex + 1) % OfferScrollImgs.count
                                    scrollProxy.scrollTo(currentIndex, anchor: .leading)
                                }
                            }
                            
                            // Navigation Dots
                            HStack(spacing: 8) {
                                ForEach(0..<OfferScrollImgs.count, id: \.self) { index in
                                    Circle()
                                        .fill(currentIndex == index ? Color.green : Color.gray.opacity(0.3))
                                        .frame(width: 8, height: 8)
                                        .onTapGesture {
                                            withAnimation {
                                                currentIndex = index
                                            }
                                        }
                                }
                            }
                            .padding(.top, 10)
                        }
                    }
                    .padding(.leading, 12)
                    
                    //second banner
                    ScrollViewReader { scrollProxy in
                        VStack(alignment: .center){
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(0..<discounts.count, id: \.self) { index in
                                        NavigationLink(destination: ProductListView(viewmodel: viewmodel, isLoading: true, isShowBack: true).navigationBarBackButtonHidden(true)) {
                                            Image(discounts[index])
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.main.bounds.width * 0.60) // 75% width
                                                .clipped()
                                                .id(index) // Attach ID for scrolling
                                        }
                                    }
                                }
                                .padding(.horizontal, 12)
                            }
                            
                            
                        }
                    }
                    .padding(.leading, 12)
                    
                    
                    
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            if viewmodel.offerScreenValidate == false {
                fetchOfferData()
            }
        }
    }
    
    func fetchOfferData(){
        isLoading = true
        viewmodel.getOfferList { result in
            if result {
                isLoading = false
            }
        }
    }
}

struct OfferBannerView: View {
    let imageUrl: String
    let id: Int
    
    var body: some View {
        LazyImage(source: URL(string:  imageUrl)) { state in
            if let response = try? state.result?.get() { // ✅ Unwrap Result
                let uiImage = response.image // ✅ Get UIImage
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width * 0.60, height: 400) // 60% width
                    .clipped()
                    .id(id) // Attach ID for scrolling
                
            } else if state.isLoading {
                SkeletonView()
                    .frame(width: UIScreen.main.bounds.width * 0.60, height: 400)
            } else {
                Image(systemName: "photo") // Placeholder
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width * 0.60, height: 400)
                    .clipped()
            }
        }
    }
}

*/
