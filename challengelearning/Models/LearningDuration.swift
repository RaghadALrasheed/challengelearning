//
//  LearningDuration.swift
//  challengelearning
//
//  Created by Raghad Alrasheed on 01/06/1448 AH.
//

import Foundation
enum LearningDuration: CaseIterable {
    case week
    case month
    case year
    
    var maxFreezes: Int {
        switch self {
        case .week:
            return 2
        case .month:
            return 8
        case .year:
            return 96
        }
    }
}
