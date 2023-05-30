//
//  ModalViewController.swift
//  FLUFFY
//
//  Created by 김강현 on 2023/05/30.
//

import UIKit
import PanModal

class ModalViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
}

extension ModalViewController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
    }
    
    var topOffset : CGFloat {
        return 160
    }
    
    var cornerRadius: CGFloat {
        return 12
    }
}

