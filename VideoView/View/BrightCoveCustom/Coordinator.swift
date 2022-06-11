//
//  Coordinator.swift
//  VideoView
//
//  Created by Lê Quang Trọng Tài on 6/10/22.
//

import BrightcovePlayerSDK
import SwiftUI

class Coordinator: NSObject, BCOVPlaybackControllerDelegate {
    let endVideo: (() -> Void)?
    init(onEnd: (() -> Void)? = nil) {
        self.endVideo = onEnd
    }
    func playbackController(
        _ controller: BCOVPlaybackController?,
        didAdvanceTo session: BCOVPlaybackSession?
    ) {
    }

    func playbackController(
        _ controller: BCOVPlaybackController!,
        playbackSession session: BCOVPlaybackSession!,
        didReceive lifecycleEvent: BCOVPlaybackSessionLifecycleEvent?
    ) {
        guard let eventType = lifecycleEvent?.eventType else { return }
        switch eventType {
        case kBCOVPlaybackSessionLifecycleEventEnd:
            endVideo?()
        default:
            let error = kBCOVVideoErrorCodeTags
            print(error)

        }
    }
}
