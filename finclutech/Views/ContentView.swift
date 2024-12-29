import SwiftUI

struct ContentView: View {
    @State private var navigateToLogin = false
    @State private var isLoading = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 330, height: 150)
                Spacer()
                
                HStack {

                ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .padding(.leading, 10)
                    
                }
                .padding()
                
                NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                    EmptyView()
                }
                .hidden()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    navigateToLogin = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
