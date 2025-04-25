import SwiftUI
import Combine

class BrandDetailsViewModel: ObservableObject {
    @Published var descriptionText: String = ""
    @Published var products: [String] = []

    func fetchBrandDetails(for brandID: Int) {
        // Simulate API delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.descriptionText = "This is a backend-fetched description for brand ID \(brandID)."
            self.products = [
                "Royal Oak Offshore Chronograph",
                "Code 11.59 by Audemars Piguet",
                "Royal Oak Selfwinding Flying Tourbillon"
            ]
        }

        // 🔜 Later, replace with real network call
        // URLSession.shared.dataTask(...) or Alamofire.request(...)
    }
}
