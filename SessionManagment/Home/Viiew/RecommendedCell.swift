//
//  RecommendedCell.swift
//  SessionManagment
//
//  Created by Beto Salcido on 21/02/24.
//

import Foundation
import UIKit

class RecommendedCell: UICollectionViewCell {
    
    @IBOutlet private var wrapperView: UIView!
    @IBOutlet private var backgroundImage: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    private var bindings = Bindings()
    private var viewModel: RecommendedCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wrapperView.layer.cornerRadius = 10
        backgroundImage.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bindings.removeAll()
    }
    
}

// MARK: - CellViewModelConfigurable
extension RecommendedCell: CellViewModelConfigurable {
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellViewModel = cellViewModel as? RecommendedCellViewModel else {
            return
        }
        
        self.viewModel = cellViewModel;
        bindings.removeAll()
        
        viewModel.$titleText
            .assign(to: \.text, on: titleLabel)
            .store(in: &bindings)
        
        viewModel.$descriptionText
            .assign(to: \.text, on: descriptionLabel)
            .store(in: &bindings)
    }
}


