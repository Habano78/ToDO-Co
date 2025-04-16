// C'est le modèle-type de l'application.
// ToDoItem est conforme aux protocoles Equatable, Codable, Identifiable.
// Chaque "ToDoItem" aura trois propriétés, dont une (id) au service de l'identification de chaque  d' et un id unique

import Foundation

struct ToDoItem: Equatable, Codable, Identifiable {
    var id = UUID()
    var title: String
    var isDone: Bool = false
}
