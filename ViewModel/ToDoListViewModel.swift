import SwiftUI

final class ToDoListViewModel: ObservableObject {
        
        private let repository: ToDoListRepositoryType
        
        // MARK: - Initialization
        init(repository: ToDoListRepositoryType) {
                self.repository = repository
                self.toDoItems = repository.loadToDoItems()
                applyFilter(at: self.currentFilter.rawValue) // Appel initial pour définir filteredToDoItems basé sur le filtre par défaut (.all)
        }
        
        // MARK: - Outputs->Données observables publiées
        @Published var toDoItems: [ToDoItem] = [] {
                didSet {
                        repository.saveToDoItems(toDoItems)
                        applyFilter(at: self.currentFilter.rawValue) //Appliquer le filtre actuel quand la liste complète change
                }
        }
        
        @Published var currentFilter: ToDoListFilter = .all {
                didSet {
                        applyFilter(at: currentFilter.rawValue) // Appliquer le nouveau filtre sélectionné
                }
        }
        
        /// Liste filtrée à afficher selon le filtre actif
        @Published private(set) var filteredToDoItems: [ToDoItem] = []
        
        // MARK: - INPUTS. Fonctions appelées par la vue
        
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
        /// basé sur l'index fourni (correspondant au rawValue de ToDoListFilter).
        // pour pouvoir la tester, il faut un paramètre à la fonction.
        // La fonction n'est plus 'private' pour être accessible par les tests.
        func applyFilter(at index: Int) {
                let filterToApply = ToDoListFilter(rawValue: index) ?? .all
                
                switch filterToApply {
                case .all:
                        filteredToDoItems = toDoItems
                case .active:
                        filteredToDoItems = toDoItems.filter { !$0.isDone }
                case .completed:
                        filteredToDoItems = toDoItems.filter { $0.isDone }
                }
        }
}
