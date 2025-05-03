//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Elnur Mammadov on 03.05.25.
//

import Foundation
import UIKit
import AVFoundation

final class PlaybackPresenter {
    static let shared = PlaybackPresenter()

    private var track: ImageLabelCellProtocol?
    private var tracks = [ImageLabelCellProtocol]()

    var index = 0

    var currentTrack: ImageLabelCellProtocol? {
        if let track = track, tracks.isEmpty {
            return track
        }
        else if let _ = self.playerQueue, !tracks.isEmpty {
            return tracks[index]
        }

        return nil
    }

    var playerVC: PlayerController?

    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?

    func startPlayback(from viewController: UIViewController, track: ImageLabelCellProtocol) {
        self.track = track
        self.tracks = []
        let url = track.trackPreviewURL
        player = AVPlayer(url: URL(string: url) ?? URL(fileURLWithPath: ""))
        player?.volume = 0.5

        let vc = PlayerController()
        vc.title = track.nameText
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
            self?.player?.play()
        }
        self.playerVC = vc
    }

    func startPlayback(from viewController: UIViewController, tracks: [TrackItem]) {
        self.tracks = tracks
        self.track = nil

        self.playerQueue = AVQueuePlayer(items: tracks.compactMap({
            let url = URL(string: $0.previewURL ?? "")
            return AVPlayerItem(url: url ?? URL(fileURLWithPath: ""))
        }))
        self.playerQueue?.volume = 0.5
        self.playerQueue?.play()

        let vc = PlayerController()
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        self.playerVC = vc
    }
}

extension PlaybackPresenter: PlayerViewControllerDelegate {
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        }
        else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }

    func didTapForward() {
        if tracks.isEmpty {
            // Not playlist or album
            player?.pause()
        }
        else if let player = playerQueue {
            player.advanceToNextItem()
            index += 1
            print(index)
            playerVC?.refreshUI()
        }
    }

    func didTapBackward() {
        if tracks.isEmpty {
            // Not playlist or album
            player?.pause()
            player?.play()
        }
        else if let firstItem = playerQueue?.items().first {
            playerQueue?.pause()
            playerQueue?.removeAllItems()
            playerQueue = AVQueuePlayer(items: [firstItem])
            playerQueue?.play()
            playerQueue?.volume = 0.5
        }
    }

    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
}

extension PlaybackPresenter: PlayerDataSource {
    var songName: String {
        return currentTrack?.nameText ?? ""
    }

    var subtitle: String {
        return currentTrack?.artistName ?? "" 
    }

    var imageURL: String {
        return currentTrack?.imageURL ?? ""
    }
}
