import Foundation
import CoreMotion

extension CMPedometerData: PedometerData {
  var steps: Double {
      return numberOfSteps.doubleValue
  }

  var distanceTravelled: Double {
    return distance?.doubleValue ?? 0
  }
}

protocol PedometerData {
    var steps: Double { get }
    var distanceTravelled: Double { get }
}

struct MockPedometerData: PedometerData {
    let steps: Double
    let date: Date
    var distanceTravelled: Double
}
