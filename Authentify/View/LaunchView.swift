//
//  LaunchView.swift
//  Authentify
//
//  Created by Knight.Wolf on 2025-04-10.
//
import SwiftUI

struct LaunchView: View {
    @State private var opacity = 0.0
    
    var body: some View {
        ZStack {
            Color(red: 41/255, green: 37/255, blue: 38/255).ignoresSafeArea()
            
            Text("Authentify")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
                .opacity(opacity)
                .offset(y: -50)
                .onAppear {
                    withAnimation(.easeIn(duration: 2.0)) {
                        opacity = 1.0
                    }
                }
        }
    }
}

#Preview {
    LaunchView()
}
