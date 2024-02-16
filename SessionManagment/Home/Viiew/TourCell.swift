//
//  TourCell.swift
//  SessionManagment
//
//  Created by Beto Salcido on 16/02/24.
//

import Foundation
import UIKit

class TourCell: UITableViewCell {
    
    private var bindings = Bindings()
    private var viewModel: TourCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
