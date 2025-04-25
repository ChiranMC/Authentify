struct LaunchView: View {
    @State private var opacity = 0.0
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            Text("Authentify")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 2.0)) {
                        opacity = 1.0
                    }
                }
        }
    }
}