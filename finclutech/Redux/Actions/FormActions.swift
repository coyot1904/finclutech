// Redux/Actions/FormActions.swift
import ReSwift

// Define the action to submit form data
struct SubmitFormAction: Action {
    let formData: [String: String]
}
