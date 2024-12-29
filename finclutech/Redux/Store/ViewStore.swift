// Redux/Store/ViewStore.swift
import SwiftUI
import ReSwift

class ViewStore: ObservableObject {
    private var store: Store<AppState>
    private var observer: StoreSubscriberHelper?

    @Published var state: AppState

    init(store: Store<AppState>) {
        self.store = store
        self.state = store.state

        // Subscribe to the store to update the SwiftUI views when the state changes
        self.observer = StoreSubscriberHelper(store: store, state: self)
    }

    deinit {
        // Clean up the observer
        observer?.unsubscribe()
    }
}

// Helper class to listen to state changes
class StoreSubscriberHelper: StoreSubscriber {
    private var store: Store<AppState>
    private var statePublisher: ViewStore

    init(store: Store<AppState>, state: ViewStore) {
        self.store = store
        self.statePublisher = state
        store.subscribe(self)
    }

    func newState(state: AppState) {
        // Update the state in ViewStore when the store state changes
        statePublisher.state = state
    }

    func unsubscribe() {
        store.unsubscribe(self)
    }
}
