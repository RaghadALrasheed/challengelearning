//
//  LearningGoal.swift
//  challengelearning
//
//  Created by Raghad Alrasheed on 01/06/1448 AH.
//

import Foundation
struct LearningGoal: Codable {
    var goal: String
    var duration: LearningDuration
    var startDate: Date
}
