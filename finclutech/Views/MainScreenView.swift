import SwiftUI
import ReSwift

struct MainScreenView: View {
    @StateObject private var viewStore = ViewStore(store: store)
    
    var body: some View {
        VStack(spacing: 30) {
            if viewStore.state.formData.isEmpty {
                // Display a message when the list is empty
                Text("No transactions stored in the app.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                // Display the list when there are transactions
                List(viewStore.state.formData, id: \.self) { transaction in
                    VStack(alignment: .leading) {
                        // Display each key-value pair of the transaction
                        ForEach(transaction.keys.sorted(), id: \.self) { key in
                            Text("\(key): \(transaction[key] ?? "")")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        // Button to show details in JSON format
                        NavigationLink(destination: JSONDetailView(transaction: transaction)) {
                            Text("View JSON Details")
                                .font(.footnote)
                                .foregroundColor(.blue)
                                .padding(.top, 5)
                        }
                    }
                    .padding()
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("F8F8FF"))
        .navigationBarTitle(Text("Transactions List"), displayMode: .inline)
        .navigationBarItems(
            trailing: NavigationLink(destination: SendMoneyView()) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }
        )
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
