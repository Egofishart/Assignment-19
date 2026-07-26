//
//  ViewController.swift
//  ნ.დანელია დავალება 13
//
//  Created by NikoDanelia on 26/06/2026.
//

import UIKit

// MARK: - Main Class
class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var label: UILabel!

    var models: [Note] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        title = "Notes"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapNewNote))
    }

    @objc private func didTapNewNote() {
        let storyboard = UIStoryboard(name: "NoteDetail", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "NoteDetailViewController") as? NoteDetailViewController else {
            return
        }
        
        vc.title = "New Note"
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - CollectionView Data Source
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as! CollectionViewCell
        
        let currentNote = models[indexPath.row]
        cell.titleLabel.text = currentNote.title
        cell.contentLabel.text = currentNote.content
        
        cell.backgroundColor = .systemGray6
        cell.layer.cornerRadius = 8
        
        return cell
    }
}

// MARK: - CollectionView Delegate
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "NoteDetail", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "NoteDetailViewController") as? NoteDetailViewController else {
            return
        }
        
        vc.title = "Edit Note"
        vc.delegate = self
        vc.selectedNote = models[indexPath.row]
        vc.noteIndex = indexPath.row
        
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
        if let index = index {
            models[index].title = title
            models[index].content = content
        } else {
            let newNote = Note(title: title, content: content)
            models.append(newNote)
        }
        
        collectionView.reloadData()
    }
}
