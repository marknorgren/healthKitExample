    /**
     * Copyright (c) 2017 Razeware LLC
     *
     * Permission is hereby granted, free of charge, to any person obtaining a copy
     * of this software and associated documentation files (the "Software"), to deal
     * in the Software without restriction, including without limitation the rights
     * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
     * copies of the Software, and to permit persons to whom the Software is
     * furnished to do so, subject to the following conditions:
     *
     * The above copyright notice and this permission notice shall be included in
     * all copies or substantial portions of the Software.
     *
     * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
     * distribute, sublicense, create a derivative work, and/or sell copies of the
     * Software in any work that is designed, intended, or marketed for pedagogical or
     * instructional purposes related to programming, coding, application development,
     * or information technology.  Permission for such use, copying, modification,
     * merger, publication, distribution, sublicensing, creation of derivative works,
     * or sale is expressly withheld.
     *
     * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
     * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
     * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
     * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
     * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
     * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
     * THE SOFTWARE.
     */

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
