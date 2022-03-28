//
//  AudioPlayerViewController.swift
//  NagwaTask
//
//  Created by Zyad Galal on 28/03/2022.
//

import UIKit


class AudioPlayerViewController: UIViewController{
    
    var presenter: AudioPlayerPresenterProtocol?
    override func viewDidLoad(){
        super.viewDidLoad()

    }
}

extension AudioPlayerViewController: AudioPlayerView {
    
}
