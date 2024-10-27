import Foundation
import UIKit

//Based off of https://stackoverflow.com/a/26578895/638821
class CircleView: UIView {
    let circleLayer: CAShapeLayer!
    
    init() {
        circleLayer = CAShapeLayer()
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAndDraw(duration: TimeInterval, percentage: CGFloat) {
        self.backgroundColor = .clear
            
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(
                x: frame.size.width / 2.0,
                y: frame.size.height / 2.0
            ),
            radius: (frame.size.width - 10)/2,
            startAngle: CGFloat(Double.pi),
            endAngle: CGFloat(Double.pi) + CGFloat(Double.pi * percentage),
            clockwise: true
        )
        
        // Setup the CAShapeLayer with the path, colors, and line width
        let colors: [UIColor] = [.systemRed, .systemYellow, .systemGreen]
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = colors.intermediate(percentage: percentage).cgColor
        circleLayer.lineWidth = 5.0;
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0
        
        // Add the circleLayer to the view's layer's sublayers
        layer.addSublayer(circleLayer)
        
        animateCircle(duration: duration)
    }
    
    private func animateCircle(duration: TimeInterval) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))

        // Set the animation duration appropriately
        animation.duration = duration

        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = 1

        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        circleLayer.strokeEnd = 1.0

        // Do the actual animation
        circleLayer.add(animation, forKey: "animateCircle")
    }
}
