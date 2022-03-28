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
            let interactor = ListFilesInteractor()
            let presenter = ListFilesPresenter(view: createView, router: router, interactor: interactor, directory: directory)
            createView.presenter = presenter
        }
        return createViewController
    }
}
