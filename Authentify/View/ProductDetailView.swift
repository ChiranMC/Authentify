import SwiftUI

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(product.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Artsy")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("AP Royal Oak\n#\(product.id)")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text("$564")
                        .font(.title2)
                        .fontWeight(.bold)

                    Button("BUY NOW") {
                        // Purchase action here
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)

                    Button("AR VIEW") {
                        // AR view logic
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.black)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black))

                    Divider().padding(.vertical)

                    Group {
                        Text("**Description**")
                        Text("As in handbags, the double ring and bar design defines the wallet shape, highlighting the front flap closure...")

                        Text("**Material & care**")
                        Text("""
                        All products are made with carefully selected materials. Please handle with care for longer product life.
                        - Protect from direct light, heat and rain. Should it become wet, dry it immediately with a soft cloth
                        - Store in the provided flannel bag or box
                        - Clean with a soft, dry cloth
                        """)
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)

                    Divider().padding(.vertical)

                    VStack(spacing: 8) {
                        Text("**Check your product authenticity !**")
                            .font(.headline)

                        Text("Ensure the authenticity of your owned products by entering the product serial number for verification.")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.black)

                        Button("Authenticate Product") {
                            // Trigger serial number authentication
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(8)

                        Text("Once a serial verification is successfully completed with the brand, you will receive a digital certificate...")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
