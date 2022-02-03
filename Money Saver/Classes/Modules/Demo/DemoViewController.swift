//
//  ViewController.swift
//  Money Saver
//
//  Created by Viet Hua on 1/19/22.
//

import SnapKit
import RxSwift
import RxCocoa

class DemoViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var demoViewModel: DemoViewModel?
    
    private let loginButton = UIButton(frame: .zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
        
        demoViewModel?.loggedUser.subscribe(onNext: { [weak self] (data) in
            print("email = \(data.email) -- password = \(data.password)")
        }, onCompleted: { [weak self] in
            print("onCompleted")
        })
        .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        loginButton.setTitle("Login Button", for: UIControl.State())
        loginButton.setTitleColor(UIColor.red, for: UIControl.State.normal)
        self.view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.leading.equalToSuperview()
            make.center.equalTo(self.view)
        }
    }
    
    private func bindUI() {
        _ = loginButton.rx.tap
            .bind(onNext: {[weak self] () -> Void in
                self?.demoViewModel?.validateAndLogin(email: "huaviet999@gmail.com", password: "123456")
            }).disposed(by: disposeBag)
    }
    
    
}

