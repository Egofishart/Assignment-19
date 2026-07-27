//
//  NoteDetailViewController.swift
//  ნ.დანელია დავალება 13
//
//  Created by NikoDanelia on 27/06/2026.
//

import UIKit

protocol NoteDetailDelegate: AnyObject {
    func didSave(title: String, content: String, at index: Int?)
    func didDelete(at index: Int)
}

class NoteDetailViewController: UIViewController {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextView!
    
    weak var delegate: NoteDetailDelegate?
    
    //  აქ selectedNote-ის და noteIndex-ის ნაცვლად გვაქვს viewModel
    var viewModel: NoteDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationBar()
    }
    
    private func setupUI() {
        guard let viewModel = viewModel else { return }
        titleField.text = viewModel.initialTitle
        noteField.text = viewModel.initialContent
    }
    
    private func setupNavigationBar() {
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        
        if viewModel?.isEditing == true {
            let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
            deleteButton.tintColor = .systemRed
            navigationItem.rightBarButtonItems = [saveButton, deleteButton]
        } else {
            navigationItem.rightBarButtonItem = saveButton
        }
    }

    @objc private func didTapSave() {
        viewModel?.validateAndSave(title: titleField.text, content: noteField.text) { [weak self] title, content, index in
            self?.delegate?.didSave(title: title, content: content, at: index)
            self?.navigationController?.popViewController(animated: true)
        }
    }

    @objc private func didTapDelete() {
        guard let index = viewModel?.noteIndex else { return }
        delegate?.didDelete(at: index)
        navigationController?.popViewController(animated: true)
    }
}
