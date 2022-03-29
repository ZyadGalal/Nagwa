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
    func loadView()
    func numberOfFiles() -> Int
    func getFile(at index: Int) -> FileModel
    func didSelectFile(at index: Int)
}

class ListFilesPresenter: ListFilesPresenterProtocol{
    
    private weak var view: ListFilesView?
    private var router: ListFilesRouter
    private var files: [FileModel] = []
    private var directory: URL?
    private let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter
    }()
    
    init (view: ListFilesView, router: ListFilesRouter, directory: URL?){
        self.view = view
        self.router = router
        self.directory = directory
    }
    func loadView() {
        files = listFilesFrom(directory: directory, with: "mp3")
        self.view?.updateUIWith(title: directory == nil ? "Documents" : directory!.lastPathComponent)
    }
    func listFilesFrom(directory: URL?, with extensionWanted: String) -> [FileModel] {

        let documentURL: URL
        if let directory = directory {
            documentURL = directory
        }
        else {
            documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentURL, includingPropertiesForKeys: nil, options: [])
            
            let filesPath = directoryContents.filter{ $0.pathExtension == extensionWanted || $0.hasDirectoryPath}
            let files = filesPath.map{
                FileModel(fileName: $0.lastPathComponent,
                          path: $0,
                          fileType: $0.pathExtension == extensionWanted ? .Audio : .Folder,
                          duration: formatter.string(from: AVAsset(url: $0).duration.seconds) ?? "0") }
                .sorted {
                    ($0.fileType, $0.fileName.lowercased()) < ($1.fileType, $1.fileName.lowercased())
                }
            
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
            router.navigateToSubFolder(from: view!, directory: file.path)
        case .Audio:
            let audioPaths = files.filter({$0.fileType == .Audio}).map({$0.path})
            router.navigateToAudioPlayer(from: view!, path: file.path, audioPaths: audioPaths)
        }
    }
}
