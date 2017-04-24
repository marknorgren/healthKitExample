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
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class CreateWorkoutTableViewController: UITableViewController {
  
  @IBOutlet private var workoutDateCell: DatePickerCell!
  @IBOutlet private var workoutStartTimeCell: DatePickerCell!
  
  @IBOutlet fileprivate var workoutDurationCell: NumberCell!
  @IBOutlet fileprivate var workoutCaloriesCell: NumberCell!
  @IBOutlet fileprivate var workoutDistanceCell: NumberCell!

  private var workout: Workout?
  
  fileprivate var selectedWorkoutDate: Date?
  fileprivate var selectedWorkoutStartTime: Date?
  fileprivate var selectedWorkoutDurationInMinutes: Double?
  fileprivate var selectedWorkoutDistance: Double?
  fileprivate var selectedEnergyBurned: Double?
  
  var distanceUnit = DistanceUnit.miles
  
  fileprivate func updateOKButtonStatus() {
    navigationItem.rightBarButtonItem?.isEnabled = workout == nil ? false:true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCells()
  }
  
  private func setupCells() {
    
    workoutDateCell.inputMode = .date
    workoutStartTimeCell.inputMode = .time
    
    workoutDateCell.delegate = self
    workoutStartTimeCell.delegate = self
    
    workoutDurationCell.delegate = self
    workoutCaloriesCell.delegate = self
    workoutDistanceCell.delegate = self
    
    let formatter = LengthFormatter()
    formatter.unitStyle = .long
    let unit = distanceUnit == DistanceUnit.kilometers ? LengthFormatter.Unit.kilometer : LengthFormatter.Unit.mile
    let unitString = formatter.unitString(fromValue: 2.0, unit: unit)
    workoutDistanceCell.textLabel?.text = "Distance (" + unitString.capitalized + ")"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateOKButtonStatus()
  }
  
  fileprivate func updateWorkout() {
    workout = WorkoutBuilder.createWorkout(workoutDate: selectedWorkoutDate,
                                           workoutStartTime: selectedWorkoutStartTime,
                                           durationInMinutes: selectedWorkoutDurationInMinutes,
                                           distance: selectedWorkoutDistance,
                                           energyBurned: selectedEnergyBurned)
  }
  
}

//MARK: DatePickerCellDelegate
extension CreateWorkoutTableViewController: DatePickerCellDelegate {
  
  func datePickerCell(cell: DatePickerCell, didSelect date: Date) {
    
    switch cell.inputMode {
    case .date:
      selectedWorkoutDate = date
    case .time:
      selectedWorkoutStartTime = date
    default: break
    }
    
    updateWorkout()
    updateOKButtonStatus()
  }
  
}

//MARK: NumberCellDelegate
extension CreateWorkoutTableViewController: NumberCellDelegate {
  
  func numberCell(_ cell: NumberCell, valueDidChange newValue: Double) {
    
    if cell == workoutDurationCell {
      selectedWorkoutDurationInMinutes = newValue
    }
    
    else if cell == workoutCaloriesCell {
      selectedEnergyBurned = newValue
    }
    
    else if cell == workoutDistanceCell {
      selectedWorkoutDistance = newValue
    }
    
    updateWorkout()
    updateOKButtonStatus()
  }
  
}
