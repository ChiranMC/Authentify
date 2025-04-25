//
//  UserProfileView.swift
//  Authentify
//
//  Created by Knight.Wolf on 2025-04-10.
//

import SwiftUI

struct UserProfileView: View {
    var user: User
    @State private var selectedTab: Tab = .profile
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                VStack(alignment: .center, spacing: 12) {
                    
                    Image("profileIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                    
                    Text("\(user.firstName) \(user.lastName) 👋")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding([.top, .horizontal], 16)

                Divider()

                // Info
                Group {
                    userInfoRow(label: "Username", value: user.username)
                    userInfoRow(label: "First Name", value: user.firstName)
                    userInfoRow(label: "Last Name", value: user.lastName)
                    userInfoRow(label: "Gender", value: user.gender)
                    userInfoRow(label: "Age", value: "\(user.age)")
                }
                .padding([.horizontal, .top], 16)

//                // Edit Profile Button
//                Button(action: {
//
//                }) {
//                    Text("Edit Profile")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.brandMainColor)
//                        .cornerRadius(12)
//                }
//                .padding(.horizontal)
//                .padding(.top, 16)

                Spacer()

                BottomNavBar(selectedTab: $selectedTab, viewModel: viewModel)
                    .padding(.bottom, 16)
                    .ignoresSafeArea(edges: .bottom)
            }
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private func userInfoRow(label: String, value: String) -> some View {
        VStack(spacing: 12) {
            HStack {
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text(value)
                    .font(.body)
                    .foregroundColor(.black)
            }
            Divider()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        // mock user
        let mockUser = User(firstName: "Jane", lastName: "Smith", age: 25, gender: "Female", username: "jsmith", password: "password123")
        let mockViewModel = LoginViewModel()
        mockViewModel.currentUser = mockUser
        return UserProfileView(user: mockUser, viewModel: mockViewModel)
    }
}


