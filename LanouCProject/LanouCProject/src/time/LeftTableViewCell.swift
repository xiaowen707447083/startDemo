//
//  LeftTableViewCell.swift
//  LanouCProject
//
//  Created by lanou on 15/8/21.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

import UIKit

class LeftTableViewCell: UITableViewCell {
    
    var imgView:UIImageView!
    var nameLabel:UILabel!
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
        
        nameLabel = UILabel()
        self.contentView.addSubview(nameLabel)
        
        contentLabel = UILabel()
        self.contentView.addSubview(contentLabel)
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        imgView.frame = CGRectMake(5, 5, 40, 40)
        imgView.backgroundColor = UIColor.greenColor()
        
        nameLabel.frame = CGRectMake(50, 5, self.frame.size.width - 100, 20)
        nameLabel.backgroundColor = UIColor.greenColor()
        
//        contentLabel.frame = CGRectMake(50, 30, self.frame.size.width - 55, 50)
        contentLabel.backgroundColor = UIColor.greenColor()
        contentLabel.font = UIFont.systemFontOfSize(15)
        contentLabel.numberOfLines = 0
    }

    //计算高度
    func checkHight() -> CGFloat{
        var hight = UILabel.getLabelHeight(15, labelWidth: self.frame.size.width - 100, content: contentLabel.text)
        
         contentLabel.frame = CGRectMake(50, 30, self.frame.size.width - 100, hight)
        
        return hight + 35
    }

}
