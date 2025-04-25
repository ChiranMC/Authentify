//
//  BrandDetailsView.swift
//  Authentify
//
//  Created by Knight.Wolf on 2025-04-16.
//


import SwiftUI
import MapKit


struct BrandDetailsView: View {
    let brand: BrandItem
    @Binding var selectedNavTab: Tab
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var loginViewModel: LoginViewModel

    @State private var selectedTab: BrandTab = .description
    @StateObject private var viewModel = BrandDetailsViewModel()
    
    @State private var selectedProduct: Product? = nil
    @State private var navigateToAuth = false

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
//                                Text(viewModel.descriptionText)
//                                    .font(.body)
//                                    .foregroundColor(.gray)
//                                    .padding()
                                VStack(alignment: .leading, spacing: 16) {
                                    Text(brand.description)
                                        .font(.body)
                                        .foregroundColor(.gray)
                                    
                                    Spacer()
                                    Text("Check your product authenticity !")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)

                                    Text("Ensure the authenticity of your owned products by entering the product serial number for verification. Once a serial verification is successfully completed with the brand, you will receive a digital certificate as a proof of product authenticity")
                                        .font(.body)
                                        .foregroundColor(.gray)
                                    
                                    VStack(spacing: 16) {
                                        Button("Authenticate Product") {
                                            navigateToAuth = true
                                        }
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.brandMainColor)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)

                                        NavigationLink(
                                            destination: ProductAuthenticationView(),
                                            isActive: $navigateToAuth
                                        ) {
                                            EmptyView()
                                        }
                                    }
                                    .padding(.horizontal)
                                    
                                    Spacer()
                                    //Map Block
                                    Text("Look for nearest authorised service centers")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                    Text("Locate the nearest authorized service centers with ease. Get professional assistance from trusted experts at authorized service facilities.")
                                        .font(.body)
                                        .foregroundColor(.gray)
                                    
                                    Map(coordinateRegion: .constant(MKCoordinateRegion(
                                        center: CLLocationCoordinate2D(latitude: brand.latitude, longitude: brand.longitude),
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                                    )), annotationItems: [brand]) { place in
                                        MapMarker(coordinate: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude), tint: .blue)
                                    }
                                    .frame(height: 200)
                                    .cornerRadius(10)
                                    
                                    
                                }
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

                BottomNavBar(selectedTab: $selectedNavTab,viewModel: loginViewModel)
                    .padding(.bottom, 16)
            }
            .edgesIgnoringSafeArea(.top)
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
                viewModel.fetchBrandDetails(for: brand.id)
            }
            .navigationDestination(item: $selectedProduct) { product in
                ProductDetailView(product: product, brand: brand)
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
