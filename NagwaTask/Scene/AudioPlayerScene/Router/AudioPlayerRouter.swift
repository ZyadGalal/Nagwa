//
//  AudioPlayerRouter.swift
//  NagwaTask
//
//  Created by Zyad Galal on 28/03/2022.
//

import UIKit

class AudioPlayerRouter {
    class func createAudioPlayerViewController(path: URL, audioPaths: [URL]) -> UIViewController{
        let createViewController = AudioPlayerViewController()
        
        let audioView = createViewController as AudioPlayerView
        let router = AudioPlayerRouter()
        let presenter = AudioPlayerPresenter(view: audioView, router: router, path: path, audioPaths: audioPaths)
        audioView.presenter = presenter
        
        return createViewController
    }
}
