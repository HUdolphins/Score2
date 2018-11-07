//
//  HomeViewCell.swift
//  Score2
//
//  Created by Kazuki Ohashi on 2018/11/06.
//  Copyright © 2018 Kazuki Ohashi. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setGameData(_ gameData: FIRGame){
    
    }
}
