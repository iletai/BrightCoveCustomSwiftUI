//
//  BrightCoveStyle.swift
//  VideoView
//
//  Created by Lê Quang Trọng Tài on 6/10/22.
//

import BrightcovePlayerSDK
import SwiftUI
import Foundation
import UIKit

class BrightCoveStyle: NSObject {
    class func setStyle(forControlsView view: BCOVPUIBasicControlView) {
        let font = UIFont(name: "Arial", size: 18)
        view.currentTimeLabel.font = font
        view.currentTimeLabel.textColor = .white
        view.durationLabel.font = font
        view.durationLabel.textColor = .white
        view.playbackButton?.setTitleColor(.white, for: .normal)
        view.playbackButton?.setTitleColor(.white, for: .highlighted)
        let slider = view.progressSlider
        slider?.bufferProgressTintColor = .white
        slider?.minimumTrackTintColor = .blue
        slider?.maximumTrackTintColor = .gray
    }
}
