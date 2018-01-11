import HealthKit

class ProfileDataStore {
    class func getAgeSexAndBloodType() throws -> (age: String,
        biologicalSex: HKBiologicalSex,
        bloodType: HKBloodType) {

            let healthKitStore = HKHealthStore()

            do {

                //1. This method throws an error if these data are not available.
                let birthdayComponents =  try healthKitStore.dateOfBirthComponents()
                let biologicalSex =       try healthKitStore.biologicalSex()
                let bloodType =           try healthKitStore.bloodType()

                //2. Use Calendar to calculate age.
                let today = Date()
                let calendar = Calendar.current
                let todayDateComponents = calendar.dateComponents([.year],
                                                                  from: today)
                let ageComponents = calendar.dateComponents([.year], from: birthdayComponents, to: todayDateComponents)
                var age = "Unknown"
                if let ageYear = ageComponents.year {
                    age = "\(ageYear)"
                }

                //3. Unwrap the wrappers to get the underlying enum values.
                let unwrappedBiologicalSex = biologicalSex.biologicalSex
                let unwrappedBloodType = bloodType.bloodType

                return (age, unwrappedBiologicalSex, unwrappedBloodType)
            }
    }

    class func getMostRecentSample(for sampleType: HKSampleType,
                                   completion: @escaping (HKQuantitySample?, Error?) -> Swift.Void) {

        //1. Use HKQuery to load the most recent samples.
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                              end: Date(),
                                                              options: .strictEndDate)

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)

        let limit = 1

        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: mostRecentPredicate,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { (query, samples, error) in

                                            //2. Always dispatch to the main thread when complete.
                                            DispatchQueue.main.async {

                                                guard let samples = samples,
                                                    let mostRecentSample = samples.first as? HKQuantitySample else {

                                                        completion(nil, error)
                                                        return
                                                }

                                                completion(mostRecentSample, nil)
                                            }
        }

        HKHealthStore().execute(sampleQuery)
    }

    // Stackoverflow: https://stackoverflow.com/a/44111542/406
    class func getTodaysStepCount(completion: @escaping (_ steps: Int) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            guard let result = result, let sum = result.sumQuantity() else {
                print("Failed to fetch steps = \(error?.localizedDescription ?? "N/A")")
                completion(0)
                return
            }

            DispatchQueue.main.async {
                completion(Int(sum.doubleValue(for: HKUnit.count())))
            }
        }

        HKHealthStore().execute(query)
    }
}

