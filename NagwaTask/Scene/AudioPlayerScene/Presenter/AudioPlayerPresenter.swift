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
    func updatePlaybackButton(isNextEnabled: Bool, isPerviousEnabled: Bool)
    func playAudio()
}

protocol AudioPlayerPresenterProtocol: AnyObject {
    var path: URL? {get}
    func viewDidLoad()
    func getStringTime(from timeInterval: TimeInterval) -> String
    func getAudioName() -> String
    func nextButtonDidClicked()
    func perviousButtonDidClicked()
}

class AudioPlayerPresenter: AudioPlayerPresenterProtocol{

    var path: URL?
    private weak var view: AudioPlayerView?
    private var router: AudioPlayerRouter
    private var audioIndexPath = -1
    private var currentDirectoryAudioPaths: [URL] = []
    private let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter
    }()

    init (view: AudioPlayerView, router: AudioPlayerRouter, path: URL, audioPaths: [URL]){
        self.view = view
        self.router = router
        self.path = path
        self.currentDirectoryAudioPaths = audioPaths
    }
    func viewDidLoad() {
        audioIndexPath = currentDirectoryAudioPaths.firstIndex(of: path!) ?? -1
        updatePlaybackButtons()
    }

    
    func getStringTime(from timeInterval: TimeInterval) -> String{
        return formatter.string(from: timeInterval) ?? "00:00"
    }

    func getAudioName() -> String {
        return path?.deletingPathExtension().lastPathComponent ?? ""
    }
    func nextButtonDidClicked() {
        audioIndexPath += 1
        path = currentDirectoryAudioPaths[audioIndexPath]
        updatePlaybackButtons()
    }
    func perviousButtonDidClicked() {
        audioIndexPath -= 1
        path = currentDirectoryAudioPaths[audioIndexPath]
        updatePlaybackButtons()
    }
    private func updatePlaybackButtons() {
        self.view?.updatePlaybackButton(isNextEnabled: audioIndexPath + 1 > currentDirectoryAudioPaths.count - 1 ? false : true
                                        , isPerviousEnabled: audioIndexPath - 1 < 0 ? false : true)
        self.view?.playAudio()
    }

}
