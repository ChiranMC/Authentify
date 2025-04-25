import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            // Logo Title
            Text("Authentify")
                .font(.system(size: 36, weight: .bold))

            Text("Sign In")
                .font(.headline)
                .foregroundColor(.gray)

            // Email Field
            VStack(alignment: .leading, spacing: 6) {
                Text("Username")
                    .font(.subheadline)
                    .foregroundColor(.black)

                TextField("Enter your email", text: $email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
            }

            // Password Field
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

            // Forgot Password
            HStack {
                Spacer()
                Button("Forgot Password?") {
                    // Handle forgot password
                }
                .font(.caption)
                .foregroundColor(.gray)
            }

            // NEXT Button
            Button(action: {
                // Handle login
            }) {
                Text("NEXT")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(10)
            }

            // OR Divider
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

            // Apple Button
            Button(action: {
                // Handle Apple login
            }) {
                HStack {
                    Image(systemName: "applelogo")
                    Text("Continue with Apple")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
            }

            // Google Button
            Button(action: {
                // Handle Google login
            }) {
                HStack {
                    Image(systemName: "globe") // You can use a custom Google icon here
                    Text("Continue with Google")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
            }

            // Create Account
            Button("Create a Account") {
                // Navigate to signup
            }
            .padding(.top)
            .font(.footnote)

            Spacer()
        }
        .padding()
    }
}
