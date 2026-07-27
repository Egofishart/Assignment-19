//
//  NotesViewModel.swift
//  ნ.დანელია დავალება 19
//
//  Created by NikoDanelia on 28/07/2026.
//
import Foundation

class NotesViewModel {
    
    private let defaults = UserDefaults.standard
    private let storageKey = "savedNotes"
    
    var refreshUI: (() -> Void)?
    
    private(set) var notes: [Note] = [] {
        didSet {
            refreshUI?()
        }
    }
    
    init() {
        fetchNotes()
    }
    
    func fetchNotes() {
        guard let data = defaults.data(forKey: storageKey) else {
            notes = []
            return
        }
        if let decodedNotes = try? JSONDecoder().decode([Note].self, from: data) {
            self.notes = decodedNotes
        }
    }
    
    // მონაცემების შენახვა
    private func saveNotes() {
        let data = try? JSONEncoder().encode(notes)
        defaults.set(data, forKey: storageKey)
        defaults.synchronize()
    }
    

    func addOrUpdateNote(title: String, content: String, at index: Int?) {
        if let index = index, notes.indices.contains(index) {
            notes[index].title = title
            notes[index].content = content
        } else {
            let newNote = Note(title: title, content: content)
            notes.append(newNote)
        }
        saveNotes()
    }
    

    func deleteNote(at index: Int) {
        guard notes.indices.contains(index) else { return }
        notes.remove(at: index)
        saveNotes()
    }
}
