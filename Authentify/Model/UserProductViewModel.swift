//
//  UserProductViewModel.swift
//  Authentify
//
//  Created by Knight.Wolf on 2025-04-20.
//

import SwiftUI
import Combine

struct UserProduct: Identifiable, Codable {
    let id: Int
    let name: String
    let imageName: String
    let brandId: Int
    let description: String
    let materialAndCare: String
}

class UserProductViewModel: ObservableObject {
    @Published var userproducts: [UserProduct] = []
    @Published var errorMessage: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchUserProducts(for username: String) {
        errorMessage = "Fetching products for \(username)..."
        
        guard let url = URL(string: "http://localhost:3000/api/user-products/\(username)") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [UserProduct].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("\(username)'s products loaded.")
                case .failure(let error):
                    self.errorMessage = "Failed to load: \(error.localizedDescription)"
                    print("API Error: \(error)")
                }
            }, receiveValue: { [weak self] products in
                self?.userproducts = products
            })
            .store(in: &cancellables)
    }
}
