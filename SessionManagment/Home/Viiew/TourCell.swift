//
//  TourCell.swift
//  SessionManagment
//
//  Created by Beto Salcido on 16/02/24.
//

import Foundation
import UIKit

class TourCell: UICollectionViewCell {
    
    @IBOutlet private var wrapperView: UIView!
    @IBOutlet private var backgroundImage: UIImageView!
    @IBOutlet private var reviewView: UIView!
    @IBOutlet private var reviewLabel: UILabel!
    @IBOutlet private var titleView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var favoriteView: UIView!
    @IBOutlet private var favoriteImage: UIImageView!
    @IBOutlet private var favoriteButton: UIButton!
    
    private var bindings = Bindings()
    private var viewModel: TourCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reviewView.layer.cornerRadius = 10
        titleView.layer.cornerRadius = 10
        wrapperView.layer.cornerRadius = 10
        backgroundImage.layer.cornerRadius = 10
        favoriteView.layer.cornerRadius = favoriteView.layer.bounds.width / 2
        favoriteView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bindings.removeAll()
    }
    
}

// MARK: - CellViewModelConfigurable
extension TourCell: CellViewModelConfigurable {
    
    func configure(cellViewModel: CellViewModel) {
        guard let cellViewModel = cellViewModel as? TourCellViewModel else {
            return
        }
        
        self.viewModel = cellViewModel;
        bindings.removeAll()
        
//        viewModel.$<#BindingName#>
//            .assign(to: \.text, on: <#LabelName#>)
//            .store(in: &bindings)
    }
}
