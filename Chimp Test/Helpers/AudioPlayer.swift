//
//  AudioPlayer.swift
//  Chimp Test
//
//  Created by Alistair White on 1/16/23.
//

import AVFoundation

class AudioPlayer {
    var audioPlayer: AVAudioPlayer!
    var audioEngine = AVAudioEngine()
    var audioFile: AVAudioFile!
    var audioPlayerNode = AVAudioPlayerNode()
    var timePitch = AVAudioUnitTimePitch()
    
    init(audioFileName: String) {
        guard let url = Bundle.main.url(forResource: audioFileName, withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            audioFile = try AVAudioFile(forReading: url)
            audioEngine.attach(audioPlayerNode)
            audioEngine.attach(timePitch)
            audioEngine.connect(audioPlayerNode, to: timePitch, format: audioFile.processingFormat)
            audioEngine.connect(timePitch, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playScale(scale: [Float]) {
        for pitch in scale {
            timePitch.pitch = pitch
            audioPlayerNode.scheduleFile(audioFile, at: nil) {
                DispatchQueue.main.async {
                    self.audioEngine.stop()
                }
            }
            try? audioEngine.start()
            audioPlayerNode.play()
            Thread.sleep(forTimeInterval: 0.5)
        }
    }
    func playNote(pitch: Float) {
        timePitch.pitch = pitch
        audioPlayerNode.scheduleFile(audioFile, at: nil) {
            DispatchQueue.main.async {
                self.audioEngine.stop()
            }
        }
        try? audioEngine.start()
        audioPlayerNode.play()
    }
}
