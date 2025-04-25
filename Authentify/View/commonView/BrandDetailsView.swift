import SwiftUI

struct BrandDetailsView: View {
    let brand: BrandItem
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topLeading) {
                Image(brand.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 350)
                    .clipped()

                LinearGradient(
                    gradient: Gradient(colors: [.black.opacity(0.4), .clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 350)

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                        .padding()
                }

                VStack(alignment: .leading, spacing: 8) {
                    Spacer()
                    Text("WATCH BRAND")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    Text(brand.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 40)
            }

            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
    }
}
