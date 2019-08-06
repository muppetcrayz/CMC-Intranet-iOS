//
//  SettingsTableViewCell.swift
//  CMC Intranet
//
//  Created by Dan Turner on 8/5/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    let label = with(UILabel()) {
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 20)
    }

    let enabledSwitch = UISwitch()

    var switchHandler: ((Bool) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        with(label) {
            $0.usesAutoLayout = true
            addSubview($0)

            $0.snp.makeConstraints {
                $0.top.leading.bottom.equalToSuperview().inset(20)
            }
        }

        with(enabledSwitch) {
            $0.usesAutoLayout = true
            addSubview($0)

            $0.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(20)
                $0.centerY.equalToSuperview()
            }

            $0.addAction(for: .valueChanged) { [weak self] in
                guard let `self` = self else { return }

                self.switchHandler?(self.enabledSwitch.isOn)
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
