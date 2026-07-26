//
//  NoteDetailViewController.swift
//  ნ.დანელია დავალება 13
//
//  Created by NikoDanelia on 27/06/2026.
//

import UIKit

// 1პროტოკოლი უკან მონაცემების დასაბრუნებლად (Delegation)
protocol NoteDetailDelegate: AnyObject {
    func didSave(title: String, content: String, at index: Int?)
    func didDelete(at index: Int)
}

class NoteDetailViewController: UIViewController {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextView!
    
        //2
    weak var delegate: NoteDetailDelegate?
    
    var selectedNote: Note?
    var noteIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        //  შენახვის ღილაკს
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        
        if noteIndex != nil {
                let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
                deleteButton.tintColor = .systemRed
                navigationItem.rightBarButtonItems = [saveButton, deleteButton]
            } else {
                navigationItem.rightBarButtonItem = saveButton
            }
    }
    
    @objc private func didTapDelete() {
        guard let index = noteIndex else { return }
        
        // შევატყობინოთ დელეგატს, რომ ეს ინდექსი წაიშალოს
        delegate?.didDelete(at: index)
        
        // დავბრუნდეთ უკან
        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        if let note = selectedNote {
            titleField.text = note.title
            noteField.text = note.content
        } else {
            titleField.text = ""
            noteField.text = ""
        }
    }

    @objc private func didTapSave() {
        guard let titleText = titleField.text, !titleText.isEmpty, !noteField.text.isEmpty else {
            return
        }
        
        // 5დელეგატს ვატანთ მონაცემებს
        delegate?.didSave(title: titleText, content: noteField.text, at: noteIndex)
        
        // 4ვხურავთ ეკრანს
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
}
