import Foundation
import CoreMotion

extension CMPedometerData: PedometerData {
    var steps: Double {
        return numberOfSteps.doubleValue
    }

    var distanceTravelled: Double {
        return distance?.doubleValue ?? 0
    }
    
    var date: Date {
        startDate.startOfDay
    }
    
    var ascended: Int {
        floorsAscended?.intValue ?? 0
    }
    
    var descended: Int {
        floorsDescended?.intValue ?? 0
    }
    
    var averagePace: Float {
        averageActivePace?.floatValue ?? 0
    }
    
    var metersDist: Float {
        distance?.floatValue ?? 0
    }
}

protocol PedometerData {
    var steps: Double { get }
    var distanceTravelled: Double { get }
    var date: Date { get }
    var ascended: Int { get }
    var descended: Int { get }
    var averagePace: Float { get }
    var metersDist: Float { get }
}

struct MockPedometerData: PedometerData {
    let steps: Double
    let date: Date
    var distanceTravelled: Double
    var ascended: Int
    var descended: Int
    var averagePace: Float
    var metersDist: Float
    
    init(
        steps: Double, 
        date: Date,
        distanceTravelled: Double = 0,
        ascended: Int = 0,
        descended: Int = 0,
        averagePace: Float = 0,
        metersDist: Float = 0
    ) {
        self.steps = steps
        self.date = date
        self.distanceTravelled = distanceTravelled
        self.ascended = ascended
        self.descended = descended
        self.averagePace = averagePace
        self.metersDist = metersDist
    }
}
