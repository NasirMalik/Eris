//
//  PlanetsTableViewCell.swift
//  Eris
//
//  Created by Nasir Mahmood on 28.02.21.
//

import UIKit

class PlanetsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var detail: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        icon.image = UIImage(named: String(format: "planet_%d", Int.random(in: 0...11)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
