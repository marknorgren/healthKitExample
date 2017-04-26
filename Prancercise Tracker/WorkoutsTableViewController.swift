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

public enum DistanceUnit:Int {
  case miles=0, kilometers=1
}

class WorkoutsTableViewController: UITableViewController {
  
  private enum WorkoutsSegues: String {
    case showCreateWorkout
    case finishedCreatingWorkout
  }
  
  var distanceUnit = DistanceUnit.miles
  
  // MARK: - Formatters
  lazy var dateFormatter:DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.dateStyle = .medium
    return formatter
  }()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    self.clearsSelectionOnViewWillAppear = false
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
    if  segue.identifier == WorkoutsSegues.showCreateWorkout.rawValue,
        let createWorkoutVC = segue.destination as? CreateWorkoutTableViewController {
        createWorkoutVC.distanceUnit = distanceUnit
    }
  }
  
  @IBAction func unitsChanged(_ sender:UISegmentedControl) {
    distanceUnit  = DistanceUnit(rawValue: sender.selectedSegmentIndex)!
    tableView.reloadData()
  }
  
  @IBAction func unwindToWorkouts (_ segue : UIStoryboardSegue) {
    
    if  segue.identifier == WorkoutsSegues.finishedCreatingWorkout.rawValue {
        saveWorkoutToHealthKit()
    }
  }
  
  private func saveWorkoutToHealthKit() {
    
  }
  
}
