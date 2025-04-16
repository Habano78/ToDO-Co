//
//  ToDoListFilter.swift
//  ToDoList
//
//  Created by Perez William on 16/04/2025.
//
import Foundation

/// Defines the available filter options for the To-Do list.
/// Conforms to Int for raw values, CaseIterable to easily get all cases,
/// and Identifiable for use in SwiftUI Pickers and ForEach loops.
enum ToDoListFilter: Int, CaseIterable, Identifiable {
    case all, active, completed

    /// Conformance to Identifiable: Uses the raw Int value as the stable identifier.
    var id: Int { rawValue }

    /// Provides a user-friendly title for each filter case.
    var title: String {
        switch self {
        case .all: return "All"       // Show all tasks
        case .active: return "Active"   // Show only tasks that are not done
        case .completed: return "Completed" // Show only tasks that are done
        }
    }
}
