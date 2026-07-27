//
//  NoteDetailViewModel.swift
//  ნ.დანელია დავალება 19
//
//  Created by NikoDanelia on 28/07/2026.
//

import Foundation

class NoteDetailViewModel {
    
    // მონაცემები
    let selectedNote: Note?
    let noteIndex: Int?
    
  
    var initialTitle: String {
        return selectedNote?.title ?? ""
    }
    
    var initialContent: String {
        return selectedNote?.content ?? ""
    }
    
    
    var isEditing: Bool {
        return noteIndex != nil
    }
    
    init(selectedNote: Note? = nil, noteIndex: Int? = nil) {
        self.selectedNote = selectedNote
        self.noteIndex = noteIndex
    }
    
    func validateAndSave(title: String?, content: String?, completion: (String, String, Int?) -> Void) {
        guard let title = title, !title.isEmpty,
              let content = content, !content.isEmpty else {
            return
        }
        completion(title, content, noteIndex)
    }
}
