//
//  ToursCell.swift
//  SessionManagment
//
//  Created by Beto Salcido on 16/02/24.
//

import Foundation
import UIKit

class ToursCell: UICollectionViewCell {
    
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var seeAllButton: UIButton!
    
    private var bindings = Bindings()
    private var viewModel: ToursCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bindings.removeAll()
    }
    
}

// MARK: - CellViewModelConfigurable
extension ToursCell: CellViewModelConfigurable {
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellViewModel = cellViewModel as? ToursCellViewModel else {
            return
        }
        
        self.viewModel = cellViewModel;
        bindings.removeAll()
        
//        viewModel.$<#BindingName#>
//            .assign(to: \.text, on: <#LabelName#>)
//            .store(in: &bindings)
    }
}
