//
//  ListFilesPresenter.swift
//  NagwaTask
//
//  Created by Zyad Galal on 27/03/2022.
//


import Foundation
import AVFoundation

protocol ListFilesView: AnyObject{
    var presenter: ListFilesPresenterProtocol? {get set}
    func updateUIWith(title: String)
}

protocol ListFilesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfFiles() -> Int
    func getFile(at index: Int) -> FileModel
    func didSelectFile(at index: Int)
}

class ListFilesPresenter: ListFilesPresenterProtocol{
    
    private weak var view: ListFilesView?
    private var router: ListFilesRouter
    private var files: [FileModel] = []
    private var directory: String = ""
    private let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter
    }()
    
    init (view: ListFilesView, router: ListFilesRouter, directory: String){
        self.view = view
        self.router = router
        self.directory = directory
    }
    func viewDidLoad() {
        files = listFilesFrom(directory: directory, with: "mp3")
        self.view?.updateUIWith(title: directory.isEmpty ? "Root" : directory)
    }
    func listFilesFrom(directory: String, with extensionWanted: String) -> [FileModel] {

        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let Path = documentURL.appendingPathComponent(directory).absoluteURL

        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: Path, includingPropertiesForKeys: nil, options: [])

            let filesPath = directoryContents.filter{ $0.pathExtension == extensionWanted || $0.hasDirectoryPath}
            let files = filesPath.map{
                FileModel(fileName: $0.lastPathComponent,
                          path: $0,
                          fileType: $0.pathExtension == extensionWanted ? .Audio : .Folder,
                          duration: formatter.string(from: AVAsset(url: $0).duration.seconds) ?? "0") }
            
            return files

        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func numberOfFiles() -> Int {
        return files.count
    }
    
    func getFile(at index: Int) -> FileModel{
        return files[index]
    }
    func didSelectFile(at index: Int) {
        let file = files[index]
        switch file.fileType {
        case .Folder:
            router.navigateToSubFolder(from: view!, directory: file.path.lastPathComponent)
        case .Audio:
            router.navigateToAudioPlayer(from: view!, path: file.path)
        }
    }
}
