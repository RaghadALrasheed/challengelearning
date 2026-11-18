//
//  LearningDuration.swift
//  challengelearning
//
//  Created by Raghad Alrasheed on 01/06/1448 AH.
//

import Foundation
enum LearningDuration: CaseIterable, Codable {
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
    
    var title: String {
        switch self {
        case .week: return "Week"
        case .month: return "Month"
        case .year: return "Year"
        }
    }
    var totalDays: Int {
        switch self {
        case .week: return 7
        case .month: return 30
        case .year: return 365
        }
    }
}
