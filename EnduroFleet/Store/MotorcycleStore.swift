import Foundation

/// Datele aplicației, ținute doar în memorie (date false), cum cere lab 2.
/// Mai târziu (lab 4) doar acest fișier se schimbă ca să folosească o bază de date locală.
final class MotorcycleStore: ObservableObject {
    @Published private(set) var motorcycles: [Motorcycle]

    init(motorcycles: [Motorcycle] = MotorcycleStore.sampleData) {
        self.motorcycles = motorcycles
    }

    /// Create: adaugă doar elementul nou.
    func add(_ motorcycle: Motorcycle) {
        motorcycles.append(motorcycle)
    }

    /// Update: înlocuiește elementul cu același id, id-ul rămâne neschimbat.
    func update(_ motorcycle: Motorcycle) {
        guard let index = motorcycles.firstIndex(where: { $0.id == motorcycle.id }) else { return }
        motorcycles[index] = motorcycle
    }

    /// Delete: primește doar id-ul.
    func delete(id: UUID) {
        motorcycles.removeAll { $0.id == id }
    }

    func motorcycle(withID id: UUID) -> Motorcycle? {
        motorcycles.first { $0.id == id }
    }

    static let sampleData: [Motorcycle] = [
        Motorcycle(model: "KTM 300 EXC",
                   vinNumber: "VBKEXC300N0000001",
                   engineHours: 145.5, oilHours: 4, pistonHours: 32),
        Motorcycle(model: "KTM 250 EXC",
                   vinNumber: "VBKEXC250N0000002",
                   engineHours: 210, oilHours: 11.5, pistonHours: 85,
                   issues: "Clutch slipping on steep climbs."),
        Motorcycle(model: "KTM 350 EXC-F",
                   vinNumber: "VBKEXC350N0000003",
                   engineHours: 62, oilHours: 9, pistonHours: 62),
        Motorcycle(model: "Husqvarna TE 300",
                   vinNumber: "VBKTE300N00000004",
                   engineHours: 98, oilHours: 2, pistonHours: 18,
                   issues: "Front brake lever is loose."),
        Motorcycle(model: "Husqvarna TE 250",
                   vinNumber: "VBKTE250N00000005",
                   engineHours: 30, oilHours: 6, pistonHours: 30)
    ]
}
