//
//  BrandDetailsView.swift
//  Authentify
//
//  Created by Knight.Wolf on 2025-04-16.
//


import SwiftUI

struct BrandDetailsView: View {
    let brand: BrandItem
    @Binding var selectedNavTab: Tab
    @Environment(\.presentationMode) var presentationMode

    @State private var selectedTab: BrandTab = .description
    @StateObject private var viewModel = BrandDetailsViewModel()
    
    @State private var selectedProduct: Product? = nil

    enum BrandTab {
        case description, products
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack(alignment: .topLeading) {
                    Image(brand.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 350)
                        .clipped()
                        .overlay(
                            ZStack {
                                LinearGradient(
                                    gradient: Gradient(colors: [.black.opacity(0.6), .clear]),
                                    startPoint: .top,
                                    endPoint: .center
                                )
                                LinearGradient(
                                    gradient: Gradient(colors: [.clear, .white.opacity(0.7)]),
                                    startPoint: .center,
                                    endPoint: .bottom
                                )
                            }
                        )

                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                            .padding()
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Spacer()
                        Text(brand.subtitle.uppercased())
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.brandGray)
                        Text(brand.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(height: 350, alignment: .bottomLeading)
                }

                HStack {
                    Spacer()
                    Text("Brand Description")
                        .fontWeight(selectedTab == .description ? .bold : .regular)
                        .underline(selectedTab == .description)
                        .onTapGesture {
                            selectedTab = .description
                        }
                    Spacer()
                    Text("Products")
                        .fontWeight(selectedTab == .products ? .bold : .regular)
                        .underline(selectedTab == .products)
                        .onTapGesture {
                            selectedTab = .products
                        }
                    Spacer()
                }
                .padding()
                .background(Color.white)

                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        if selectedTab == .description {
                            if viewModel.descriptionText.isEmpty {
                                ProgressView("Loading description...")
                            } else {
                                Text(viewModel.descriptionText)
                                    .font(.body)
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                        } else {
                            if viewModel.products.isEmpty {
                                ProgressView("Loading products...")
                            } else {
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                    ForEach(viewModel.products) { product in
                                        VStack(spacing: 8) {
                                            Image(product.imageName)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 120)
                                                .cornerRadius(10)

                                            Text(product.name)
                                                .font(.headline)
                                                .multilineTextAlignment(.center)
                                                .lineLimit(1)
                                                .truncationMode(.tail)

                                            Text("SEE MORE")
                                                .font(.caption)
                                                .foregroundColor(.black)
                                                .underline()
                                                .onTapGesture {
                                                        selectedProduct = product
                                                    }
                                        }
                                        .padding()
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(12)
                                        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                                    }
                                }
                                .padding()
                                
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                BottomNavBar(selectedTab: $selectedNavTab)
                    .padding(.bottom, 16)
            }
            .edgesIgnoringSafeArea(.top)
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
                viewModel.fetchBrandDetails(for: brand.id)
            }
            .navigationDestination(item: $selectedProduct) { product in
                    ProductDetailView(product: product)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                }
            .navigationBarBackButtonHidden(true)
        }
        
    }
}


//// MARK: - Preview
//struct BrandDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        BrandDetailsView()
//    }
//}
