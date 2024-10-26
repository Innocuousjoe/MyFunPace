import UIKit
import SnapKit
import CoreMotion

class StepSummaryCell: UICollectionViewCell {
    struct ViewModel: Hashable {
        let date: Date
        let pedometerData: CMPedometerData
    }
    
    private(set) lazy var dayLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews(dayLabel)
        
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ viewModel: ViewModel) {
        dayLabel.text = Date.appleDayOfWeek(Calendar.current.component(.weekday, from: viewModel.date))
    }
}
