//
//  AudioPlayerRouter.swift
//  NagwaTask
//
//  Created by Zyad Galal on 28/03/2022.
//

import UIKit

class AudioPlayerRouter {
    class func createAudioPlayerViewController(path: URL) -> UIViewController{
        let createViewController = AudioPlayerViewController()
        
        if let createView = createViewController as? AudioPlayerView{
            let router = AudioPlayerRouter()
            let presenter = AudioPlayerPresenter(view: createView, router: router, path: path)
            createView.presenter = presenter
        }
        return createViewController
    }
}
