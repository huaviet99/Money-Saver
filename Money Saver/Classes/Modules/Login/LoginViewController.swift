//
//  LoginViewController.swift
//  Money Saver
//
//  Created by Viet Hua on 1/19/22.
//

import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var loginViewModel: LoginViewModel?
    
    private let loginButton = UIButton(frame: .zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
        
        loginViewModel?.loggedUser.subscribe(onNext: { [weak self] (data) in
            self?.loginViewModel?.openDemo()
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
            make.center.equalTo(self.view)
        }
    }
    
    private func bindUI() {
        _ = loginButton.rx.tap
            .bind(onNext: {[weak self] () -> Void in
                self?.loginViewModel?.validateAndLogin(email: "huaviet999@gmail.com", password: "123456")
            }).disposed(by: disposeBag)
    }
    
    
}

