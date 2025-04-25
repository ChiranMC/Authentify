//
//  BottomNavBar.swift
//  Authentify
//
//  Created by Knight.Wolf on 2025-04-13.
//

enum Tab {
    case home, bag, favorites, profile
}

import SwiftUI

struct BottomNavBar: View {
    @Binding var selectedTab: Tab
    @ObservedObject var viewModel: LoginViewModel

    @State private var navigateToProfile = false
    @State private var navigateToHome = false
    @State private var navigateToBag = false  // NEW

    var body: some View {
        ZStack {
            HStack(spacing: 40) {
                navButton(icon: "house", tab: .home)
                navButton(icon: "person", tab: .profile)
                navButton(icon: "bag", tab: .bag)
                navButton(icon: "exclamationmark.circle", tab: .favorites)
            }
            .padding()
            .background(Color.brandMainColor)
            .clipShape(Capsule())
            .padding(.horizontal)

            
            NavigationLink(
                destination: UserProfileView(user: viewModel.currentUser!, viewModel: viewModel)
                    .navigationBarBackButtonHidden(true),
                isActive: $navigateToProfile,
                label: { EmptyView() }
            )
            .hidden()

            NavigationLink(
                destination: DashboardView(loginViewModel: viewModel, user: viewModel.currentUser!)
                    .navigationBarBackButtonHidden(true),
                isActive: $navigateToHome,
                label: { EmptyView() }
            )
            .hidden()

            NavigationLink(
                destination: UserProductsView(username: viewModel.userName, loginViewModel: viewModel)
                    .navigationBarBackButtonHidden(true),
                isActive: $navigateToBag,
                label: { EmptyView() }
            )
            .hidden()
        }
    }

    func navButton(icon: String, tab: Tab) -> some View {
        Button(action: {
            switch tab {
            case .profile:
                navigateToProfile = true
            case .home:
                navigateToHome = true
            case .bag:
                navigateToBag = true
            default:
                selectedTab = tab
            }
        }) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(selectedTab == tab ? .white : .gray)
                .frame(width: 50, height: 50)
                .background(selectedTab == tab ? Color.brandMainColor.opacity(0.7) : Color.clear)
                .clipShape(Circle())
        }
    }
}
