struct UserProfileView: View {
    var user: User
    @State private var selectedTab: Tab = .profile

    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading, spacing: 20) {
                    // Profile Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hello, \(user.firstName) 👋")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("\(user.firstName) \(user.lastName)")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("\(user.age) years old")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image("profileIcon") // Placeholder image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }
                    .padding(.top, 16)
                    .padding([.horizontal, .bottom])

                    Divider()

                    // User Info Sections
                    VStack(spacing: 16) {
                        // Gender & Username
                        HStack {
                            Text("Gender")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text(user.gender)
                                .font(.body)
                                .foregroundColor(.black)
                        }

                        Divider()

                        HStack {
                            Text("Username")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text(user.username)
                                .font(.body)
                                .foregroundColor(.black)
                        }
                    }
                    .padding([.horizontal, .bottom])

                    // Edit Button
                    Button(action: {
                        // Action to Edit Profile
                    }) {
                        Text("Edit Profile")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.brandMainColor)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)

                    Spacer()
                }

                // Bottom Navigation Bar
                BottomNavBar(selectedTab: $selectedTab)
                    .padding(.bottom, 16)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUser = User(firstName: "Jane", lastName: "Smith", age: 25, gender: "Female", username: "jsmith", password: "password123")
        return UserProfileView(user: mockUser)
    }
}
