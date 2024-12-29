import Foundation
import SwiftUI

struct FormWrapper: Decodable {
    let services: [FormField]
}

struct FormField: Identifiable, Decodable {
    var id: UUID = UUID()
    let type: String
    let label: [String: String]
    let placeholder: String?
    let providers: [Provider]?
    
    private enum CodingKeys: String, CodingKey {
        case type, label, placeholder, providers
    }
}

struct Provider: Identifiable, Decodable {
    var id: UUID = UUID() // Automatically generate a unique ID
    let name: String
    let providerID: String // Renamed to avoid conflict with `id` property
    let requiredFields: [Field]?

    private enum CodingKeys: String, CodingKey {
        case name
        case providerID = "id" // Map "id" from JSON to "providerID"
        case requiredFields = "required_fields"
    }
}

struct Field: Identifiable, Decodable {
    var id: UUID = UUID() // Automatically generate a unique ID
    let name: String
    let label: [String: String]
    let placeholder: StringOrDictionary?
    let type: String
    let validation: String?
    let maxLength: StringOrInt?
    let validationErrorMessage: StringOrDictionary?

    private enum CodingKeys: String, CodingKey {
        case name
        case label
        case placeholder
        case type
        case validation
        case maxLength = "max_length"
        case validationErrorMessage = "validation_error_message"
    }
}

struct StringOrDictionary: Decodable {
    let value: String?
    let localizedValue: [String: String]?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let stringValue = try? container.decode(String.self) {
            value = stringValue
            localizedValue = nil
        } else if let dictionaryValue = try? container.decode([String: String].self) {
            value = nil
            localizedValue = dictionaryValue
        } else {
            value = nil
            localizedValue = nil
        }
    }
}

struct StringOrInt: Decodable {
    let value: Int?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            value = intValue
        } else if let stringValue = try? container.decode(String.self), let intValue = Int(stringValue) {
            value = intValue
        } else {
            value = nil
        }
    }
}



class SendMoneyViewModel: ObservableObject {
    @Published var formFields: [FormField] = []
    
    init() {
        loadFormData()
    }
    
    func loadFormData() {
        guard let url = Bundle.main.url(forResource: "sendMoneyData", withExtension: "json") else {
            print("JSON file not found.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let formWrapper = try decoder.decode(FormWrapper.self, from: data)
            self.formFields = formWrapper.services
            print("Form data loaded: \(self.formFields)")
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}

