//
//  StringExtension.swift
//  VideoView
//
//  Created by Lê Quang Trọng Tài on 6/11/22.
//

import Foundation

extension String {
    func convertToTimeInterval() -> TimeInterval {
        guard !isEmpty else {
            return 0
        }
        var interval: Double = 0

        let parts = components(separatedBy: ":")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }
        return interval
    }
}
