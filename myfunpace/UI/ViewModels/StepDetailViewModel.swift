import Foundation
import CoreMotion

class StepDetailViewModel {
    var stepCount: Double {
        data.steps
    }
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        
        return dateFormatter.string(from: data.date)
    }
    
    private let data: PedometerData
    init(_ data: PedometerData) {
        self.data = data
    }
}
