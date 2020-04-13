//
//  FormatExtension.swift
//  AppleDev-MC1
//
//  Created by Muhammad Haidar Rais on 13/04/20.
//  Copyright © 2020 Rahmat Zulfikri. All rights reserved.
//

import Foundation

func format(second: Int) -> String {
    let m = second / 60
    let s = second % 60
    return "\(m.padZero()):\(s.padZero())"
}

private extension Int {
    func padZero() -> String {
        return String(format: "%02d", self)
    }
}

extension Formatter {
    static let date = DateFormatter()
}

extension Date {
    func localizedDescription(dateStyle: DateFormatter.Style = .medium,
                                 timeStyle: DateFormatter.Style = .medium,
                              in timeZone : TimeZone = .current,
                                 locale   : Locale = .current) -> String {
           Formatter.date.locale = locale
           Formatter.date.timeZone = timeZone
           Formatter.date.dateStyle = dateStyle
           Formatter.date.timeStyle = timeStyle
           return Formatter.date.string(from: self)
       }
    var localizedDescription: String { localizedDescription() }
    var shortDateTime: String  { localizedDescription(dateStyle: .short,  timeStyle: .short) }
}
