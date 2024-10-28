//
//  Integer+Extensions.swift
//  myfunpace
//
//  Created by Nick Coelius on 10/27/24.
//

import Foundation

extension Double {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
