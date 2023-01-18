//
//  AudioPlayer.swift
//  Chimp Test
//
//  Created by Alistair White on 1/16/23.
//

import AVFoundation

class AudioPlayer {
    var audioEngine = AVAudioEngine()
    var audioFile: AVAudioFile!
    var audioPlayerNode = AVAudioPlayerNode()
    var changeAudioUnitTime = AVAudioUnitTimePitch()
    init(audioFileName: String) {
        if let url = Bundle.main.url(forResource: audioFileName, withExtension: "mp3") {
            do {
                //try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                //try AVAudioSession.sharedInstance().setActive(true)
                audioFile = try AVAudioFile(forReading: url)
                audioEngine.attach(audioPlayerNode)
                audioEngine.attach(changeAudioUnitTime)
                audioEngine.connect(audioPlayerNode, to: changeAudioUnitTime, format: nil /*audioFile.processingFormat*/)
                audioEngine.connect(changeAudioUnitTime, to: audioEngine.mainMixerNode, format: nil /*audioFile.processingFormat*/)
            } catch let error {
                print(error.localizedDescription)
            }
            try? audioEngine.start()
            audioPlayerNode.play()
        } else {
            print("Failed to find file")
        }
    }
    
    func playNote(pitch: Float, volume: Float = 10) {
        print("playing at \nvolumn: \(volume)\npitch:\(pitch)")
        changeAudioUnitTime.pitch = pitch
        audioPlayerNode.volume = volume
        //reset engine to change volume
        //audioEngine.reset()
        
        // interrupt playing sound if you have to
        if audioPlayerNode.isPlaying {
            audioPlayerNode.stop()
            audioPlayerNode.play()
        }
        
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
    }
}
