//
//  ListFilesViewController.swift
//  NagwaTask
//
//  Created by Zyad Galal on 27/03/2022.
//

import UIKit

class ListFilesViewController: UIViewController {

    @IBOutlet weak var filesTableView: UITableView!
    var presenter: ListFilesPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    func setupUI() {
        filesTableView.register(FileTableViewCell.self)
    }
}

extension ListFilesViewController: ListFilesView {
    func updateUIWith(title: String) {
        self.title = title
    }
    
    
}

extension ListFilesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfFiles() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let file = presenter?.getFile(at: indexPath.row) else {return UITableViewCell()}
        let cell = tableView.dequeueCell() as FileTableViewCell
        cell.audioDurationLabel.text = file.fileName
        cell.fileNameLabel.text = file.fileName
        cell.audioDurationLabel.text = file.duration
        if file.fileType == .Folder {
            cell.fileImageView.image = UIImage(systemName: "folder.fill")
            cell.fileImageView.tintColor = UIColor(named: "Folder")
            cell.audioDurationLabel.isHidden = true
        } else {
            cell.fileImageView.image = UIImage(systemName: "music.note")
            cell.fileImageView.tintColor = UIColor(named: "Audio")
        }
        return cell
    }
    
    
}

extension ListFilesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectFile(at: indexPath.row)
    }
}
