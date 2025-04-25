//
//  SignUpView.swift
//  Authentify
//
//  Created by Knight.Wolf on 2025-04-13.
//

import SwiftUI

struct SignUpView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var age = ""
    @State private var gender = "Male"
    @State private var username = ""
    @State private var password = ""
    @State private var isPasswordVisible = false

    let genders = ["Male", "Female", "Other"]

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            // Logo Title
            Text("Authentify")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(Color(red: 41/255, green: 37/255, blue: 38/255))

            Text("Create Account")
                .font(.headline)
                .foregroundColor(Color(red: 41/255, green: 37/255, blue: 38/255))

            Group {
                // First Name
                VStack(alignment: .leading, spacing: 6) {
                    Text("First Name")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    TextField("Enter your first name", text: $firstName)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                }

                // Last Name
                VStack(alignment: .leading, spacing: 6) {
                    Text("Last Name")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    TextField("Enter your last name", text: $lastName)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                }

                // Age
                VStack(alignment: .leading, spacing: 6) {
                    Text("Age")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    TextField("Enter your age", text: $age)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                }

                // Gender
                VStack(alignment: .leading, spacing: 6) {
                    Text("Gender")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    Picker("Select your gender", selection: $gender) {
                        ForEach(genders, id: \.self) { gender in
                            Text(gender)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                // Username
                VStack(alignment: .leading, spacing: 6) {
                    Text("Username")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    TextField("Choose a username", text: $username)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                }

                // Password
                VStack(alignment: .leading, spacing: 6) {
                    Text("Password")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
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
            }

            // SIGN UP Button
            Button(action: {
                // Handle sign up
            }) {
                Text("SIGN UP")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 41/255, green: 37/255, blue: 38/255))
                    .cornerRadius(10)
            }

            // Already have an account?
            Button("Already have an account? Log in") {
                // Navigate to login
            }
            .padding(.top)
            .font(.footnote)
            .foregroundColor(Color.black)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    SignUpView()
}
