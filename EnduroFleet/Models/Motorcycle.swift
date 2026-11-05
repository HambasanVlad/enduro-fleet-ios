import Foundation

/// O motocicletă din flota Power Riders Tours.
struct Motorcycle: Identifiable, Equatable {
    let id: UUID                // identificator intern, utilizatorul nu îl vede
    var model: String           // ex. KTM 300 EXC
    var vinNumber: String       // număr de identificare (VIN), 17 caractere
    var engineHours: Double     // ore totale de funcționare ale motorului
    var oilHours: Double        // ore de la ultima schimbare de ulei
    var pistonHours: Double     // ore de la ultima schimbare de piston
    var issues: String          // probleme cunoscute (text liber)

    init(id: UUID = UUID(),
         model: String,
         vinNumber: String,
         engineHours: Double,
         oilHours: Double,
         pistonHours: Double,
         issues: String = "") {
        self.id = id
        self.model = model
        self.vinNumber = vinNumber
        self.engineHours = engineHours
        self.oilHours = oilHours
        self.pistonHours = pistonHours
        self.issues = issues
    }

    // Intervale de service (le poți schimba oricând aici).
    static let oilInterval = 10.0
    static let pistonInterval = 80.0

    var needsOilChange: Bool { oilHours >= Motorcycle.oilInterval }
    var needsPistonChange: Bool { pistonHours >= Motorcycle.pistonInterval }
    var hasIssues: Bool {
        !issues.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
