//
//  AudioPlayerViewController.swift
//  NagwaTask
//
//  Created by Zyad Galal on 28/03/2022.
//

import UIKit
import AVFoundation

class AudioPlayerViewController: UIViewController {

    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backwardButton: UIButton!
    @IBOutlet weak var audioSlider: UISlider!
    @IBOutlet weak var audioLabel: UILabel!
    
    private var player: AVAudioPlayer?
    private var timer: Timer?

    
    var presenter: AudioPlayerPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupPlayer()
        setupSlider()
        setupUI()
        togglePlay()
    }
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }


    @IBAction func playButtonDidClicked(_ sender: Any) {
        togglePlay()
    }
    
    @IBAction func forwardButtonDidClicked(_ sender: Any) {
    }
    
    @IBAction func backwardButtonDidClicked(_ sender: Any) {
    }
    
    @IBAction func SliderValueChanged(_ sender: UISlider) {
        player?.currentTime = TimeInterval(sender.value)
        updateTime()
    }
    func setupUI() {
        guard let duration = player?.duration, let currentTime = player?.currentTime else{return }
        audioLabel.text = presenter?.getAudioName()
        elapsedTimeLabel.text = presenter?.getStringTime(from: currentTime)
        remainingTimeLabel.text = presenter?.getStringTime(from: duration)
    }
    func setupSlider() {
        guard let duration = player?.duration else {return}
        audioSlider.maximumValue = Float(duration)
        audioSlider.value = 0.0
    }
    private func setupPlayer() {
        do {
            guard let path = presenter?.path else {return}
            player = try AVAudioPlayer(contentsOf: path)
            player?.delegate = self
        } catch {
            print(error)
        }
    }
    private func play() {
        guard let player = player else {return}
        player.prepareToPlay()
        player.volume = 1.0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        player.play()
        
    }
    @objc private func updateTime() {
        guard let player = player else {return}
        let remainingTime = player.duration - player.currentTime
        let elapsedTime = player.currentTime
        audioSlider.value = Float(player.currentTime)
        remainingTimeLabel.text = presenter?.getStringTime(from: remainingTime)
        elapsedTimeLabel.text = presenter?.getStringTime(from: elapsedTime)
    
    }

    func togglePlay() {
        guard let player = player else {return}
        if player.isPlaying {
            player.pause()
            timer?.invalidate()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            self.play()
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }

}

extension AudioPlayerViewController: AudioPlayerView {
    
}


extension AudioPlayerViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            timer?.invalidate()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
}
