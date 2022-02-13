//
//  DemoViewController.swift
//  Money Saver
//
//  Created by Viet Hua on 2/3/22.
//

import SnapKit
import RxSwift
import RxCocoa

class DemoViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let addDemoButton = UIButton(frame: .zero)
    private let fetchDemoButton = UIButton(frame: .zero)

    var demoViewModel: DemoViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        addDemoButton.setTitle("Add Demo", for: UIControl.State())
        addDemoButton.setTitleColor(UIColor.red, for: UIControl.State.normal)
        
        self.view.addSubview(addDemoButton)
        addDemoButton.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.center.equalTo(self.view)
        }
        
        fetchDemoButton.setTitle("Fetch Demo", for: UIControl.State())
        fetchDemoButton.setTitleColor(UIColor.red, for: UIControl.State.normal)
        
        self.view.addSubview(fetchDemoButton)
        fetchDemoButton.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.top.equalTo(addDemoButton.snp.bottom).offset(-18)
        }
    }
    
    private func bindUI() {
        _ = addDemoButton.rx.tap
            .bind(onNext: {[weak self] () -> Void in
                self?.demoViewModel?.createDemo()
            }).disposed(by: disposeBag)
        
        _ = fetchDemoButton.rx.tap
            .bind(onNext: {[weak self] () -> Void in
                self?.demoViewModel?.fetchAllDemos()
            }).disposed(by: disposeBag)
    }
}
