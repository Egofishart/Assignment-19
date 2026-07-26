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
        
        // ზედა მარჯვენა კუთხეში პროგრამულად ვსვამთ შენახვის ღილაკს
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
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
