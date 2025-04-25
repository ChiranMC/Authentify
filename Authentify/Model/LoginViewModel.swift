//
//  LoginViewModel.swift
//  Authentify
//
//  Created by Knight.Wolf on 2025-04-20.
//


import Foundation

struct User: Identifiable, Codable {
    var id: String { username }
    var firstName: String
    var lastName: String
    var age: Int
    var gender: String
    var username: String
    var password: String
}

class LoginViewModel: ObservableObject {
    @Published var userName = ""
    @Published var password = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var age: String = ""
    @Published var gender = ""
    @Published var registrationStatus: String? = nil
    @Published var loginStatus: String? = nil
    @Published var isLoggedIn = false
    
    
    @Published var currentUser: User? = nil

    // Login function
    func loginUser() {
        guard let url = URL(string: "http://192.168.1.4:3000/login") else { return }

        let loginData = [
            "username": userName,
            "password": password
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: loginData) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.loginStatus = "Network error: \(error.localizedDescription)"
                    self.isLoggedIn = false
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    self.loginStatus = "Invalid response."
                    self.isLoggedIn = false
                    return
                }

                if httpResponse.statusCode == 200 {
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            if let user = try? decoder.decode(User.self, from: data) {
                                self.currentUser = user
                                self.userName = user.username
                                self.loginStatus = "Login successful!"
                                self.isLoggedIn = true
                            } else {
                                self.loginStatus = "Failed to parse user data."
                                self.isLoggedIn = false
                            }
                        } catch {
                            self.loginStatus = "Failed to parse user data."
                            self.isLoggedIn = false
                        }
                    }
                } else {
                    if let data = data,
                       let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let msg = json["message"] as? String {
                        self.loginStatus = "Login failed: \(msg)"
                        self.isLoggedIn = false
                    } else {
                        self.loginStatus = "Login failed: Unknown error"
                        self.isLoggedIn = false
                    }
                }
            }
        }.resume()
    }


    // Register
    func registerUser() {
        guard let url = URL(string: "http://192.168.1.4:3000/register") else { return }

        guard let ageInt = Int(age) else {
            self.registrationStatus = "Invalid age format."
            return
        }

        let registrationData = [
            "firstName": firstName,
            "lastName": lastName,
            "age": ageInt,
            "gender": gender,
            "username": userName,
            "password": password
        ] as [String : Any]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: registrationData) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.registrationStatus = "Network error: \(error.localizedDescription)"
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    self.registrationStatus = "Invalid response."
                    return
                }

                if httpResponse.statusCode == 201 {
                    self.registrationStatus = "User registered successfully!"
                } else {
                    if let data = data,
                       let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let msg = json["message"] as? String {
                        self.registrationStatus = "Registration failed: \(msg)"
                    } else {
                        self.registrationStatus = "Registration failed: Unknown error"
                    }
                }
            }
        }.resume()
    }

    
}
