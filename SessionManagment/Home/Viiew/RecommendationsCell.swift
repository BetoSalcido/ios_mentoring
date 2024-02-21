//
//  RecommendationsCell.swift
//  SessionManagment
//
//  Created by Beto Salcido on 21/02/24.
//

import Foundation
import UIKit

class RecommendationsCell: UICollectionViewCell {
    
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var titleLabel: UILabel!
    
    private var bindings = Bindings()
    private var viewModel: RecommendationsCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bindings.removeAll()
    }
    
}

// MARK: - UICollectionViewDataSource
extension RecommendationsCell: UICollectionViewDataSource {
    
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
extension RecommendationsCell: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RecommendationsCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 175, height: 142)
    }
}


// MARK: - CellViewModelConfigurable
extension RecommendationsCell: CellViewModelConfigurable {
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellViewModel = cellViewModel as? RecommendationsCellViewModel else {
            return
        }
        
        self.viewModel = cellViewModel;
        bindings.removeAll()
        
        viewModel.$titleText
            .assign(to: \.text, on: titleLabel)
            .store(in: &bindings)
        
        viewModel.reloadData
            .sink { [collectionView]  in
                collectionView?.reloadData()
            }
            .store(in: &bindings)
        
    }
}

