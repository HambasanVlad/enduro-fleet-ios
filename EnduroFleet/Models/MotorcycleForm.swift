import Foundation

/// Starea formularelor Add/Edit. Câmpurile sunt text, pentru că așa le dă utilizatorul;
/// le validăm și le convertim în `Motorcycle` abia la salvare.
struct MotorcycleForm {
    var model = ""
    var vin = ""
    var engineHours = ""
    var oilHours = ""
    var pistonHours = ""
    var issues = ""

    init() {}

    /// Formular precompletat cu valorile existente (pentru Edit).
    init(from m: Motorcycle) {
        model = m.model
        vin = m.vinNumber
        engineHours = Self.format(m.engineHours)
        oilHours = Self.format(m.oilHours)
        pistonHours = Self.format(m.pistonHours)
        issues = m.issues
    }

    /// Un mesaj de eroare (sau nil) pentru fiecare câmp.
    struct Errors {
        var model: String?
        var vin: String?
        var engineHours: String?
        var oilHours: String?
        var pistonHours: String?

        var isEmpty: Bool {
            model == nil && vin == nil && engineHours == nil
                && oilHours == nil && pistonHours == nil
        }
    }

    func validate() -> Errors {
        var e = Errors()

        if model.trimmed.isEmpty {
            e.model = "Model is required."
        }

        let vinValue = vin.trimmed
        if vinValue.count != 17 || !vinValue.allSatisfy({ $0.isLetter || $0.isNumber }) {
            e.vin = "VIN must have exactly 17 letters/digits."
        }

        let engine = Self.parse(engineHours)
        if engine == nil || engine! < 0 {
            e.engineHours = "Enter a number, 0 or more."
        }

        let oil = Self.parse(oilHours)
        if oil == nil || oil! < 0 {
            e.oilHours = "Enter a number, 0 or more."
        } else if let engine, engine >= 0, oil! > engine {
            e.oilHours = "Cannot be more than the engine hours."
        }

        let piston = Self.parse(pistonHours)
        if piston == nil || piston! < 0 {
            e.pistonHours = "Enter a number, 0 or more."
        } else if let engine, engine >= 0, piston! > engine {
            e.pistonHours = "Cannot be more than the engine hours."
        }

        return e
    }

    /// Construiește motocicleta. Se apelează doar după ce `validate()` nu a găsit erori.
    func build(id: UUID = UUID()) -> Motorcycle? {
        guard let engine = Self.parse(engineHours),
              let oil = Self.parse(oilHours),
              let piston = Self.parse(pistonHours) else { return nil }
        return Motorcycle(id: id,
                          model: model.trimmed,
                          vinNumber: vin.trimmed.uppercased(),
                          engineHours: engine,
                          oilHours: oil,
                          pistonHours: piston,
                          issues: issues.trimmed)
    }

    // MARK: - Helpers

    /// Acceptă și "12,5" (tastatura în română) și "12.5".
    static func parse(_ text: String) -> Double? {
        Double(text.trimmed.replacingOccurrences(of: ",", with: "."))
    }

    static func format(_ value: Double) -> String {
        value == value.rounded() ? String(Int(value)) : String(value)
    }
}

private extension String {
    var trimmed: String { trimmingCharacters(in: .whitespacesAndNewlines) }
}
