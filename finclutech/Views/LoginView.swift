import SwiftUI
import Validator

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    @State private var isLoggedIn: Bool = false

    let validUsername = "testuser"
    let validPassword = "password123"
    
    var body: some View {
            VStack(spacing: 30) {
                Spacer()
                Text("SEND MONEY APP")
                    .font(.system(size: 24))
                    .bold()
                    .foregroundColor(Color("696969"))
                
                Text("Welcome to send money app")
                    .font(.system(size: 14))
                    .foregroundColor(Color("A9A9A9"))

                TextField("Username", text: $username)
                    .padding(.horizontal, 10)
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                    )
                    .autocapitalization(.none)

                SecureField("Password", text: $password)
                    .padding(.horizontal, 10)
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                    )
                    .autocapitalization(.none)
                

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                }

                Button(action: {
                    authenticateUser()
                }) {
                    Text("Sign in")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("B0C4DE"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Spacer()
                Text("By proceeding you also agree to the Terms of Service  and Privacy Policy")
                    .font(.system(size: 14))
                    .foregroundColor(Color("A9A9A9"))
                    .padding(15)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                NavigationLink(destination: MainScreenView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("F8F8FF"))
            .navigationBarTitle(Text("Sign In"),
                                displayMode: .inline)
        
    }

    private func authenticateUser() {
        let usernameValidation = username.isEmpty
        let passwordValidation = password.isEmpty

        if usernameValidation {
            errorMessage = "Username cannot be empty"
            return
        }

        if passwordValidation {
            errorMessage = "Password cannot be empty"
            return
        }
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
