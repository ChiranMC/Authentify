//
//  LaunchView.swift
//  Authentify
//
//  Created by Knight.Wolf on 2025-04-10.
//
import SwiftUI

struct LaunchView: View {
    @State private var opacity = 0.0
    @State private var navigateToLogin = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 41/255, green: 37/255, blue: 38/255)
                    .ignoresSafeArea()
                
                Text("Authentify")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .opacity(opacity)
                    .offset(y: -50)
                    .onAppear {
                        withAnimation(.easeIn(duration: 2.0)) {
                            opacity = 1.0
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            navigateToLogin = true
                        }
                    }

                // Hidden navigation link triggered by state
                NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    LaunchView()
}
