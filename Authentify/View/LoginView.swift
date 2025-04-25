//
//  LoginView.swift
//  Authentify
//
//  Created by Knight.Wolf on 2025-04-10.
//


import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()

                Text("Authentify")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(Color(red: 41/255, green: 37/255, blue: 38/255))

                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(Color(red: 41/255, green: 37/255, blue: 38/255))

                VStack(alignment: .leading, spacing: 6) {
                    Text("Username")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    TextField("Enter your username", text: $viewModel.userName)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Password")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $viewModel.password)
                        } else {
                            SecureField("Password", text: $viewModel.password)
                        }

                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                }

                // Forgot Password
                HStack {
                    Spacer()
                    Button("Forgot Password?") {
                        // Handle forgot password
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                }

                Button(action: {
                    viewModel.loginUser()
                }) {
                    Text("NEXT")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 41/255, green: 37/255, blue: 38/255))
                        .cornerRadius(10)
                }
                if let status = viewModel.loginStatus {
                                Text(status)
                                    .font(.footnote)
                                    .foregroundColor(status.contains("successful") ? .green : .red)
                                    .padding(.top, 10)
                            }

                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.4))

                    Text("Or")
                        .foregroundColor(.gray)

                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.4))
                }

                Button(action: {
                }) {
                    HStack {
                        Image(systemName: "applelogo")
                            .font(.system(size: 25))
                            .foregroundColor(Color.black)
                        Text("Continue with Apple")
                            .foregroundColor(Color.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.5)))
                }

                Button(action: {
                }) {
                    HStack {
                        Image(systemName: "globe")
                            .font(.system(size: 25))
                        Text("Continue with Google")
                            .foregroundColor(Color.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.5)))
                }

                NavigationLink(destination: SignUpView()) {
                    Text("Create a Account")
                        .padding(.top)
                        .font(.footnote)
                        .foregroundColor(Color.black)
                }
                
                // Navigation Trigger
//                NavigationLink(
//                    destination: DashboardView(),
//                        isActive: $viewModel.isLoggedIn
//                ) {
//                    EmptyView()
//                }
                .fullScreenCover(isPresented: Binding(
                    get: { viewModel.isLoggedIn && viewModel.currentUser != nil },
                    set: { newValue in
                        viewModel.isLoggedIn = newValue
                    }
                )) {
                    DashboardView(loginViewModel: viewModel, user: viewModel.currentUser!)
                }

                Spacer()
            }
            .padding()
            
        }
        .navigationBarBackButtonHidden(true)

    }
}

#Preview {
    LoginView()
}
