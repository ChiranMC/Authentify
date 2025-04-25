//
//  ProductDetailView.swift
//  Authentify
//
//  Created by Knight.Wolf on 2025-04-19.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    let brand: BrandItem
    @State private var showARView = false
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToAuth = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                ScrollView {
                    VStack(spacing: 20) {
                        HStack(alignment: .center, spacing: 16) {
                            Spacer().frame(width: 44)

                            Image(product.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(product.name.count > 10 ? "\(product.name.prefix(9))..." : product.name)
                                    .font(.title2)
                                    .fontWeight(.bold)

                                Text(brand.title)
                                    .font(.subheadline)

                                Text("#\(product.id)")
                                    .font(.caption)
                                    .foregroundColor(.gray)

                                Text("$564")
                                    .font(.title3)
                                    .fontWeight(.bold)

//                                Button("BUY NOW") {
//                                    // Purchase logic
//                                }
//                                .font(.subheadline)
//                                .padding(.horizontal, 12)
//                                .padding(.vertical, 8)
//                                .background(Color.black)
//                                .foregroundColor(.white)
//                                .cornerRadius(6)
                            }
                        }
                        .padding(.horizontal)

                        // AR VIEW
                        Button("AR VIEW") {
                            showARView = true
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black))
                        .padding(.horizontal)
                        .sheet(isPresented: $showARView) {
                            ARQuickLookView(usdzFileName: "sneaker_airforce.usdz")
                        }

                        Divider().padding(.vertical)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Group {
                                Text("**Description**")
                                Text(product.description)

                                Text("**Material & care**")
                                Text(product.materialAndCare.replacingOccurrences(of: ". ", with: ".\n"))
                            }
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        }
                        .padding(.horizontal)

                        Divider().padding(.vertical)

                        // Authen Sec
                        VStack(spacing: 8) {
                            Text("**Check your product authenticity !**")
                                .font(.headline)

                            Text("Ensure the authenticity of your owned products...")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            Image(systemName: "checkmark.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.black)

                            Button("Authenticate Product") {
                                navigateToAuth = true
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(8)

                            NavigationLink(
                                destination: ProductAuthenticationView(),
                                isActive: $navigateToAuth
                            ) {
                                EmptyView()
                            }

                            Text("Once a serial verification is successfully completed...")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 40)
                }

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                }
                .padding(.leading, 16)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}
