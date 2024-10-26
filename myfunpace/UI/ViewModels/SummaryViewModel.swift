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
    
    var onSnapshotUpdate: ((_ snapshot: Snapshot) -> Void)?
    
    private let pedometer = CMPedometer()
    private var dateToData: [(date: Date, data: CMPedometerData)] = []
    
    func viewDidLoad() {
        if CMPedometer.isStepCountingAvailable() {
            let now = Date()
            for delta in 0...6 {
                if let date = Calendar.current.date(byAdding: .day, value: -delta, to: now) {
                    pedometer.queryPedometerData(from: date.startOfDay, to: date.endOfDay) { [weak self] data, error in
                        guard let data, error == nil else { return }
                        self?.dateToData.append((date: date, data: data))
                        
                        if delta == 6 {
                            DispatchQueue.main.async {                            
                                self?.updateSnapshot()
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    //MARK: Private
    private func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.stepList])
        let sorted = dateToData.sorted(by: { $0.date > $1.date })
        sorted.forEach { snapshot.appendItems([.day(.init(date: $0.date, pedometerData: $0.data))])}
        
        onSnapshotUpdate?(snapshot)
    }
}
