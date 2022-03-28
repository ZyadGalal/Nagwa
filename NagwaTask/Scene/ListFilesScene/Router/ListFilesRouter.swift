//
//  ListFilesRouter.swift
//  NagwaTask
//
//  Created by Zyad Galal on 27/03/2022.
//

import UIKit

class ListFilesRouter {
    class func createListFilesViewController(directory: String) -> UIViewController{
        let createViewController = ListFilesViewController()
        
        if let createView = createViewController as? ListFilesView{
            let router = ListFilesRouter()
            let presenter = ListFilesPresenter(view: createView, router: router, directory: directory)
            createView.presenter = presenter
        }
        return createViewController
    }
    
    func navigateToAudioPlayer(from view: ListFilesView, path: URL) {
        if let viewController = view as? UIViewController {
            let audioPlayer = AudioPlayerRouter.createAudioPlayerViewController(path: path)
            viewController.navigationController?.present(audioPlayer, animated: true)
        }
    }
    func navigateToSubFolder(from view: ListFilesView, directory: String) {
        if let viewController = view as? UIViewController {
            let listFile = ListFilesRouter.createListFilesViewController(directory: directory)
            viewController.navigationController?.pushViewController(listFile, animated: true)
        }
    }
}
