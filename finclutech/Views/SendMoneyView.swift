import SwiftUI
import ReSwift

struct SendMoneyView: View {
    @State private var formFields: [FormField] = []
    @State private var formValues: [String: String] = [:] // Holds user input
    @State private var selectedLanguage: String = "en" // Default language is English
    @State private var selectedProvider: Provider? = nil // Track the selected provider
    @State private var requiredFields: [Field] = []
    @State private var isFormSubmitted: Bool = false

    var body: some View {
        GeometryReader { geometry in
                ScrollView {
                    VStack {
                        // Language Picker
                        Picker("Language", selection: $selectedLanguage) {
                            Text("English").tag("en")
                            Text("Arabic").tag("ar")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        
                        // Dynamic Form
                        ForEach(formFields) { field in
                            if let providers = field.providers {
                                // Label
                                Text(field.label[selectedLanguage] ?? "Unknown")
                                    .font(.headline)
                                    .padding(.top)
                                    .frame(maxWidth: .infinity, alignment: selectedLanguage == "ar" ? .trailing : .leading)
                                
                                // Dropdown Menu
                                Menu {
                                    ForEach(providers, id: \.name) { provider in
                                        Button(provider.name) {
                                            selectedProvider = provider
                                            requiredFields = provider.requiredFields ?? []
                                            formValues[field.label[selectedLanguage] ?? ""] = provider.name
                                        }
                                    }
                                } label: {
                                    HStack {
                                        if selectedLanguage == "ar" {
                                            // Arabic: Image first, then text
                                            Image(systemName: "chevron.down")
                                            Text(formValues[field.label[selectedLanguage] ?? ""] ?? "انتخب")
                                                .foregroundColor(.black)
                                                .frame(maxWidth: .infinity, alignment: selectedLanguage == "ar" ? .trailing : .leading)
                                        } else {
                                            // English: Text first, then image
                                            Text(formValues[field.label[selectedLanguage] ?? ""] ?? "Select")
                                                .foregroundColor(.black)
                                                .frame(maxWidth: .infinity, alignment: selectedLanguage == "ar" ? .trailing : .leading)
                                            Image(systemName: "chevron.down")
                                        }
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading) // Or use .trailing for Arabic
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                                }
                                .padding(.bottom)
                            } else {
                                Text("Unsupported field type: \(field.type)")
                            }
                            // Render the required fields for the selected provider
                        }
                        if let selectedProvider = selectedProvider {
                            ForEach(requiredFields) { requiredField in
                                // Render input fields based on requiredField type
                                Text(requiredField.label[selectedLanguage] ?? "")
                                    .font(.headline)
                                    .padding(.top)
                                    .frame(maxWidth: .infinity, alignment: selectedLanguage == "ar" ? .trailing : .leading)
                                if requiredField.type == "text" {
                                    
                                    TextField(requiredField.label[selectedLanguage] ?? "Enter value",
                                              text: Binding(
                                                get: { formValues[requiredField.name] ?? "" },
                                                set: { formValues[requiredField.name] = $0 }
                                              ))
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
                                } else if requiredField.type == "number" {
                                    TextField(requiredField.label[selectedLanguage] ?? "Enter number",
                                              text: Binding(
                                                get: { formValues[requiredField.name] ?? "" },
                                                set: { formValues[requiredField.name] = $0 }
                                              ))
                                    .keyboardType(.numberPad) // Numeric keyboard for general numbers
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
                                } else if requiredField.type == "msisdn" {
                                    TextField(requiredField.label[selectedLanguage] ?? "Enter phone number",
                                              text: Binding(
                                                get: { formValues[requiredField.name] ?? "" },
                                                set: { formValues[requiredField.name] = $0 }
                                              ))
                                    .keyboardType(.phonePad) // Phone keypad
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
                                } else if requiredField.type == "option" {
                                    let staticoption = [
                                        ["label": "Abu Dhabi", "name": "abu_dhabi"],
                                        ["label": "Dubai", "name": "dubai"]
                                    ]
                                    Menu {
                                        ForEach(staticoption, id: \.self) { option in
                                            Button(option["label"] ?? "Unknown") {
                                                formValues[requiredField.name] = option["name"] ?? ""
                                            }
                                        }
                                    } label: {
                                        HStack {
                                            Text(formValues[requiredField.name] ?? "Select")
                                                .foregroundColor(.black)
                                                .frame(maxWidth: .infinity, alignment: selectedLanguage == "ar" ? .trailing : .leading)
                                            Image(systemName: "chevron.down")
                                        }
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(8)
                                    }
                                    .padding(.bottom)
                                }
                                else {
                                    Text("Unsupported required field type: \(requiredField.type)")
                                }
                            }
                        }
                        
                        Spacer()
                        Button(action: {
                            handleSubmit()
                        }) {
                            Text("Send Money")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("B0C4DE"))
                                .cornerRadius(10)
                        }
                        .padding(.top)
                        
                    }
                    .padding()
                    .background(Color("F8F8FF")) // Set background color for the VStack
                    .navigationBarTitle(Text("SEND MOENY APP"), displayMode: .inline) // Set navigation bar title
                    .onAppear {
                        loadFormData()
                    }
                    NavigationLink(destination: MainScreenView(), isActive: $isFormSubmitted) {
                        EmptyView() // This will trigger the navigation when isFormSubmitted is true
                    }
                }
            }.background(Color("F8F8FF"))
    }
    
    // Handle Form Submission
    func handleSubmit() {
        // Process the form values, like sending them to an API or saving locally
        store.dispatch(SubmitFormAction(formData: formValues))
        print("Form submitted with data: \(formValues)")
        isFormSubmitted = true
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

struct SendMoneyView_Previews: PreviewProvider {
    static var previews: some View {
        SendMoneyView()
    }
}
