//
//  UserProductsView.swift
//  Authentify
//
//  Created by Knight.Wolf on 2025-04-10.
//


import SwiftUI

struct UserProductsView: View {
    @StateObject private var viewModel = UserProductViewModel()
    let username: String
    @State private var selectedTab: Tab = .bag
    @ObservedObject var loginViewModel: LoginViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(alignment: .center, spacing: 12) {
                    Image("profileIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                    
                    Text("\(username)")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("My Products")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding([.top, .horizontal], 16)
                
                Divider()

                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(viewModel.userproducts) { product in
                            ProductCardView(product: product)
                        }
                    }
                    .padding()
                }

                Spacer()

                BottomNavBar(selectedTab: $selectedTab, viewModel: loginViewModel)
                    .padding(.bottom, 16)
            }
            .background(Color.white)
            .ignoresSafeArea(edges: .bottom)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                viewModel.fetchUserProducts(for: username)
            }
        }
    }
}


struct ProductCardView: View {
    let product: UserProduct

    var body: some View {
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
        }
        .padding()
        .background(Color.gray.opacity(0.3))
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}


struct UserProductsView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUser = User(firstName: "John", lastName: "Doe", age: 30, gender: "Male", username: "johndoe", password: "password123")
        let mockLoginViewModel = LoginViewModel()
        mockLoginViewModel.currentUser = mockUser
        
        return UserProductsView(username: "ChiranMC", loginViewModel: mockLoginViewModel)
    }
}
