import UIKit
import SnapKit

class SummaryViewController: UIViewController {
    private(set) lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
    }()
    
    private(set) lazy var layout: UICollectionViewCompositionalLayout = {
        var listConfig = UICollectionLayoutListConfiguration(appearance: .plain)
        listConfig.separatorConfiguration.color = .tertiarySystemFill

        let indexPathToHide = IndexPath()
         
        listConfig.itemSeparatorHandler = { (indexPath, sectionSeparatorConfiguration) in
            var configuration = sectionSeparatorConfiguration
            if indexPath == indexPathToHide {
                configuration.bottomSeparatorVisibility = .hidden
            }
            return configuration
        }


        let layout = UICollectionViewCompositionalLayout.list(using: listConfig)
        
        return layout
    }()
    
    private(set) lazy var dataSource: UICollectionViewDiffableDataSource<SummaryViewModel.Section, SummaryViewModel.Item> = {
        let summaryReg = UICollectionView.CellRegistration<StepSummaryCell, StepSummaryCell.ViewModel> { [weak self] (cell, indexPath, viewModel) in
            cell.accessories = [.disclosureIndicator()]
            cell.configure(viewModel)
        }
        
        let dataSource = UICollectionViewDiffableDataSource<SummaryViewModel.Section, SummaryViewModel.Item>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case let .day(viewModel):
                return collectionView.dequeueConfiguredReusableCell(using: summaryReg, for: indexPath, item: viewModel)
            }
        }
        
        return dataSource
    }()

    let viewModel: SummaryViewModel
    init() {
        viewModel = SummaryViewModel()
        super.init(nibName: nil, bundle: nil)
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.onSnapshotUpdate = { [weak self] snapshot in
            self?.dataSource.apply(snapshot)
        }
        
        viewModel.viewDidLoad()
    }
    
    //MARK: Private
    private func layout(for section: SummaryViewModel.Section) -> NSCollectionLayoutSection {
        switch section {
        case .stepList:
            let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            let item = NSCollectionLayoutItem(layoutSize: size)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
    }
}

