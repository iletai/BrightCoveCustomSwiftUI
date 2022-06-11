//
//  ContentView.swift
//  VideoView
//
//  Created by Lê Quang Trọng Tài on 6/10/22.
//
import BrightcovePlayerSDK
import SwiftUI

struct ContentView: View {
    @ObservedObject private(set) var viewModel: VideoViewModel
    private var videoView: BrightCoveUIView
    private let controlView: BCOVPUIBasicControlView
    private let playerView: BCOVPUIPlayerView?
    private let options = BCOVPUIPlayerViewOptions()

    init() {
        let controlView = BCOVPUIBasicControlView()
        controlView.layout = BCOVPUIControlLayout.basicVOD()
        self.controlView = controlView
        let player = BCOVPUIPlayerView(
            playbackController: nil,
            options: options,
            controlsView: controlView
        )

        self.playerView = player
        let viewModel = VideoViewModel(player: player)
        self.viewModel = viewModel

        self.videoView = BrightCoveUIView(
            controller: viewModel.controller,
            uiView: playerView,
            services: viewModel.services
        ) {
            viewModel.onBack()
        } onGo: {
            viewModel.onGo()
        }

    }

    var body: some View {
        ZStack {
            videoView
            if videoView.video == nil {
                ProgressView()
            }
        }
        .ignoresSafeArea(.all)
        .onDisappear {
            viewModel.pauseCurrentVideo()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
