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

import UIKit

class CreateWorkoutTableViewController: UITableViewController {
  
  @IBOutlet private var startTimeLabel: UILabel!
  @IBOutlet private var durationLabel: UILabel!
  
  private var timer:Timer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    timer = Timer.scheduledTimer(withTimeInterval: 1,
                                 repeats: true,
                                 block: { (timer) in
                                 self.updateLabels()
    })
  }
  
  private func updateOKButtonStatus() {
    
    var isEnabled = false
    
    switch WorkoutSession.current.state {

    case .notStarted, .active:
      isEnabled = false

    case .finished:
      isEnabled = true
      
    }
    
    navigationItem.rightBarButtonItem?.isEnabled = isEnabled
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateOKButtonStatus()
  }
  
  private lazy var startTimeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter
  }()
  
  private lazy var durationFormatter: DateComponentsFormatter = {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .positional
    formatter.allowedUnits = [.minute, .second]
    formatter.zeroFormattingBehavior = [.pad]
    return formatter
  }()
  
  func updateLabels() {
    
    let session = WorkoutSession.current
    
    switch session.state {
      
    case .active:
      startTimeLabel.text = startTimeFormatter.string(from: session.startDate)
      let duration = Date().timeIntervalSince(session.startDate)
      durationLabel.text = durationFormatter.string(from: duration)
      
    case .finished:
      startTimeLabel.text = startTimeFormatter.string(from: session.startDate)
      let duration = session.endDate.timeIntervalSince(session.startDate)
      durationLabel.text = durationFormatter.string(from: duration)

      
    default:
      startTimeLabel.text = nil
      durationLabel.text = nil
      
    }
    
  }
  
  //MARK: UITableView Datasource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    switch WorkoutSession.current.state {
      
    case .active, .finished:
      return 2
      
    case .notStarted:
      return 0
      
    }
    
  }
  
  //MARK: UITableView Delegate
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    
    var buttonTitle: String!
    var buttonColor: UIColor!
    
    switch WorkoutSession.current.state {
      
    case .active:
      buttonTitle = "STOP PRANCERCISING"
      buttonColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
      
    case .notStarted:
      buttonTitle = "START PRANCERCISING!"
      buttonColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    
    case .finished:
      buttonTitle = "NEW PRANCERCISE"
      buttonColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
      
    }
    
    let buttonFrame = CGRect(x: 0, y: 0,
                             width: tableView.frame.size.width,
                             height: 44.0)
    
    let button = UIButton(frame: buttonFrame)
    button.setTitle(buttonTitle, for: .normal)
    button.addTarget(self,
                     action: #selector(startStopButtonPressed),
                     for: UIControlEvents.touchUpInside)
    button.backgroundColor = buttonColor
    return button
  }
  
  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 44.0
  }
  
  func beginWorkout() {
    WorkoutSession.current.start()
    updateLabels()
    updateOKButtonStatus()
    tableView.reloadData()
  }
  
  func finishWorkout() {
    WorkoutSession.current.end()
    updateLabels()
    updateOKButtonStatus()
    tableView.reloadData()
  }
  
  func startStopButtonPressed() {

    switch WorkoutSession.current.state {
      
    case .notStarted, .finished:
      displayStartPrancerciseAlert()
      
    case .active:
      finishWorkout()
    }
    
  }
  
  private func displayStartPrancerciseAlert() {
    
    let alert = UIAlertController(title: nil,
                                  message: "Start a Prancercise routine? (Get those ankle weights ready)",
                                  preferredStyle: .alert)
    
    let yesAction = UIAlertAction(title: "Yes",
                                  style: .default) { (action) in
                                    self.beginWorkout()
    }
    
    let noAction = UIAlertAction(title: "No",
                                 style: .cancel,
                                 handler: nil)
    
    alert.addAction(yesAction)
    alert.addAction(noAction)
    
    present(alert, animated: true, completion: nil)
  }
  
}
