import SwiftUI

struct UserProductsView: View {
    @Binding var selectedTab: Tab
    @ObservedObject var loginViewModel: LoginViewModel
    var user: User
    
    @StateObject private var viewModel = UserProductViewModel()
    @State private var selectedProduct: UserProduct? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    if viewModel.userproducts.isEmpty {
                        ProgressView("Loading products for \(user.username)...")
                            .padding(.top, 100)
                    } else {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(viewModel.userproducts) { product in
                                VStack(spacing: 8) {
                                    Image(product.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 120)
                                        .cornerRadius(10)

                                    Text(product.name)
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(1)

                                    Text("SEE MORE")
                                        .font(.caption)
                                        .foregroundColor(.black)
                                        .underline()
                                        .onTapGesture {
                                            selectedProduct = product
                                        }
                                }
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(12)
                                .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                            }
                        }
                        .padding()
                    }
                }

                BottomNavBar(selectedTab: $selectedTab, viewModel: loginViewModel)
                    .padding(.bottom, 16)
            }
            .navigationDestination(item: $selectedProduct) { product in
                // You can create a dedicated detail view for UserProduct if needed
                Text("Detail for \(product.name)")
                    .navigationBarBackButtonHidden(true)
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                viewModel.fetchUserProducts(for: user.username)
            }
        }
    }
}
