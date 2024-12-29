// Redux/Reducers/FormReducer.swift
import ReSwift

// Reducer to handle the actions
func formReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    switch action {
    case let action as SubmitFormAction:
        // Update the state with the form data
        state.formData.append(action.formData)
    default:
        break
    }
    
    return state
}
