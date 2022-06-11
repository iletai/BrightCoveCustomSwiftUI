//
//  VideoViewModel.swift
//  VideoView
//
//  Created by Lê Quang Trọng Tài on 6/10/22.
//

import BrightcovePlayerSDK
import Combine
import Foundation

final class VideoViewModel: ObservableObject {
    var controller: BCOVPlaybackController? = {
        guard let manager = BCOVPlayerSDKManager.shared(),
              let controller = manager.createPlaybackController()
        else {
            return nil
        }
        controller.isAutoAdvance = true
        controller.isAutoPlay = true
        return controller
    }()

    var services: BCOVPlaybackService? = {
        return BCOVPlaybackService(
            accountId: BrightCoveConstants.AccountID,
            policyKey: BrightCoveConstants.PolicyKey
        )
    }()
    let playerView: BCOVPUIPlayerView?
    
    init(player: BCOVPUIPlayerView?) {
        self.playerView = player
    }
}

extension VideoViewModel {
    // TODO: - End Video DoSomething()
    func endVideo() {
    }

    // TODO: - Combine: Get video or something
    func getVideoFromSeverSide() {
    }

    func onBack() {
        guard let playerView = playerView else {
            return
        }
        let time = playerView.controlsView.currentTimeLabel.text?.convertToTimeInterval()
        let targetTime = (time ?? 0) - BrightCoveConstants.timeToSeek
        if targetTime <= 0 {
            let timeToBack = CMTime(seconds: 0, preferredTimescale: 1)
            playerView.playbackController.seek(to: timeToBack) { _ in
            }
        } else {
            let timeToBack = CMTime(seconds: targetTime, preferredTimescale: 1)
            playerView.playbackController.seek(to: timeToBack) { _ in
            }
        }
    }

    func onGo() {
        guard let playerView = playerView else {
            return
        }
        let time = playerView.controlsView.currentTimeLabel.text?.convertToTimeInterval()
        let duration = playerView.controlsView.durationLabel.text?.convertToTimeInterval()
        let targetTime = (time ?? 0) + BrightCoveConstants.timeToSeek
        if targetTime >= duration ?? 0 {
            let timeToGo = CMTime(seconds: duration ?? 0, preferredTimescale: 1)
            playerView.playbackController.seek(to: timeToGo) { _ in
            }
        } else {
            let timeToGo = CMTime(seconds: targetTime, preferredTimescale: 1)
            playerView.playbackController.seek(to: timeToGo) { _ in
            }
        }
    }

    func pauseCurrentVideo() {
        controller?.pause()
    }
}
