//
//  Workout.swift
//  Prancercise Tracker Starter
//
//  Created by Theodore Bendixson on 4/24/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation

struct Workout {
  
  var start: Date
  var durationInMinutes: Double
  var distance: Double
  var energyBurned: Double?
  
  var end: Date {
    get {
      let secondsInAMinute = 60.0
      return start.addingTimeInterval(durationInMinutes*secondsInAMinute)
    }
  }
  
}

class WorkoutBuilder {
  
  class func makeWorkout(dateWorkoutOccurs: Date?,
                         startHourAndMinute: DateComponents?,
                         durationInMinutes: Double?,
                         distance: Double?,
                         energyBurned: Double? ) -> Workout? {
    
    guard let dateWorkoutOccurs = dateWorkoutOccurs,
          let startHourAndMinute = startHourAndMinute,
          let durationInMinutes = durationInMinutes,
          let distance = distance,
          let energyBurned = energyBurned else {
          return nil
    }
    
    let currentCalendar = Calendar.current
    
    let baseDateComponents = currentCalendar.dateComponents([Calendar.Component.day,
                                                             Calendar.Component.month,
                                                             Calendar.Component.year],
                                                            from: dateWorkoutOccurs)
    
    let baseDate = currentCalendar.date(from: baseDateComponents)!
    
    let start = currentCalendar.date(byAdding: startHourAndMinute,
                                     to: baseDate)!
    
    return Workout(start: start,
                   durationInMinutes: durationInMinutes,
                   distance: distance,
                   energyBurned: energyBurned)
  }
  
}
