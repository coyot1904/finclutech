// Redux/Store/Store.swift
import ReSwift

// Initialize the store
let store = Store<AppState>(
    reducer: formReducer,
    state: nil
)
