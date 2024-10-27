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
}

protocol PedometerData {
    var steps: Double { get }
    var distanceTravelled: Double { get }
    var date: Date { get }
}

struct MockPedometerData: PedometerData {
    let steps: Double
    let date: Date
    var distanceTravelled: Double
}
