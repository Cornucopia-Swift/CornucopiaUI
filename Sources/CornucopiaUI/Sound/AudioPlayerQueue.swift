//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if canImport(AVFoundation)
import AVFoundation

public extension Cornucopia.UI {

    class AudioPlayerQueue: NSObject {

        var player: AVAudioPlayer?
        var urls: [URL] = []

        public static var `default` = AudioPlayerQueue()
        override private init() { }

        public func play(url: URL) {
            precondition(Thread.isMainThread, "This API is not thread-safe. Please call it from the main thread instead.")

            guard let _ = player else {
                guard let player = try? AVAudioPlayer(contentsOf: url) else { return }
                self.player = player
                player.delegate = self
                player.play()
                return
            }
            self.urls.append(url)
        }
    }
}

extension Cornucopia.UI.AudioPlayerQueue: AVAudioPlayerDelegate {

    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.player = nil
        guard !self.urls.isEmpty else { return }
        self.play(url: self.urls.removeFirst())
    }
}

#endif
