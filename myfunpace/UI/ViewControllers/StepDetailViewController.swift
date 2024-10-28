import Foundation
import UIKit
import SnapKit
import CoreMotion

class StepDetailViewController: UIViewController {
    
    private(set) lazy var goalCircle: CircleView = {
        let view = CircleView()
        
        return view
    }()
    
    private(set) lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.text = viewModel.dateString
        view.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        return view
    }()
    
    private(set) lazy var stepDetailLabel: UILabel = {
        let view = UILabel()
        view.attributedText = viewModel.stepAttributedString
        
        return view
    }()
    
    private var circleLayer: CAShapeLayer!
    private let viewModel: StepDetailViewModel
    init(_ viewModel: StepDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        view.addSubviews(goalCircle, stepDetailLabel, dateLabel)
        goalCircle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(view.frame.width)
        }
        stepDetailLabel.snp.makeConstraints { make in
            make.bottom.equalTo(dateLabel.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
        dateLabel.snp.makeConstraints { $0.center.equalTo(goalCircle.snp.center) }
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
        
        goalCircle.addAndDraw(duration: 0.25, percentage: viewModel.stepCount / Constants.stepGoal)
    }
}
