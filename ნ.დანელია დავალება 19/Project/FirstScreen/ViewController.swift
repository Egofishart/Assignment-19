//
//  ViewController.swift
//  ნ.დანელია დავალება 13
//
//  Created by NikoDanelia on 26/06/2026.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var label: UILabel!

    private let viewModel = NotesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        title = "Notes"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapNewNote))
        
        bindViewModel()
    }

    func bindViewModel() {
        viewModel.refreshUI = { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    @objc private func didTapNewNote() {
        let storyboard = UIStoryboard(name: "NoteDetail", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "NoteDetailViewController") as? NoteDetailViewController else {
            return
        }
        
        vc.title = "New Note"
        vc.delegate = self
        
        //  ახალი ნოუთის შექმნისას
        vc.viewModel = NoteDetailViewModel()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - CollectionView Data Source
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.notes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as! CollectionViewCell
        
        let currentNote = viewModel.notes[indexPath.row]
        cell.titleLabel.text = currentNote.title
        cell.contentLabel.text = currentNote.content
        
        cell.backgroundColor = .systemGray6
        cell.layer.cornerRadius = 8
        
        return cell
    }
}

// MARK: - CollectionView Delegate & FlowLayout
extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "NoteDetail", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "NoteDetailViewController") as? NoteDetailViewController else {
            return
        }
        
        vc.title = "Edit Note"
        vc.delegate = self
        
        //  არსებული ნოტის რედაქტირებისა
        vc.viewModel = NoteDetailViewModel(selectedNote: viewModel.notes[indexPath.row], noteIndex: indexPath.row)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        return CGSize(width: width, height: 120)
    }
}

// MARK: - NoteDetailDelegate
extension ViewController: NoteDetailDelegate {
    
    func didSave(title: String, content: String, at index: Int?) {
        viewModel.addOrUpdateNote(title: title, content: content, at: index)
    }
    
    func didDelete(at index: Int) {
        viewModel.deleteNote(at: index)
    }
}
