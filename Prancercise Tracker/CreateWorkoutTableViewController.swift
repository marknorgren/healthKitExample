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
  
  private var workout: Workout?
  
  var distanceUnit = DistanceUnit.miles
  
  fileprivate func updateOKButtonStatus() {
    navigationItem.rightBarButtonItem?.isEnabled = workout == nil ? false:true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateOKButtonStatus()
  }
  
  fileprivate func updateWorkout() {
    
  }
  
  //MARK: UITableView Delegate
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    
    let buttonFrame = CGRect(x: 0, y: 0,
                             width: tableView.frame.size.width,
                             height: 44.0)
    
    let button = UIButton(frame: buttonFrame)
    button.setTitle("START PRANCERCISING!", for: .normal)
    button.addTarget(self,
                     action: #selector(startButtonPressed),
                     for: UIControlEvents.touchUpInside)
    button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    return button
  }
  
  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 44.0
  }
  
  func startButtonPressed() {
   
    let alert = UIAlertController(title: nil,
                                  message: "Start a Prancercise routine? (Get those ankle weights ready)", preferredStyle: .alert)
    let yesAction = UIAlertAction(title: "Yes",
                               style: .default,
                               handler: nil)
    
    let noAction = UIAlertAction(title: "No",
                                 style: .cancel,
                                 handler: nil)
    
    alert.addAction(yesAction)
    alert.addAction(noAction)
    
    present(alert, animated: true, completion: nil)
  }
  
}
