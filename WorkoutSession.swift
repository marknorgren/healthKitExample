//
//  WorkoutSession.swift
//  Prancercise Tracker
//
//  Created by Theodore Bendixson on 5/6/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation

class WorkoutSession {
  
  static let current = WorkoutSession()
  
  private var startDate: Date!
  private var endDate: Date!
  
  private (set) var isActive: Bool = false
  
  func start() {
    startDate = Date()
    isActive = true
  }
  
  func end() {
    endDate = Date()
    isActive = false
  }
  
  var workout: PrancerciseWorkout? {
    
    get {
      
      guard isActive == false,
            let startDate = startDate,
            let endDate = endDate else {
            return nil
      }
      
      return PrancerciseWorkout(start: startDate,
                                end: endDate)
      
    }
    
  }
  
}
