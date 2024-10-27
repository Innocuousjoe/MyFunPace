import Foundation
import CoreMotion

class StepDetailViewModel {
    var stepCount: Double {
        data.steps
    }
    
    private let data: PedometerData
    init(_ data: PedometerData) {
        self.data = data
    }
}
