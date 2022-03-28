//
//  AudioPlayerPresenter.swift
//  NagwaTask
//
//  Created by Zyad Galal on 28/03/2022.
//


import Foundation

protocol AudioPlayerView: AnyObject{
    var presenter: AudioPlayerPresenterProtocol? {get set}
    func updateUIWith(audioName: String)
}

protocol AudioPlayerPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class AudioPlayerPresenter: AudioPlayerPresenterProtocol{
    
    private let path: URL?
    private weak var view: AudioPlayerView?
    private var router: AudioPlayerRouter
    init (view: AudioPlayerView, router: AudioPlayerRouter, path: URL){
        self.view = view
        self.router = router
        self.path = path
    }
    func viewDidLoad() {
        self.view?.updateUIWith(audioName: path?.deletingPathExtension().lastPathComponent ?? "")
    }
}
