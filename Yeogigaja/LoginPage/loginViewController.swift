//
//  loginViewController.swift
//  Yeogigaja
//
//  Created by sapere4ude on 2020/10/31.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class loginViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    private let spinner = JGProgressHUD(style: .dark)
    
    func UIinit() {
        
        imageView.contentMode = .scaleAspectFit
        emailField.autocapitalizationType = .none    // 자동 대문자 전환
        emailField.autocorrectionType = .no  // 자동 맞춤법 조정
        emailField.returnKeyType = .continue // 키보드 우측 하단 부분 설정
        emailField.layer.cornerRadius = 12   // text filed 의 모양 조절 (숫자가 클수록 둥글어진다)
        emailField.layer.borderWidth = 1     // border: 가장자리, width: 폭, 너비
        emailField.layer.borderColor = UIColor.lightGray.cgColor // cgColor : A set of components that define a color, with a color space specifying how to interpret them.
        emailField.placeholder = "Email Address..."
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0)) // placeholder의 시작 위치를 약간 우측으로 조정해줄 수 있음
        emailField.leftViewMode = .always // leftView에서 정의한 설정을 사용하는 방법
        emailField.backgroundColor = .white
        
        passwordField.autocapitalizationType = .none
        passwordField.autocorrectionType = .no
        passwordField.returnKeyType = .done
        passwordField.layer.cornerRadius = 12
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.lightGray.cgColor
        passwordField.placeholder = "Password..."
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        passwordField.leftViewMode = .always
        passwordField.backgroundColor = .white
        passwordField.isSecureTextEntry = true
        
        loginBtn.setTitle("Log In", for: .normal)
        loginBtn.backgroundColor = .link
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.layer.cornerRadius = 12
        loginBtn.layer.masksToBounds = true   // masksToBounds는 layer의 프로퍼티이다
        loginBtn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIinit()
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        emailField.resignFirstResponder()       // 키보드 사라지게 함
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text,
            !email.isEmpty, !password.isEmpty, password.count >= 6 else {
                alertUserLoginError()
                return
        }
        
        spinner.show(in: view)
        
        // Firebase Log in
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                strongSelf.spinner.dismiss()
            }

            guard let result = authResult, error == nil else {
                print("Failed to log in user with email: \(email)")
                return
            }
            
            let user = result.user
            
            UserDefaults.standard.set(email, forKey: "email")
            
            print("Logged in User: \(user)")
            // dismiss : 뷰 컨트롤러가 수동으로 제공한 뷰 컨트롤러를 해제하는 것
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        })
    }
    
    @IBAction func registerBtn(_ sender: Any) {
    }

    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter all information to log in",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert,animated: true)   // Present : 뷰 컨트롤러를 표현해주는 것
        
    }
    
}
