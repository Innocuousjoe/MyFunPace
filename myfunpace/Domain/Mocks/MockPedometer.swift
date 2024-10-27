import Foundation
import CoreMotion

extension CMPedometer: Pedometer {
    func pedometerData(from start: Date, to end: Date, withHandler: @escaping (CMPedometerData?, Error?) -> Void) {
        self.queryPedometerData(from: start, to: end, withHandler: withHandler)
    }
    
    var isCountingAvailable: Bool {
        CMPedometer.isStepCountingAvailable()
    }
    
}

protocol Pedometer {
    var isCountingAvailable: Bool { get }
    func pedometerData(from start: Date, to end: Date, withHandler: @escaping CMPedometerHandler)
}

struct MockPedometer: Pedometer {
    func pedometerData(from start: Date, to end: Date, withHandler: (CMPedometerData?, Error?) -> Void) {
        
    }
    
    var isCountingAvailable: Bool {
        false
    }
}
