//
//  DashboardViewModel.swift
//  Authentify
//
//  Created by Knight.Wolf on 2025-04-20.
//

import SwiftUI
import Combine

struct BrandItem: Identifiable, Codable {
    let id: Int
    let title: String
    let subtitle: String
    let imageName: String
    let category: String
    var latitude: Double
    var longitude: Double
    var description: String
}

class DashboardViewModel: ObservableObject {
    @Published var selectedCategory: String = "Brands"
    @Published var brandItems: [BrandItem] = []

    var filteredItems: [BrandItem] {
        brandItems.filter { $0.category == selectedCategory }
    }

    private var cancellables = Set<AnyCancellable>()

    func fetchBrandItems() {
        guard let url = URL(string: "http://localhost:3000/api/brands") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [BrandItem].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Finished fetching")
                case .failure(let error):
                    print("Error fetching brand items: \(error)")
                }
            }, receiveValue: { [weak self] items in
                print("Received items: \(items)")
                self?.brandItems = items
            })
            .store(in: &cancellables)
    }
}
