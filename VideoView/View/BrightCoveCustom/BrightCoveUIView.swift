//
//  BrightCoveUIView.swift
//  VideoView
//
//  Created by Lê Quang Trọng Tài on 6/10/22.
//

import BrightcovePlayerSDK
import Foundation
import SwiftUI

struct BrightCoveUIView: UIViewRepresentable {
    typealias UIViewType = BCOVPUIPlayerView
    var playerUIView: BCOVPUIPlayerView?
    var services: BCOVPlaybackService?
    var layoutView: BCOVPUILayoutView?
    var controller: BCOVPlaybackController?
    var eventOnEnd: (() -> Void)?
    var onBack: (() -> Void)?
    var onGo: (() -> Void)?
    var onScreenShot: (() -> Void)?

    var video: BCOVVideo?
    init(
        controller: BCOVPlaybackController?,
        uiView: BCOVPUIPlayerView?,
        services: BCOVPlaybackService?,
        endVideo: (() -> Void)? = nil,
        onBack: (() -> Void)? = nil,
        onGo: (() -> Void)? = nil,
        onScreenShot: (()-> Void)? = nil
    ) {
        self.services = services
        self.controller = controller
        self.playerUIView = uiView
        self.eventOnEnd = endVideo
        self.onGo = onGo
        self.onBack = onBack
        self.onScreenShot = onScreenShot
        if let playerView = self.playerUIView {
            self.layoutView = self.configurationUI(forControlsView: playerView.controlsView)
            self.video = getVideo()
        }
    }

    func updateUIView(_ uiView: BCOVPUIPlayerView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(onEnd: eventOnEnd)
    }

    func makeUIView(context: Context) -> BCOVPUIPlayerView {
        playerUIView?.playbackController = controller
        playerUIView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        if let control = playerUIView?.controlsView {
            BrightCoveStyle.setStyle(forControlsView: control)
        }
        controller?.delegate = context.coordinator
        return playerUIView!
    }

    func configurationUI(forControlsView control: BCOVPUIBasicControlView) -> BCOVPUILayoutView? {
        var layoutControl: BCOVPUIControlLayout?
        var layoutView: BCOVPUILayoutView?
        let (controlLayouts, layoutViews) =
        BrightCoveLayout.setLayout(
            forControlsView: control,
            onBack: onBack,
            onGo: onGo,
            onScreenShot: onScreenShot
        )
        layoutControl = controlLayouts
        layoutView = layoutViews
        control.layout = layoutControl
        return layoutView
    }

    func getVideo() -> BCOVVideo? {
        var videos: BCOVVideo? = nil
        if services != nil {
            services?.findVideo(
                withVideoID: BrightCoveConstants.VideoId,
                parameters: nil,
                completion: { (video: BCOVVideo?, _, _) in
                    guard let video = video else {
                        return
                    }
                    self.controller?.setVideos([video] as NSFastEnumeration)
                    videos = video
                }
            )
        }
        return videos
    }
}
