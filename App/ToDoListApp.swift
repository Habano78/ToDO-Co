import SwiftUI
// On déclare ici la vue principale (ToDoListView) à lancer au démarrage.
// On injecte égalementle ViewModel qui lui reçoit un Repository.
@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ToDoListView(
                viewModel: ToDoListViewModel(
                    repository: ToDoListRepository()
                )
            )
        }
    }
}
