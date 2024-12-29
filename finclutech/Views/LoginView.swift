import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    @State private var isLoggedIn: Bool = false

    let validUsername = "testuser"
    let validPassword = "password123"
    
    
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() 
        appearance.backgroundColor = UIColor.systemBlue // Change to your desired UIColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Change title color
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // Change large title color

        // Set the custom appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()

                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button(action: {
                    authenticateUser()
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                NavigationLink(destination: MainScreenView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
            }
            .padding()
            .navigationBarTitle(Text("Login"),
                                displayMode: .inline)
        
    }

    private func authenticateUser() {
        if username == validUsername && password == validPassword {
            isLoggedIn = true
            errorMessage = nil
        } else {
            errorMessage = "Invalid username or password"
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
