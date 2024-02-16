//
//  CategoriesCell.swift
//  SessionManagment
//
//  Created by Beto Salcido on 13/02/24.
//

import Foundation
import UIKit

class CategoriesCell: UICollectionViewCell {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    private var bindings = Bindings()
    private var viewModel: CategoriesCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bindings.removeAll()
    }
    
}

// MARK: - UICollectionViewDataSource
extension CategoriesCell: UICollectionViewDataSource {

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
extension CategoriesCell: UICollectionViewDelegate {
    // Nothing to do yet
}


// MARK: - CellViewModelConfigurable
extension CategoriesCell: CellViewModelConfigurable {
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellViewModel = cellViewModel as? CategoriesCellViewModel else {
            return
        }
        
        self.viewModel = cellViewModel;
        bindings.removeAll()
        
        viewModel.$indexPath
            .sink { [collectionView] in
                guard let indexPath = $0 else { return }
                collectionView?.selectItem(at: indexPath, animated: false, scrollPosition: .left)
            }
            .store(in: &bindings)
        
        viewModel.reloadData
            .sink { [collectionView] in
                collectionView?.reloadData()
            }
            .store(in: &bindings)
    }
}
