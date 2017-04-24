//
//  BMICalculator.swift
//  Prancercise Tracker Starter
//
//  Created by Theodore Bendixson on 4/24/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation

class BMICalculator {
  
  class func bmiWithWeightInKilograms(_ weightInKilograms:Double, heightInMeters:Double) -> Double? {
    
    guard heightInMeters != 0 else {
      return nil
    }
    
    return (weightInKilograms/(heightInMeters*heightInMeters))
  }  
}
