import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var loginStatus: String? = nil

    func loginUser() {
        guard let url = URL(string: "http://localhost:3000/login") else { return }

        let loginData = [
            "username": email,
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
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    self.loginStatus = "Invalid response."
                    return
                }

                if httpResponse.statusCode == 200 {
                    self.loginStatus = "Login successful!"
                } else {
                    if let data = data,
                       let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let msg = json["message"] as? String {
                        self.loginStatus = "Login failed: \(msg)"
                    } else {
                        self.loginStatus = "Login failed: Unknown error"
                    }
                }
            }
        }.resume()
    }
}
