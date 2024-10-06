//
//  Validator.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/3/24.
//

import SwiftUI

// MARK: - Validator Class
class Validator: ObservableObject {
    // Published properties to trigger view updates
    @Published var rows: [Row]
    @Published private(set) var isValid: Bool = false
    
    // Initialize with an array of rows
    init(rows: [Row]) {
        self.rows = rows
        updateValidation()
    }
    
    // Add new rows to the validator
    func add(_ newRows: [Row]) {
        rows.append(contentsOf: newRows)
        updateValidation()
    }
    
    // Remove specified rows from the validator
    func remove(_ rowsToRemove: [Row]) {
        rows.removeAll { row in rowsToRemove.contains(where: { $0.id == row.id }) }
        updateValidation()
    }
    
    // Update the overall validation status
    private func updateValidation() {
        isValid = rows.allSatisfy { !$0.isEmpty }
    }
}

// MARK: - Row Structure
struct Row: Identifiable {
    let id: UUID
    let tag: String
    @Binding var value: String
    
    // Check if the row is empty (for validation)
    var isEmpty: Bool {
        value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

// MARK: - ContentView
struct ContentView: View {
    // StateObject to manage the validator
    @StateObject private var validator = Validator(rows: [])
    // State for new row input
    @State private var newRowValue = ""
    
    var body: some View {
        VStack {
            // List of existing rows
            List {
                ForEach(validator.rows) { row in
                    TextField(row.tag, text: row.$value)
                }
                .onDelete(perform: deleteRows)
            }
            
            // Input for adding new rows
            HStack {
                TextField("New Row", text: $newRowValue)
                Button("Add Row") {
                    addRow()
                }
            }
            .padding()
            
            // Display overall validation status
            Text("Form is \(validator.isValid ? "valid" : "invalid")")
                .foregroundColor(validator.isValid ? .green : .red)
        }
    }
    
    // Function to add a new row
    private func addRow() {
        let newRow = Row(id: UUID(), tag: "Row \(validator.rows.count + 1)", value: $newRowValue)
        validator.add([newRow])
        newRowValue = ""
    }
    
    // Function to delete rows (used with .onDelete)
    private func deleteRows(at offsets: IndexSet) {
        let rowsToRemove = offsets.map { validator.rows[$0] }
        validator.remove(rowsToRemove)
    }
}
