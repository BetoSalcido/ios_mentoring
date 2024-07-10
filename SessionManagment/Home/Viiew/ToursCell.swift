//
//  ToursCell.swift
//  SessionManagment
//

//

import Foundation
import UIKit

class ToursCell: UICollectionViewCell {
    
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var seeAllButton: UIButton!
    
    private var viewModel: ToursCellViewModel! {
        didSet {
            configureBindings()
        }
    }
    
    private var bindings = Bindings()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bindings.removeAll()
    }
    
}

// MARK: - UICollectionViewDataSource
extension ToursCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalCellViewModels
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellViewModel = viewModel.cellViewModel(at: indexPath) else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellIdentifier, for: indexPath)
        if let configurable = cell as? CellViewModelConfigurable {
            configurable.configure(cellViewModel: cellViewModel)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ToursCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellViewModel = viewModel.cellViewModel(at: indexPath) else {
            return
        }
        
        cellViewModel.handleSelection()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ToursCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 156, height: 213)
    }
}


// MARK: - Private Methods
private extension ToursCell {
    
    func configureBindings() {
        viewModel.$titleText
            .assign(to: \.text, on: titleLabel)
            .store(in: &bindings)
        
        viewModel.$buttonText
            .sink { [seeAllButton]  in
                seeAllButton?.setTitle($0, for: .normal)
            }
            .store(in: &bindings)
        
        viewModel.reloadData
            .sink { [weak self] in
                guard let self else { return }
                self.collectionView?.reloadData()
            }
            .store(in: &bindings)
    }
}

// MARK: - CellViewModelConfigurable
extension ToursCell: CellViewModelConfigurable {
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellViewModel = cellViewModel as? ToursCellViewModel else {
            return
        }
        
        bindings.removeAll()
        self.viewModel = cellViewModel;
    }
}
