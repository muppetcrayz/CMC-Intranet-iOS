//
//  ViewController.swift
//  Harbor Cleaners
//
//  Created by Sage Conger on 9/27/19.
//  Copyright © 2019 dubtel. All rights reserved.
//

import UIKit
import SnapKit
import SwiftMessages
import SwiftyJSON

class LoginViewController: UIViewController {
    let centerView = UIView()

    let logoImageView = UIImageView()

    let usernameField = UITextField()
    let passwordField = UITextField()

    let submitButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white

        with(centerView) {
            view.addSubview($0)

            $0.snp.makeConstraints {
                $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(32)
                $0.centerY.equalTo(view.safeAreaLayoutGuide)
            }
        }

        with(logoImageView) {
            $0.image = UIImage(named: "logo")
            $0.contentMode = .scaleAspectFit

            centerView.addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(0.5)
                $0.height.equalTo(logoImageView.snp.width).multipliedBy(0.324)
            }
        }

        with(usernameField) {
            centerView.addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalTo(logoImageView.snp.bottom).offset(24)
                $0.leading.trailing.equalToSuperview()
            }

            $0.placeholder = "Email"

            $0.keyboardType = .emailAddress
            $0.autocapitalizationType = .none
        }

        with(passwordField) {
            centerView.addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalTo(usernameField.snp.bottom).offset(8)
                $0.leading.trailing.equalToSuperview()
            }

            $0.placeholder = "Password"

            $0.autocapitalizationType = .none
            $0.isSecureTextEntry = true
        }

        with(submitButton) {
            centerView.addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalTo(passwordField.snp.bottom).offset(24)
                $0.bottom.equalToSuperview()
                $0.leading.trailing.equalToSuperview()
            }

            $0.setTitle("Submit", for: .normal)
            $0.setTitleColor(.black, for: .normal)

            $0.addAction(for: .touchUpInside) {
                self.startLogin()
            }
        }
    }

    func startLogin() {
        if (!usernameField.text!.isEmpty && !passwordField.text!.isEmpty) {
            let request = URLRequest(url: URL(string: baseURLString + "/login-validate.php?username=\(usernameField.text!)&password=\(passwordField.text!)")!)
            let urlSession = URLSession(configuration: .default)
            urlSession.dataTask(with: request) { data, response, error in
                guard let data = data else { return }
                do {
                    let json = try JSON(data: data)
                    if (json["error"].stringValue != "") {
                        print(json)
                        DispatchQueue.main.async {
                            SwiftMessages.show(view: MessageView.error("Credential", body: "Please check your input and try again."))
                        }
                    }
                    else {
                        let defaults = UserDefaults.standard
                        defaults.set(json["ID"].intValue, forKey: "user_id")
                        DispatchQueue.main.async {
                            self.navigationController?.pushViewController(FeedTabBarController(), animated: true)
                        }
                    }
                }
                catch let error {
                    print(error.localizedDescription)
                }
            }.resume()
        }
        else {
            SwiftMessages.show(view: MessageView.error("Validation", body: "Please fill out all fields."))
        }
    }


}

