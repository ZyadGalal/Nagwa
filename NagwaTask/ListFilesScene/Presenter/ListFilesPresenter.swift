//
//  ListFilesPresenter.swift
//  NagwaTask
//
//  Created by Zyad Galal on 27/03/2022.
//


import Foundation

protocol ListFilesView: AnyObject{
    var presenter: ListFilesPresenterProtocol? {get set}
}

protocol ListFilesPresenterProtocol: AnyObject {
    
}

class ListFilesPresenter: ListFilesPresenterProtocol{
    
    private weak var view: ListFilesView?
    private var router: ListFilesRouter
    private var interactor: ListFilesInteractor
    init (view: ListFilesView, router: ListFilesRouter, interactor: ListFilesInteractor){
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}
