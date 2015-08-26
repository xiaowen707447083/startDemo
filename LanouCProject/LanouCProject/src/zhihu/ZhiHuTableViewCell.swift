//
//  ZhiHuTableViewCell.swift
//  LanouCProject
//
//  Created by lanou on 15/8/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

import UIKit

class ZhiHuTableViewCell: UITableViewCell {
    var imgView:UIImageView!
    var contentLabel:UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createMyView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }
    
    func createMyView(){
        imgView = UIImageView()
        self.contentView.addSubview(imgView)
        
        
        contentLabel = UILabel()
        self.contentView.addSubview(contentLabel)
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        imgView.frame = CGRectMake(10, 10, self.frame.size.height - 20, self.frame.size.height - 20)
        imgView.backgroundColor = UIColor.greenColor()
        
//        nameLabel.frame = CGRectMake(50, 5, self.frame.size.width - 100, 20)
//        nameLabel.backgroundColor = UIColor.greenColor()
        
        contentLabel.frame = CGRectMake(self.frame.size.height, 10, self.frame.size.width - self.frame.size.height, frame.size.height - 20)
        contentLabel.backgroundColor = UIColor.greenColor()
        contentLabel.font = UIFont.systemFontOfSize(15)
        contentLabel.numberOfLines = 0
    }
    



}
