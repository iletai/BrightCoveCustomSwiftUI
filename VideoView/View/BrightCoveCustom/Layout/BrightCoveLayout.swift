//
//  BrightCoveLayout.swift
//  VideoView
//
//  Created by Lê Quang Trọng Tài on 6/10/22.
//

import BrightcovePlayerSDK
import Foundation
import UIKit

class BrightCoveLayout: NSObject {
    class func setLayout(
        forControlsView control: BCOVPUIBasicControlView,
        onBack: (()-> Void)?,
        onGo: (()-> Void)?,
        onScreenShot: (()-> Void)?
    ) -> (BCOVPUIControlLayout?, BCOVPUILayoutView?) {
        let playbackLayoutView = BCOVPUIBasicControlView.layoutViewWithControl(
            from: .buttonPlayback, width: kBCOVPUILayoutUseDefaultValue, elasticity: 0.0
        )
        let currentTimeLayoutView = BCOVPUIBasicControlView.layoutViewWithControl(
            from: .labelCurrentTime, width: kBCOVPUILayoutUseDefaultValue, elasticity: 0.0
        )
        let durationLayoutView = BCOVPUIBasicControlView.layoutViewWithControl(
            from: .labelDuration, width: kBCOVPUILayoutUseDefaultValue, elasticity: 0.0
        )
        let progressLayoutView = BCOVPUIBasicControlView.layoutViewWithControl(
            from: .sliderProgress, width: kBCOVPUILayoutUseDefaultValue, elasticity: 1.0
        )
        let spacerLayoutView = BCOVPUIBasicControlView.layoutViewWithControl(
            from: .viewEmpty, width: 8, elasticity: 1.0
        )

        let btnBackLayoutView = BCOVPUIBasicControlView.layoutViewWithControl(
            from: .viewEmpty, width: 30, elasticity: 0.0
        )
        let btnGoBackLayoutView = BCOVPUIBasicControlView.layoutViewWithControl(
            from: .viewEmpty, width: 30, elasticity: 0.0
        )
        let btnTakeScreenShotView = BCOVPUIBasicControlView.layoutViewWithControl(
            from: .viewEmpty, width: 30, elasticity: 0.0
        )
        if let btnTakeScreenShotView = btnTakeScreenShotView {
            let button = UIButton(frame: btnTakeScreenShotView.frame)
            button.tintColor = .white
            button.setImage(
                UIImage(systemName: "camera.viewfinder"),
                for: .normal
            )
            btnTakeScreenShotView.addSubview(button)
            button.addAction(for: .touchUpInside) {
                onScreenShot?()
            }
        }
        let screenModeLayoutView = BCOVPUIBasicControlView.layoutViewWithControl(from: .buttonScreenMode, width: kBCOVPUILayoutUseDefaultValue, elasticity: 0.0)
        if let btnGo = btnGoBackLayoutView {
            let button = UIButton(frame: btnGo.frame)
            button.tintColor = .white
            button.setImage(
                UIImage(systemName: "goforward.15"),
                for: .normal
            )
            btnGo.addSubview(button)
            button.addAction(for: .touchUpInside) {
                onGo?()
            }
        }
        if let btnBack = btnBackLayoutView {
            let button = UIButton(frame: btnBack.frame)
            button.tintColor = .white
            button.setImage(
                UIImage(systemName: "gobackward.15"),
                for: .normal
            )
            btnBack.addSubview(button)
            button.addAction(for: .touchUpInside) {
                onBack?()
            }
        }
        let standardLayoutLine1 = [progressLayoutView]
        let standardLayoutLine2 = [ spacerLayoutView, spacerLayoutView,btnTakeScreenShotView, currentTimeLayoutView, spacerLayoutView,
                                    btnGoBackLayoutView, playbackLayoutView,
                                    btnBackLayoutView, spacerLayoutView, durationLayoutView,screenModeLayoutView, spacerLayoutView, spacerLayoutView,

        ]
        let standardLayoutLines = [standardLayoutLine1, standardLayoutLine2]
        let compactLayoutLine1 = [progressLayoutView]
        let compactLayoutLine2 = [  spacerLayoutView, btnTakeScreenShotView, currentTimeLayoutView, spacerLayoutView, btnBackLayoutView,
                                   playbackLayoutView, btnGoBackLayoutView, spacerLayoutView, durationLayoutView,screenModeLayoutView, spacerLayoutView,
        ]
        let compactLayoutLines = [compactLayoutLine1, compactLayoutLine2]
        let layout = BCOVPUIControlLayout(
            standardControls: standardLayoutLines, compactControls: compactLayoutLines
        )
        return (layout, playbackLayoutView)
    }
}

extension UIControl {
    func addAction(
        for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping () -> Void
    ) {
        addAction(UIAction { (_ action: UIAction) in closure() }, for: controlEvents)
    }
}
