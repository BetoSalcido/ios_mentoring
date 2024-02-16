//
//  CategoryCell.swift
//  SessionManagment
//
//  Created by Beto Salcido on 13/02/24.
//

import Foundation
import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet private var categoryView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    
    private var bindings = Bindings()
    private var viewModel: CategoryCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryView.layer.cornerRadius = 20
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bindings.removeAll()
    }
    
    override var isSelected: Bool {
        didSet {
            viewModel.handleCellSelection(with: isSelected)
        }
    }
}

// MARK: - CellViewModelConfigurable
extension CategoryCell: CellViewModelConfigurable {
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellViewModel = cellViewModel as? CategoryCellViewModel else {
            return
        }
        
        self.viewModel = cellViewModel;
        bindings.removeAll()
        
        viewModel.$title
            .assign(to: \.text, on: titleLabel)
            .store(in: &bindings)
        
        viewModel.$isSelected
            .sink { [weak self] isSelected in
                guard let self else { return }
                self.categoryView.backgroundColor = isSelected ? UIColor.primary.withAlphaComponent(0.25) : .clear
                self.titleLabel.textColor = isSelected ? UIColor.primary : .lightGray
            }
            .store(in: &bindings)
    }
}
