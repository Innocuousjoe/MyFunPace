import UIKit
import SnapKit
import CoreMotion

class StepSummaryCell: UICollectionViewListCell {
    struct ViewModel: Hashable {
        var steps: NSNumber {
            pedometerData.numberOfSteps
        }
        let date: Date
        let pedometerData: CMPedometerData
    }
    
    private(set) lazy var dayLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        return view
    }()
    
    private(set) lazy var stepCountLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12, weight: .light)
        view.textColor = .gray
        
        return view
    }()
    
    var viewModel: ViewModel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews(dayLabel, stepCountLabel)
        
        dayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
        }
        stepCountLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(5)
            make.leading.equalTo(dayLabel)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ viewModel: ViewModel) {
        self.viewModel = viewModel
        dayLabel.text = Date.appleDayOfWeek(Calendar.current.component(.weekday, from: viewModel.date))
        stepCountLabel.text = "Total steps: \(viewModel.steps)"
    }
}
