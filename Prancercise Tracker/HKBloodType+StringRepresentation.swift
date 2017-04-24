//
//  HKBloodType+StringRepresentation.swift
//  Prancercise Tracker Starter
//
//  Created by Theodore Bendixson on 4/24/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import HealthKit

extension HKBloodType {
  
  var stringRepresentation: String {
    switch self {
    case .notSet: return "Unknown"
    case .aPositive: return "A+"
    case .aNegative: return "A-"
    case .bPositive: return "B+"
    case .bNegative: return "B-"
    case .abPositive: return "AB+"
    case .abNegative: return "AB-"
    case .oPositive: return "O+"
    case .oNegative: return "O-"
    }
  }
}
