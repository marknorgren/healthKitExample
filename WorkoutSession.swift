//
//  WorkoutSession.swift
//  Prancercise Tracker
//
//  Created by Theodore Bendixson on 5/6/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation

enum WorkoutSessionState {
  case notStarted
  case active
  case finished
}

class WorkoutSession {
  
  static let current = WorkoutSession()
  
  private (set) var startDate: Date!
  private (set) var endDate: Date!

  var state: WorkoutSessionState = .notStarted
  
  func start() {
    startDate = Date()
    state = .active
  }
  
  func end() {
    endDate = Date()
    state = .finished
  }
  
  var completeWorkout: PrancerciseWorkout? {
    
    get {
      
      guard state == .finished,
            let startDate = startDate,
            let endDate = endDate else {
            return nil
      }
      
      return PrancerciseWorkout(start: startDate,
                                end: endDate)
      
    }
    
  }
  
}
