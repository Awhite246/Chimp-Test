//
//  AudioPlayer.swift
//  Chimp Test
//
//  Created by Alistair White on 1/16/23.
//

//https://stackoverflow.com/questions/39893997/xcode-8-swift-3-pitch-altering-sounds was alot of help in bug fixing

import AVFoundation

class AudioPlayer {
    var audioEngine = AVAudioEngine()
    var audioFiles = [AVAudioFile(), AVAudioFile()]
    var audioPlayers = [AVAudioPlayerNode(), AVAudioPlayerNode()]
    var pitchUnits = [AVAudioUnitTimePitch(), AVAudioUnitTimePitch()]
    init(fileNames: [String]) {
        var i = 0
        for fileName in fileNames {
            if let url = Bundle.main.url(forResource: "\(fileName)", withExtension: "mp3") {
                do {
                    audioFiles[i] = try AVAudioFile(forReading: url)
                    i += 1
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        i = 0
        for playerNode in audioPlayers {
            let pitchUnit = pitchUnits[i]
            
            audioEngine.attach(playerNode)
            audioEngine.attach(pitchUnit)
            audioEngine.connect(playerNode, to: pitchUnit, format: nil)
            audioEngine.connect(pitchUnit, to:audioEngine.mainMixerNode, format: nil)
            
            i += 1
        }
        
        try? audioEngine.start()
        
        for playerNode in audioPlayers {
            playerNode.play()
        }
    }
    
    func playNote(pitch: Float, volume: Float = 0.25, fileNum: Int) {
        let playerNode = audioPlayers[fileNum]
        let pitchUnit = pitchUnits[fileNum]
        let file = audioFiles[fileNum]
        print("\nplaying at \nvolumn: \(volume)\npitch:\(pitch)\nfile\(audioPlayers[fileNum])")
        pitchUnit.pitch = pitch
        playerNode.volume = volume
        //reset engine to change volume
        audioEngine.reset()
        
        // interrupt playing sound if you have to
        for audioNode in audioPlayers {
            if audioNode.isPlaying {
                audioNode.stop()
                audioNode.play()
            }
        }
        
        playerNode.scheduleFile(file, at: nil, completionHandler: nil)
    }
}
