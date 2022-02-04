//
//  DemoViewController.swift
//  Money Saver
//
//  Created by Viet Hua on 2/3/22.
//

import SnapKit

class DemoViewController: UIViewController {
    
    private let demoText = UILabel(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white

        demoText.text = L10n.welcome
        demoText.textColor = .red
        self.view.addSubview(demoText)
        demoText.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.center.equalTo(self.view)
        }
    }
}
