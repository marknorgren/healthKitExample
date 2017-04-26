//
//  Workout.swift
//  Prancercise Tracker Starter
//
//  Created by Theodore Bendixson on 4/24/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation

struct Workout {
  
  var startDate: Date
  var durationInMinutes: Double
  var distance: Double
  var energyBurned: Double?
  
  var endDate: Date {
    get {
      let secondsInAMinute = 60.0
      return startDate.addingTimeInterval(durationInMinutes*secondsInAMinute)
    }
  }
  
}

class WorkoutBuilder {
  
  class func makeWorkout(workoutDate: Date?,
                         workoutStartTime: Date?,
                         durationInMinutes: Double?,
                         distance: Double?,
                         energyBurned: Double? ) -> Workout? {
    
    guard let workoutDate = workoutDate,
      let workoutStartTime = workoutStartTime,
      let durationInMinutes = durationInMinutes,
      let distance = distance,
      let energyBurned = energyBurned else {
      return nil
    }
    
    let startDate = workoutStartDateWith(workoutDate,
                                         workoutStartTime: workoutStartTime)
    
    return Workout(startDate: startDate,
                   durationInMinutes: durationInMinutes,
                   distance: distance,
                   energyBurned: energyBurned)
  }
  
  private class func workoutStartDateWith(_ workoutDate: Date , workoutStartTime: Date) -> Date {
    
    let currentCalendar = Calendar.current
    
    let baseDateComponents = currentCalendar.dateComponents([Calendar.Component.day,
                                                             Calendar.Component.month,
                                                             Calendar.Component.year],
                                                            from: workoutDate)
    
    let baseDate = currentCalendar.date(from: baseDateComponents)!
    
    let hourComponents = currentCalendar.dateComponents([Calendar.Component.hour,
                                                         Calendar.Component.minute],
                                                        from: workoutStartTime)
    
    return currentCalendar.date(byAdding: hourComponents,
                                to: baseDate)!
  }
  
}
