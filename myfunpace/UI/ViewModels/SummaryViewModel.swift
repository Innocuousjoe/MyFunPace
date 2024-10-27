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
    
    private var dateToData: [(date: Date, data: PedometerData)] = []
    private let pedometer: Pedometer
    
    init(_ pedometer: Pedometer) {
        self.pedometer = pedometer
    }
    
    func viewDidLoad() {
        if pedometer.isCountingAvailable {
            let now = Date()
            for delta in 0...6 {
                if let date = Calendar.current.date(byAdding: .day, value: -delta, to: now) {
                    pedometer.pedometerData(from: date.startOfDay, to: date.endOfDay) { [weak self] data, error in
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
        } else {
            let newData = MockPedometerData(steps: 101, date: Date(), distanceTravelled: 123)
            
            dateToData.append((date: newData.date, data: newData))
            
            updateSnapshot()
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
