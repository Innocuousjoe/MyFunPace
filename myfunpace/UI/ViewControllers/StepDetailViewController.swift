import Foundation
import UIKit
import SnapKit
import CoreMotion

class StepDetailViewController: UIViewController {
    
    private(set) lazy var goalCircle: CircleView = {
        let view = CircleView()
        
        return view
    }()
    
    private var circleLayer: CAShapeLayer!
    private let data: PedometerData
    init(_ data: PedometerData) {
        self.data = data
        
        super.init(nibName: nil, bundle: nil)
        
        view.addSubviews(goalCircle)
        goalCircle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(view.frame.width)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        goalCircle.addAndDraw(duration: 1, percentage: data.steps / Constants.stepGoal)
    }
}
