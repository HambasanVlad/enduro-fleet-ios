import SwiftUI

@main
struct EnduroFleetApp: App {
    @StateObject private var store = MotorcycleStore()

    var body: some Scene {
        WindowGroup {
            MotorcycleListView()
                .environmentObject(store)
        }
    }
}
