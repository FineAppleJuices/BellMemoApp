//
//  TabelCellView.swift
//  BellMemoApp
//
//  Created by Byeol Kim on 9/21/24.
//

import UIKit

class CodingCustomTableViewCell: UITableViewCell {
    // MARK: - Property
    
    // label 생성
    private let label: UILabel = {
        let label = UILabel()
        label.text = "상어상어"
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setConstraint() {
        contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: img.centerYAnchor)
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
