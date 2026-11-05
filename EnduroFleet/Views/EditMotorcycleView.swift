import SwiftUI

/// Ecranul Update: separat de listă, câmpurile sunt precompletate.
struct EditMotorcycleView: View {
    @EnvironmentObject private var store: MotorcycleStore
    @Environment(\.dismiss) private var dismiss

    private let motorcycleID: UUID
    @State private var form: MotorcycleForm
    @State private var errors = MotorcycleForm.Errors()

    init(motorcycle: Motorcycle) {
        motorcycleID = motorcycle.id
        _form = State(initialValue: MotorcycleForm(from: motorcycle))
    }

    var body: some View {
        Form {
            MotorcycleFormFields(form: $form, errors: errors)
        }
        .navigationTitle("Edit Motorcycle")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") { save() }
            }
        }
    }

    private func save() {
        errors = form.validate()
        // același id, deci elementul este actualizat, nu șters și re-adăugat
        guard errors.isEmpty, let updated = form.build(id: motorcycleID) else { return }
        store.update(updated)
        dismiss()
    }
}
