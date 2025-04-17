import SwiftUI

final class ToDoListViewModel: ObservableObject {
    private let repository: ToDoListRepositoryType

    // MARK: - Init
    init(repository: ToDoListRepositoryType) {
        self.repository = repository
        self.toDoItems = repository.loadToDoItems()
        applyFilter()
    }

    // MARK: - Données observables publiées

    /// Liste complète de toutes les tâches (source principale)
    @Published var toDoItems: [ToDoItem] = [] {
        didSet {
            repository.saveToDoItems(toDoItems)
            applyFilter() // ✅ Mise à jour automatique de la liste filtrée
        }
    }

    /// Filtre actuellement sélectionné (ex: All, Active, Completed)
    @Published var currentFilter: ToDoListFilter = .all {
        didSet {
            applyFilter()
        }
    }

    /// Liste filtrée à afficher selon le filtre actif
    @Published private(set) var filteredToDoItems: [ToDoItem] = []

    // MARK: - Fonctions appelées par la vue

    /// Ajoute une nouvelle tâche
    func add(item: ToDoItem) {
        toDoItems.append(item)
    }

    /// Bascule l'état (fait / non fait) d'une tâche
    func toggleTodoItemCompletion(_ item: ToDoItem) {
        if let index = toDoItems.firstIndex(where: { $0.id == item.id }) {
            toDoItems[index].isDone.toggle()
        }
    }

    /// Supprime une tâche
    func removeTodoItem(_ item: ToDoItem) {
        toDoItems.removeAll { $0.id == item.id }
    }

    // MARK: - Filtrage interne

    /// Applique le filtre sélectionné pour mettre à jour `filteredToDoItems`
    private func applyFilter() {
        switch currentFilter {
        case .all:
            filteredToDoItems = toDoItems
        case .active:
            filteredToDoItems = toDoItems.filter { !$0.isDone }
        case .completed:
            filteredToDoItems = toDoItems.filter { $0.isDone }
        }
    }
}

