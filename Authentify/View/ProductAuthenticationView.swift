import SwiftUI

struct ProductAuthenticationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var serialNumber: String = ""
    @State private var selectedImages: [UIImage] = []

    var body: some View {
        VStack(spacing: 20) {
            // Back Button
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                }
                Spacer()
            }
            .padding(.top, 40)
            .padding(.horizontal)

            Spacer()
            
            // Lock Icon
            Image(systemName: "lock")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.white)

            // Title and Description
            Text("Authenticate Your Product")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top)

            Text("Enter the product's serial number along with two images to verify its authenticity.")
                .font(.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            // Serial Number Field
            VStack(alignment: .leading) {
                Text("Product Serial Number")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)

                TextField("Enter your Serial Number", text: $serialNumber)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)

            // Image Upload Placeholder
            VStack(spacing: 12) {
                Text("Product Image")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)

                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .foregroundColor(.white)
                    .frame(height: 180)
                    .overlay(
                        VStack(spacing: 10) {
                            Image(systemName: "icloud.and.arrow.up")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                            Text("Drop file or browse")
                                .foregroundColor(.white)
                            Text("Format: .jpeg, .png & Max file size: 25 MB")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Button("Browse Files") {
                                // TODO: Add image picker
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(6)
                            .foregroundColor(.white)
                        }
                    )
            }
            .padding(.horizontal)

            // Verification Info
            Text("The verification process may take 2–3 days, during which the product details will be carefully reviewed. You will receive a notification once the verification is complete.")
                .font(.footnote)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            // Authenticate Button
            Button("Authenticate") {
                // Authentication action
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(8)
            .padding(.horizontal)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
