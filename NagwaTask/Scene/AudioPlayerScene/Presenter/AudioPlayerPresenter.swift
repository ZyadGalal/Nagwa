//
//  AudioPlayerPresenter.swift
//  NagwaTask
//
//  Created by Zyad Galal on 28/03/2022.
//


import Foundation

protocol AudioPlayerView: AnyObject{
    var presenter: AudioPlayerPresenterProtocol? {get set}
}

protocol AudioPlayerPresenterProtocol: AnyObject {
    
}

class AudioPlayerPresenter: AudioPlayerPresenterProtocol{
    
    private weak var view: AudioPlayerView?
    private var router: AudioPlayerRouter
    init (view: AudioPlayerView, router: AudioPlayerRouter){
        self.view = view
        self.router = router
    }
}
