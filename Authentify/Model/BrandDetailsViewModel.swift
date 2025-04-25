import SwiftUI
import Combine

struct Product: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let imageName: String
    let brandId: Int
    let description: String
    let materialAndCare: String
}

class BrandDetailsViewModel: ObservableObject {
    @Published var descriptionText: String = ""
    @Published var products: [Product] = []
    
    private var cancellables = Set<AnyCancellable>()

    func fetchBrandDetails(for brandID: Int) {
        descriptionText = "Fetching brand details..."
        
        guard let url = URL(string: "http://192.168.1.4:3000/api/products/by-brand?brandId=\(brandID)") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Product].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.descriptionText = "Brand ID \(brandID) products loaded."
                case .failure(let error):
                    self.descriptionText = "Failed to load: \(error.localizedDescription)"
                    print("API Error: \(error)")
                }
            }, receiveValue: { [weak self] products in
                self?.products = products
            })
            .store(in: &cancellables)
    }
}
