import Foundation

func loadJSON<T: Decodable>(from filename: String, as type: T.Type = T.self) -> T? {
    guard let fileURL = Bundle.main.url(forResource: filename, withExtension: nil) else {
        print("File not found: \(filename)")
        return nil
    }
    do {
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    } catch {
        print("Error decoding JSON: \(error.localizedDescription)")
        print("Error details: \(error)")
    }
    return nil
}

func loadForm(from filename: String) -> [FormField]? {
    // Get the path to the JSON file
    if let path = Bundle.main.path(forResource: filename, ofType: "json") {
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            
            // Decode the data into an array of FormField objects
            let decoder = JSONDecoder()
            let formFields = try decoder.decode([FormField].self, from: data)
            return formFields
        } catch {
            print("Error loading or decoding JSON: \(error)")
        }
    } else {
        print("File not found: \(filename).json")
    }
    return nil
}



