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
}

protocol ListFilesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfFiles() -> Int
    func getFile(at index: Int) -> FileModel
}

class ListFilesPresenter: ListFilesPresenterProtocol{
    
    private weak var view: ListFilesView?
    private var router: ListFilesRouter
    private var interactor: ListFilesInteractor
    private var files: [FileModel] = []
    private var directory: String = ""
    private let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter
    }()
    
    init (view: ListFilesView, router: ListFilesRouter, interactor: ListFilesInteractor, directory: String){
        self.view = view
        self.router = router
        self.interactor = interactor
        self.directory = directory
    }
    func viewDidLoad() {
        files = listFilesFrom(directory: directory, with: "mp3")
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
    
}
