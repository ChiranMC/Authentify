//
//  DashboardView.swift
//  Authentify
//
//  Created by Knight.Wolf on 2025-04-13.
//

import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
}


extension Color {
    static let brandMainColor = Color(red: 41/255, green: 37/255, blue: 38/255)
    static let brandGray = Color(red: 127/255, green: 127/255, blue: 127/255)
}

struct DashboardView: View {
    @State private var selectedCategory = "All"
    @State private var selectedTab: Tab = .home
    @State private var searchQuery: String = ""
    @StateObject private var viewModel = DashboardViewModel()
    @ObservedObject var loginViewModel: LoginViewModel
    var user: User

    let categories: [Category] = [
        Category(name: "All", icon: "star.fill"),
        Category(name: "Brands", icon: "figure.dress.line.vertical.figure"),
        Category(name: "Watches", icon: "figure.dress.line.vertical.figure"),
        Category(name: "Clothing", icon: "tshirt"),
        Category(name: "Accessories", icon: "figure.walk")
    ]

    var filteredItems: [BrandItem] {
        let categoryFilteredItems: [BrandItem]
        if selectedCategory == "All" {
            categoryFilteredItems = viewModel.brandItems
        } else {
            categoryFilteredItems = viewModel.brandItems.filter { $0.category == selectedCategory }
        }
        
        if searchQuery.isEmpty {
            return categoryFilteredItems
        } else {
            return categoryFilteredItems.filter { $0.title.lowercased().contains(searchQuery.lowercased()) }
        }
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Welcome Back!, 👋")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("\(user.firstName) \(user.lastName)")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        Spacer()
                        Image("profileIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 44, height: 44)
                            .clipShape(Circle())
                    }

                    HStack(spacing: 12) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search by Brand", text: $searchQuery) // Bound to the search query
                                .foregroundColor(.gray)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }

                    // Categories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(categories) { category in
                                Button(action: {
                                    selectedCategory = category.name
                                }) {
                                    HStack(spacing: 8) {
                                        Image(systemName: category.icon)
                                        Text(category.name)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(
                                        selectedCategory == category.name ? Color.brandMainColor : Color.white
                                    )
                                    .foregroundColor(
                                        selectedCategory == category.name ? .white : .brandMainColor
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: selectedCategory == category.name ? 0 : 1)
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                            }
                        }
                    }

                    // Brand Cards
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(filteredItems) { item in
                                BrandCardView(item: item, selectedTab: $selectedTab, loginViewModel: loginViewModel)
                            }
                        }
                        .padding(.top)
                    }
                    .ignoresSafeArea(edges: .bottom)

                }
                .padding([.horizontal, .bottom])
                .frame(maxHeight: .infinity, alignment: .top)

                BottomNavBar(selectedTab: $selectedTab, viewModel: loginViewModel)
                    .padding(.bottom, 16)
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                viewModel.fetchBrandItems()
            }
        }
    }
}

// MARK: - Brand Card View with Navigation
struct BrandCardView: View {
    let item: BrandItem
    @Binding var selectedTab: Tab
    @ObservedObject var loginViewModel: LoginViewModel

    var body: some View {
        NavigationLink(destination: BrandDetailsView(brand: item, selectedNavTab: $selectedTab, loginViewModel: loginViewModel)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        ) {
            ZStack(alignment: .topLeading) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 175, height: 186)
                    .clipped()
                    .cornerRadius(16)

                LinearGradient(
                    gradient: Gradient(colors: [.black.opacity(0.5), .clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(width: 175, height: 186)
                .cornerRadius(16)

                VStack(alignment: .leading, spacing: 4) {
                    Text(item.subtitle)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    Text(item.title)
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                }
                .padding()
            }
            .frame(width: 175, height: 186)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(16)
        }
    }
}

// MARK: - Preview
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUser = User(firstName: "Jane", lastName: "Smith", age: 25, gender: "Female", username: "T", password: "t")
        
        let mockViewModel = LoginViewModel()
        mockViewModel.currentUser = mockUser
        return NavigationView {
            DashboardView(loginViewModel: mockViewModel, user: mockUser)
        }
    }
}

