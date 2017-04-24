//
//  HKBiologicalSex+StringRepresentation.swift
//  Prancercise Tracker Starter
//
//  Created by Theodore Bendixson on 4/24/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import HealthKit

extension HKBiologicalSex {
  
  var stringRepresentation: String {
    switch self {
    case .notSet: return "Uknown"
    case .female: return "Female"
    case .male: return "Male"
    case .other: return "Other"
    }
  }
}
