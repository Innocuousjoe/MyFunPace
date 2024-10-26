import Foundation
import CoreMotion
import UIKit

class SummaryViewModel {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    enum Section: Hashable {
        case stepList
    }
    
    enum Item: Hashable {
        case day(StepSummaryCell.ViewModel)
    }
    
    private let pedometer = CMPedometer()
    private var dayToData: [Int: CMPedometerData] = [:]
    
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
