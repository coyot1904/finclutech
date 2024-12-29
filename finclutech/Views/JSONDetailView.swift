import SwiftUI


struct JSONDetailView: View {
    var transaction: [String: String]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Transaction Details in JSON:")
                    .font(.system(size: 16))
                    .padding(.bottom)
                
                Text(transactionAsJSON())
                    .font(.body)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
            }
            .padding()
        }
        .navigationBarTitle(Text("Transaction JSON"), displayMode: .inline)
    }

    // Converts the transaction dictionary into a formatted JSON string
    func transactionAsJSON() -> String {
        if let jsonData = try? JSONSerialization.data(withJSONObject: transaction, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
        return "{}" // Return an empty JSON if conversion fails
    }
}
