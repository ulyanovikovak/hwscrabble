//
//  Date+Extensions.swift
//
//  Created by Irlan Abushakhmanov on 30.04.2024.
//

import Foundation
import JWT

extension Date {
    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
}

public extension ExpirationClaim {
    static func oneDay() -> Self {
        ExpirationClaim(value: Date().adding(days: 1))
    }
}
