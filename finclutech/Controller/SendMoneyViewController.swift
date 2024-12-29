import UIKit

class DynamicFormViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var formFields: [FormField] = []
    var textFields: [UITextField] = []
    var pickerViews: [UIPickerView] = []
    var selectedCountry: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load form data from JSON
        if let formData = loadForm(from: "sendMoneyData") {
            formFields = formData
            createForm()
        }
    }

    // Function to create the form dynamically
    func createForm() {
        var yOffset: CGFloat = 20.0 // Starting position for the form
        
        for field in formFields {
            let label = UILabel(frame: CGRect(x: 20, y: yOffset, width: 200, height: 30))
            self.view.addSubview(label)
            
            yOffset += 35.0
            
            // Create a TextField for text input
            if field.type == "text" {
                let textField = UITextField(frame: CGRect(x: 20, y: yOffset, width: self.view.frame.width - 40, height: 40))
                textField.placeholder = field.placeholder
                textField.borderStyle = .roundedRect
                self.view.addSubview(textField)
                textFields.append(textField)
            }
            
            // Create a PickerView for dropdown input
            if field.type == "dropdown" {
                let pickerView = UIPickerView(frame: CGRect(x: 20, y: yOffset, width: self.view.frame.width - 40, height: 40))
                pickerView.delegate = self
                pickerView.dataSource = self
                self.view.addSubview(pickerView)
                pickerViews.append(pickerView)
                selectedCountry = field.providers?.first?.name // Default to the first option
            }
            
            yOffset += 50.0 // Adjust the vertical offset for the next field
        }
    }
    
    // UIPickerView delegate methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Find the dropdown options for the current picker view
        if let field = formFields.first(where: { $0.type == "dropdown" }) {
            return field.providers?.count ?? 0
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let field = formFields.first(where: { $0.type == "dropdown" }) {
            return field.providers?[row].name
        }
        return nil
    }
    
    // Function to handle when the form is submitted (optional)
    @objc func submitForm() {
        // Collect the form data (you can extend this to collect all fields)
        let formData = textFields.map { $0.text ?? "" }
        print("Form Data: \(formData)")
        print("Selected Country: \(selectedCountry ?? "")")
    }
}
