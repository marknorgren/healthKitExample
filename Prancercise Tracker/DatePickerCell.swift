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

protocol DatePickerCellDelegate: class {
  func datePickerCell(cell: DatePickerCell, didSelect date: Date)
}

class DatePickerCell: UITableViewCell {
  
  enum DatePickerCellInputMode {
    case date, time
  }
  
  weak var delegate: DatePickerCellDelegate?
  
  var inputMode:UIDatePickerMode = .date  {
    didSet {
      datePicker.datePickerMode = inputMode
    }
  }
  
  override func awakeFromNib() {
    setDefaultDate()
  }

  private func setDefaultDate() {
    let endDate = Date()
    let defaultWorkoutDuration = (1.0*60.0*60.0)
    let startDate = endDate.addingTimeInterval(-defaultWorkoutDuration)
    datePicker.date = startDate
    updateDateTimeLabel()
  }
  
  lazy var dateFormatter:DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .none
    formatter.dateStyle = .medium
    return formatter
  }()
  
  lazy var timeFormatter:DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.dateStyle = .none
    return formatter
  }()
  
  lazy var datePicker:UIDatePicker = {
    
    let picker = UIDatePicker()
    
    picker.addTarget(self,
                     action: #selector(datePickerValueChanged),
                     for: UIControlEvents.valueChanged)
    
    return picker
  }()
  
  func updateDateTimeLabel() {
    
    var dateText: String?
    let date = datePicker.date
    
    switch inputMode {
    case .date:
      dateText = dateFormatter.string(from: date)
    case .time:
      dateText = timeFormatter.string(from: date)
    default: break
    }
    
    detailTextLabel?.text = dateText
  }
  
  func datePickerValueChanged( ) {
    updateDateTimeLabel()
    delegate?.datePickerCell(cell: self, didSelect: datePicker.date)
  }
  
  override var canBecomeFirstResponder : Bool {
    return true
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    if selected {
      becomeFirstResponder()
    }
  }
  
  override var inputView: UIView! {
    get {
      return datePicker
    }
  }
  
}
