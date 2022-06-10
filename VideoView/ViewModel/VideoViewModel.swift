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
}

extension VideoViewModel {
    // TODO: - End Video DoSomething()
    func endVideo() {
    }

    // TODO: - Combine: Get video or something
    func getVideoFromSeverSide() {
    }
}
