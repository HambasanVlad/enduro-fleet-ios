import SwiftUI

/// Ecranul principal (Read): lista flotei, cu swipe pentru Delete și confirmare.
struct MotorcycleListView: View {
    @EnvironmentObject private var store: MotorcycleStore

    @State private var showingAdd = false
    @State private var pendingDeleteID: UUID?

    var body: some View {
        NavigationStack {
            List {
                // ForEach identifică rândurile după `id`, deci la add/update/delete SwiftUI
                // inserează / redesenează / scoate doar rândul afectat, nu reconstruiește lista.
                ForEach(store.motorcycles) { motorcycle in
                    // tap pe rând deschide ecranul Edit (se trimite doar id-ul)
                    NavigationLink(value: motorcycle.id) {
                        MotorcycleRow(motorcycle: motorcycle)
                            .equatable()   // rândurile nemodificate nu sunt redesenate
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        // Fără role: .destructive, altfel List ascunde rândul înainte de confirmare.
                        Button {
                            pendingDeleteID = motorcycle.id
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                    }
                }
            }
            .overlay {
                if store.motorcycles.isEmpty {
                    Text("No motorcycles yet. Tap + to add one.")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Fleet")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Add motorcycle")
                }
            }
            .navigationDestination(for: UUID.self) { id in
                if let motorcycle = store.motorcycle(withID: id) {
                    EditMotorcycleView(motorcycle: motorcycle)
                }
            }
            .navigationDestination(isPresented: $showingAdd) {
                AddMotorcycleView()
            }
            .alert("Delete motorcycle?",
                   isPresented: Binding(
                    get: { pendingDeleteID != nil },
                    set: { if !$0 { pendingDeleteID = nil } }),
                   presenting: pendingDeleteID) { id in
                Button("Delete", role: .destructive) {
                    store.delete(id: id)   // doar id-ul elementului șters
                }
                Button("Cancel", role: .cancel) {}
            } message: { id in
                Text("\(store.motorcycle(withID: id)?.model ?? "This motorcycle") will be removed from the fleet.")
            }
        }
    }
}

private struct MotorcycleRow: View, Equatable {
    let motorcycle: Motorcycle

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(motorcycle.model)
                .font(.headline)
            Text("VIN \(motorcycle.vinNumber)")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text("Engine: \(MotorcycleForm.format(motorcycle.engineHours)) h  ·  Oil: \(MotorcycleForm.format(motorcycle.oilHours)) h  ·  Piston: \(MotorcycleForm.format(motorcycle.pistonHours)) h")
                .font(.footnote)

            HStack(spacing: 6) {
                if motorcycle.needsOilChange { Badge(text: "Oil due", color: .orange) }
                if motorcycle.needsPistonChange { Badge(text: "Piston due", color: .orange) }
                if motorcycle.hasIssues { Badge(text: "Issues", color: .red) }
            }
        }
        .padding(.vertical, 2)
    }
}

private struct Badge: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.caption2.bold())
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(color.opacity(0.2))
            .foregroundStyle(color)
            .clipShape(Capsule())
    }
}
