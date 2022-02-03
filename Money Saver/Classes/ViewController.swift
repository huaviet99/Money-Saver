//
//  ViewController.swift
//  Money Saver
//
//  Created by Viet Hua on 1/19/22.
//

import SnapKit

class ViewController: UIViewController {
    lazy var box = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.view.addSubview(box)
               box.backgroundColor = .green
               box.snp.makeConstraints { (make) -> Void in
                  make.width.height.equalTo(50)
                  make.center.equalTo(self.view)
               }
    }


}

