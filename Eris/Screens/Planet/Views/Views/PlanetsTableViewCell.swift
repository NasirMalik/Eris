//
//  PlanetsTableViewCell.swift
//  Eris
//
//  Created by Nasir Mahmood on 28.02.21.
//

import UIKit

final class PlanetsTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var icon: UIImageView!
}

extension PlanetsTableViewCell: ModelConfigurable {
    func configure(with model: PlanetViewData) {
        name.text = model.name
        detail.text = model.terrain
        icon.image = UIImage(named: model.icon)
    }    
}
