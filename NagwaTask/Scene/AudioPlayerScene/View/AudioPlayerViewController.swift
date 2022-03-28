//
//  AudioPlayerViewController.swift
//  NagwaTask
//
//  Created by Zyad Galal on 28/03/2022.
//

import UIKit

class AudioPlayerViewController: UIViewController {

    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backwardButton: UIButton!
    @IBOutlet weak var audioSlider: UISlider!
    @IBOutlet weak var audioLabel: UILabel!
    
    var presenter: AudioPlayerPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    @IBAction func playButtonDidClicked(_ sender: Any) {
    }
    
    @IBAction func forwardButtonDidClicked(_ sender: Any) {
    }
    
    @IBAction func backwardButtonDidClicked(_ sender: Any) {
    }
}

extension AudioPlayerViewController: AudioPlayerView {
    func updateUIWith(audioName: String) {
        self.audioLabel.text = audioName
    }
    
    
}
