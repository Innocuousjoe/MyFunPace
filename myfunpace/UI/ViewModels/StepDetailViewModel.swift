import UIKit
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
    
    var stepAttributedString: NSMutableAttributedString {
        let formattedCount = String(format: "%.0f", stepCount)
        let stepTotalSuffix = "/ \(Constants.stepGoal.formattedWithSeparator)"
        let base = NSMutableAttributedString(
            string: "\(formattedCount) \(stepTotalSuffix)"
        )
        
        let percentage: CGFloat = stepCount / Constants.stepGoal
        let color = Constants.gradientColors.intermediate(percentage: percentage)
        
        base.apply(
            attributes: [.foregroundColor, .font],
            values: [color, UIFont.systemFont(ofSize: 25, weight: .bold)],
            to: formattedCount
        )
        
        base.apply(
            attributes: [.font, .foregroundColor],
            values: [UIFont.systemFont(ofSize: 18, weight: .semibold), UIColor.gray],
            to: stepTotalSuffix
        )
        
        return base
    }

    var floorsString: NSMutableAttributedString {
        let base = NSMutableAttributedString(string: "\(data.ascended) floors ascended, \(data.descended) floors descended")
        base.apply(attribute: .foregroundColor, value: UIColor.darkGray, to: "floors ascended,")
        base.apply(attribute: .foregroundColor, value: UIColor.darkGray, to: "floors descended")
        
        return base
    }
    
    var averagePaceString: NSMutableAttributedString {
        let avgPace = data.averagePace
        let base = NSMutableAttributedString(string: "\(avgPace) seconds per meter")
        base.apply(attribute: .foregroundColor, value: UIColor.darkGray, to: "seconds per meter")
        
        return base
    }
    
    var distanceString: NSMutableAttributedString {
        let distance: Float = data.metersDist
        let base = NSMutableAttributedString(string: "\(String(format: "%.0f", distance)) meters traveled")
        base.apply(attribute: .foregroundColor, value: UIColor.darkGray, to: "meters traveled")
        
        return base
    }
    
    private let data: PedometerData
    init(_ data: PedometerData) {
        self.data = data
    }
}
