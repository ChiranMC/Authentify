import SwiftUI
import Combine

class DashboardViewModel: ObservableObject {
    @Published var selectedCategory: String = "Brands"
    @Published var brandItems: [BrandItem] = [
        BrandItem(id: 1, title: "Audemars Piguet", subtitle: "Luxury Watch", imageName: "APWatch", category: "Watches"),
        BrandItem(id: 2, title: "Swatch", subtitle: "Everyday Watch", imageName: "SwatchWatch", category: "Watches"),
        BrandItem(id: 3, title: "Rolex", subtitle: "Premium Watch", imageName: "RolexWatch", category: "Watches"),
        BrandItem(id: 4, title: "Prada", subtitle: "Designer Apparel", imageName: "PradaBag", category: "Clothing"),
        BrandItem(id: 5, title: "Gucci", subtitle: "High-End Fashion", imageName: "GucciShirt", category: "Clothing"),
        BrandItem(id: 6, title: "Louis Vuitton", subtitle: "Stylish Clothing", imageName: "LVOutfit", category: "Clothing"),
        BrandItem(id: 7, title: "Persol", subtitle: "Luxury Sunglasses", imageName: "PerolGlasses", category: "Accessories"),
        BrandItem(id: 8, title: "Ray-Ban", subtitle: "Iconic Eyewear", imageName: "RaybanGlasses", category: "Accessories"),
        BrandItem(id: 9, title: "Oakley", subtitle: "Sport Accessories", imageName: "OakleyCase", category: "Accessories"),
        BrandItem(id: 10, title: "Chanel", subtitle: "Luxury Brand", imageName: "ChanelBag", category: "Brands"),
        BrandItem(id: 11, title: "Balenciaga", subtitle: "Fashion House", imageName: "BalenciagaShoes", category: "Brands"),
        BrandItem(id: 12, title: "Dior", subtitle: "Designer Brand", imageName: "DiorPerfume", category: "Brands")
    ]
    
    var filteredItems: [BrandItem] {
        brandItems.filter { $0.category == selectedCategory }
    }

    // Future: Replace with API call
    func fetchBrandItems() {
        // Placeholder for network fetch logic
    }
}
