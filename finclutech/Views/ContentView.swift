import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer() // Pushes the logo and button towards the center
                Image("logo") // Replace "logo" with your actual image name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 330, height: 150) // Adjust the size as needed
                Spacer()
                
                NavigationLink(destination: LoginView()) {
                    Text("Login")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
