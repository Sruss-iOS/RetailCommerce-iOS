import SwiftUI

struct FilterPopupView: View {
    @Binding var isPresented: Bool // To toggle popup visibility
    @Binding var selectedCategory: String? // Selected category
    @Binding var selectedPriceRange: String? // Selected price range

    // Sample options
    let categories = ["Category 1", "Category 2", "Category 3"]
    let priceRanges = ["All", "₹500 to ₹1,000"]

    var body: some View {
        ZStack {
            // Background dimming overlay
            if isPresented {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isPresented = false // Dismiss when tapping outside
                    }
            }

            // Popup content
            VStack(spacing: 16) {
                // Header
                HStack {
                    Text("Filters")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        isPresented = false // Close popup
                    }) {
                        Text("Close")
                            .foregroundColor(.teal)
                    }
                }
                .padding()

                Divider()

                // Categories Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Categories")
                        .font(.subheadline)
                        .bold()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    selectedCategory = category
                                }) {
                                    Text(category)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(selectedCategory == category ? Color.teal.opacity(0.2) : Color.gray.opacity(0.1))
                                        .foregroundColor(selectedCategory == category ? .teal : .black)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal)

                // Price Range Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Price Range")
                        .font(.subheadline)
                        .bold()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(priceRanges, id: \.self) { range in
                                Button(action: {
                                    selectedPriceRange = range
                                }) {
                                    Text(range)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(selectedPriceRange == range ? Color.teal.opacity(0.2) : Color.gray.opacity(0.1))
                                        .foregroundColor(selectedPriceRange == range ? .teal : .black)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal)

                Spacer()

                // Footer Buttons
                HStack {
                    Button("Clear All") {
                        selectedCategory = nil
                        selectedPriceRange = nil
                    }
                    .foregroundColor(.gray)

                    Spacer()

                    Button("Show Results") {
                        isPresented = false
                        // Apply filters here
                    }
                    .foregroundColor(.teal)
                }
                .padding()
            }
            .padding(.bottom)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 10)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .none) // Adjust based on content height
            .transition(.move(edge: .bottom)) // Slide-in animation
            .animation(.easeInOut, value: isPresented)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

