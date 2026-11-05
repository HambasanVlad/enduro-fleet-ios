import SwiftUI

/// Ecranul Create: separat de listă, cu validare în același ecran.
struct AddMotorcycleView: View {
    @EnvironmentObject private var store: MotorcycleStore
    @Environment(\.dismiss) private var dismiss

    @State private var form = MotorcycleForm()
    @State private var errors = MotorcycleForm.Errors()

    var body: some View {
        Form {
            MotorcycleFormFields(form: $form, errors: errors)
        }
        .navigationTitle("Add Motorcycle")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Add") { save() }
            }
        }
    }

    private func save() {
        errors = form.validate()
        guard errors.isEmpty, let motorcycle = form.build() else { return }
        store.add(motorcycle)   // doar elementul nou ajunge în listă
        dismiss()
    }
}
