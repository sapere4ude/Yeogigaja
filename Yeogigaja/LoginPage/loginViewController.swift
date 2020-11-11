//
//  loginViewController.swift
//  Yeogigaja
//
//  Created by sapere4ude on 2020/10/31.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import JGProgressHUD


class loginViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private let scrollView: UIScrollView = {    // scrollView를 사용하는 이유는 키보드에 텍스트 입력할때 밀려올라가는듯한 느낌을 내기 위해서! (중요)
        // 키보드가 텍스트필드의 영역을 가리는 경우를 막기위해서
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    func UIinit() {
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        
        emailField.autocapitalizationType = .none    // 자동 대문자 전환
        emailField.autocorrectionType = .no  // 자동 맞춤법 조정
        emailField.returnKeyType = .continue // 키보드 우측 하단 부분 설정
        emailField.layer.cornerRadius = 12   // text filed 의 모양 조절 (숫자가 클수록 둥글어진다)
        emailField.layer.borderWidth = 1     // border: 가장자리, width: 폭, 너비
        emailField.layer.borderColor = UIColor.lightGray.cgColor // cgColor : A set of components that define a color, with a color space specifying how to interpret them.
        emailField.placeholder = "이메일을 입력해주세요"
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0)) // placeholder의 시작 위치를 약간 우측으로 조정해줄 수 있음
        emailField.leftViewMode = .always // leftView에서 정의한 설정을 사용하는 방법
        emailField.backgroundColor = .white
        
        passwordField.autocapitalizationType = .none
        passwordField.autocorrectionType = .no
        passwordField.returnKeyType = .done
        passwordField.layer.cornerRadius = 12
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.lightGray.cgColor
        passwordField.placeholder = "비밀번호를 입력해주세요"
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        passwordField.leftViewMode = .always
        passwordField.backgroundColor = .white
        passwordField.isSecureTextEntry = true
        
        loginBtn.setTitle("로그인 하기", for: .normal)
        loginBtn.backgroundColor = .systemRed
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.layer.cornerRadius = 12
        loginBtn.layer.masksToBounds = true   // masksToBounds는 layer의 프로퍼티이다
        loginBtn.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        
        registerBtn.setTitle("회원가입", for: .normal)
        registerBtn.backgroundColor = .systemRed
        registerBtn.setTitleColor(.white, for: .normal)
        registerBtn.layer.cornerRadius = 12
        registerBtn.layer.masksToBounds = true   // masksToBounds는 layer의 프로퍼티이다
        registerBtn.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginBtn)
        scrollView.addSubview(registerBtn)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIinit()
        
        scrollView.isUserInteractionEnabled = true
        scrollViewTapGesture()
    }
    
    func scrollViewTapGesture() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    
    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
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
            
//            guard let result = authResult, error == nil else {
//                print("Failed to log in user with email: \(email)")
//                return
//            }
//
//            let user = result.user
//
//            UserDefaults.standard.set(email, forKey: "email")
            
//            print("Logged in User: \(user)")
            // dismiss : 뷰 컨트롤러가 수동으로 제공한 뷰 컨트롤러를 해제하는 것
//            strongSelf.navigationController?.dismiss(animated: true, completion: nil)

            let vc = UIStoryboard(name: "Main", bundle: nil)
            let controller = vc.instantiateViewController(withIdentifier: "tableView")
            
            controller.modalPresentationStyle = .fullScreen
            
            strongSelf.present(controller, animated: true, completion: nil)
            
        })
    }
    
    // 회원가입으로 이동
    @IBAction func registerBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "register", bundle: nil)
        let controller = vc.instantiateViewController(withIdentifier: "registerViewController")
        controller.modalPresentationStyle = .formSheet
        self.present(controller, animated: true, completion: nil)
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "입력된 정보가 없습니다",
                                      message: "아이디와 비밀번호를 입력해주세요",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인",
                                      style: .cancel,
                                      handler: nil))
        present(alert,animated: true)   // Present : 뷰 컨트롤러를 표현해주는 것
        
    }
    
}
