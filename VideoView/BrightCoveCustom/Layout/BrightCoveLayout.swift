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
        onGo: (()-> Void)?
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
        if let btnGo = btnGoBackLayoutView {
            let button = UIButton(frame: btnGo.frame)
            button.tintColor = .white
            button.setImage(
                UIImage(systemName: "goforward"),
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
                UIImage(systemName: "gobackward"),
                for: .normal
            )
            btnBack.addSubview(button)
            button.addAction(for: .touchUpInside) {
                onBack?()
            }
        }
        let standardLayoutLine1 = [progressLayoutView]
        let standardLayoutLine2 = [ spacerLayoutView, spacerLayoutView, currentTimeLayoutView, spacerLayoutView,
            btnGoBackLayoutView, playbackLayoutView,
            btnBackLayoutView, spacerLayoutView, durationLayoutView, spacerLayoutView, spacerLayoutView,
        ]
        let standardLayoutLines = [standardLayoutLine1, standardLayoutLine2]
        let compactLayoutLine1 = [progressLayoutView]
        let compactLayoutLine2 = [ spacerLayoutView, currentTimeLayoutView, spacerLayoutView, btnBackLayoutView,
            playbackLayoutView, btnGoBackLayoutView, spacerLayoutView, durationLayoutView, spacerLayoutView,
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
