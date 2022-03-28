//
//  AudioPlayerPresenter.swift
//  NagwaTask
//
//  Created by Zyad Galal on 28/03/2022.
//


import Foundation
import AVFoundation

protocol AudioPlayerView: AnyObject{
    var presenter: AudioPlayerPresenterProtocol? {get set}

}

protocol AudioPlayerPresenterProtocol: AnyObject {
    var path: URL? {get}
    func viewDidLoad()
    func getStringTime(from timeInterval: TimeInterval) -> String
    func getAudioName() -> String 
}

class AudioPlayerPresenter: AudioPlayerPresenterProtocol{

    var path: URL?
    private weak var view: AudioPlayerView?
    private var router: AudioPlayerRouter
    private let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter
    }()

    init (view: AudioPlayerView, router: AudioPlayerRouter, path: URL){
        self.view = view
        self.router = router
        self.path = path
    }
    func viewDidLoad() {
        
    }

    
    func getStringTime(from timeInterval: TimeInterval) -> String{
        return formatter.string(from: timeInterval) ?? "00:00"
    }

    func getAudioName() -> String {
        return path?.deletingPathExtension().lastPathComponent ?? ""
    }
    

}
