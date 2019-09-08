//
//  TitleAndReadTableViewCell.swift
//  CMC Intranet
//
//  Created by Sage Conger on 9/8/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit

class TitleAndReadTableViewCell: UITableViewCell {
    let dotImageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        with(dotImageView) {
            $0.image = UIImage(named: "dot")
            
            addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.top.bottom.equalToSuperview().inset(8)
                $0.width.equalTo(40)
                $0.height.equalTo(40)
            }
        }
        
        with(titleLabel) {
            $0.textAlignment = .left
            
            addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.bottom.trailing.equalToSuperview().inset(8)
                $0.leading.equalTo(dotImageView.snp.trailing).offset(8)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
