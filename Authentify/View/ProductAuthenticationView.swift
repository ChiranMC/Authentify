//
//  ProductAuthenticationView.swift
//  Authentify
//
//  Created by Knight.Wolf on 2025-04-20.
//

import SwiftUI
import PhotosUI

struct ProductAuthenticationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var serialNumber: String = ""
    @State private var selectedImages: [UIImage] = []
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.brandMainColor)
                        .padding()
                        .background(Color.white.opacity(0.6))
                        .clipShape(Circle())
                }
                Spacer()
            }
            .padding(.top, 10)
            .padding(.horizontal)

            Image(systemName: "lock")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.white)

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
                            
                            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                                Text("Browse Files")
                                    .padding(.horizontal)
                                    .padding(.vertical, 6)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(6)
                                    .foregroundColor(.white)
                            }
                            .onChange(of: selectedItem) { newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                                       let uiImage = UIImage(data: data) {
                                        selectedImage = uiImage
                                        selectedImages.append(uiImage)
                                    }
                                }
                            }
                        }
                    )
            }
            .padding(.horizontal)

            Text("The verification process may take 2–3 days, during which the product details will be carefully reviewed. You will receive a notification once the verification is complete.")
                .font(.footnote)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            Button("Authenticate") {
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(8)
            .padding(.horizontal)
            .padding(.bottom, 26)
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationBarBackButtonHidden(true)
        .background(Color.brandMainColor.edgesIgnoringSafeArea(.all))
    }
}

// MARK: - Preview
struct ProductAuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        ProductAuthenticationView()
    }
}
