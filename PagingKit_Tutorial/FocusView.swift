//
//  FocusView.swift
//  PagingKit_Tutorial
//
//  Created by Jeff Jeong on 2020/09/19.
//

import Foundation
import UIKit
import PagingKit

class FocusView: PagingMenuFocusView {
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        print("FocusView - awakeFromNib() called")
    }

}

