import Foundation
import CoreMotion

struct SummaryViewModel {
    private let pedometer = CMPedometer()
    
    private let dayToData: [Int: CMPedometerData] = [:]
    
    func viewDidLoad() {
        if CMPedometer.isStepCountingAvailable() {
            let now = Date()
            for delta in 0...6 {
                if let date = Calendar.current.date(byAdding: .day, value: -delta, to: now) {
                    pedometer.queryPedometerData(from: date.startOfDay, to: date.endOfDay) { [weak self] data, error in
                        guard let self, let data, error == nil else { return }
                        let weekday = Calendar.current.component(.weekday, from: date)
                        self.dayToData[weekday] = data
                    }
                }
            }
        }
    }
}
