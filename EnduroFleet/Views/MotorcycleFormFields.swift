import SwiftUI

/// Câmpurile formularului, refolosite de ecranul Add și de ecranul Edit.
/// Fiecare câmp are o etichetă (titlul secțiunii) și afișează eroarea sub el.
struct MotorcycleFormFields: View {
    @Binding var form: MotorcycleForm
    let errors: MotorcycleForm.Errors

    var body: some View {
        Section("Model") {
            TextField("e.g. KTM 300 EXC", text: $form.model)
            ErrorText(errors.model)
        }

        Section("VIN number") {
            TextField("17 characters", text: $form.vin)
                .textInputAutocapitalization(.characters)
                .autocorrectionDisabled()
            ErrorText(errors.vin)
        }

        Section("Engine hours (total)") {
            TextField("e.g. 145.5", text: $form.engineHours)
                .keyboardType(.decimalPad)
            ErrorText(errors.engineHours)
        }

        Section("Hours since last oil change") {
            TextField("e.g. 4", text: $form.oilHours)
                .keyboardType(.decimalPad)
            ErrorText(errors.oilHours)
        }

        Section("Hours since last piston change") {
            TextField("e.g. 32", text: $form.pistonHours)
                .keyboardType(.decimalPad)
            ErrorText(errors.pistonHours)
        }

        Section("Issues") {
            TextEditor(text: $form.issues)
                .frame(minHeight: 90)
        }
    }
}

private struct ErrorText: View {
    let message: String?

    init(_ message: String?) {
        self.message = message
    }

    var body: some View {
        if let message {
            Text(message)
                .font(.caption)
                .foregroundStyle(.red)
        }
    }
}
