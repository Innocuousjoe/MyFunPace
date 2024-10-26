import UIKit
import SnapKit

class ViewController: UIViewController {
    private(set) lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
    }()
    
    private(set) lazy var layout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { [unowned self] sectionIndex, environment in
            let sectionItem = self.dataSource.snapshot().sectionIdentifiers[sectionIndex]
            let layoutSection = self.layout(for: sectionItem)
            
            return layoutSection
        }
        
        return layout
    }()
    
    private(set) lazy var dataSource: UICollectionViewDiffableDataSource<SummaryViewModel.Section, SummaryViewModel.Item> = {
        let summaryReg = UICollectionView.CellRegistration<StepSummaryCell, StepSummaryCell.ViewModel> { [weak self] (cell, indexPath, viewModel) in
            
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

