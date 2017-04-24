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
import HealthKit

class ProfileViewController: UITableViewController {
    
  private enum ProfileSection: Int {
    case ageSexBloodType
    case weightHeightBMI
    case readHealthKitData
    case saveBMI
  }
  
  @IBOutlet private var ageLabel:UILabel!
  @IBOutlet private var bloodTypeLabel:UILabel!
  @IBOutlet private var biologicalSexLabel:UILabel!
  @IBOutlet private var weightLabel:UILabel!
  @IBOutlet private var heightLabel:UILabel!
  @IBOutlet private var bmiLabel:UILabel!
  
  private var bmi:Double?
  
  func updateHealthInfo() {
    
    readProfileInfoFromHealthKit()
    updateWeight()
    updateHeight()
    
  }
  
  func readProfileInfoFromHealthKit() {
    print("TODO: update profile Information")
  }
  
  func updateHeight() {
    print("TODO: update Height")
  }
  
  func updateWeight() {
    print("TODO: update Weight")
  }
  
  func updateBMI() {
    print("TODO: update BMI")
  }
  
  func saveBMI() {
    print("TODO: save BMI sample")
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    guard let section = ProfileSection(rawValue: indexPath.section) else {
      fatalError("A ProfileSection should map to the index path's section")
    }
    
    switch section {
    case .saveBMI:
      saveBMI()
    case .readHealthKitData:
      updateHealthInfo()
    default: break
    }
    
  }
  
}
