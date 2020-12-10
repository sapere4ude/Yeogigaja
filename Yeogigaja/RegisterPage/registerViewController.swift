//
//  registerViewController.swift
//  Yeogigaja
//
//  Created by sapere4ude on 2020/11/04.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import JGProgressHUD

class registerViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    // test
    //    private let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIinit()
        
        registerBtn.addTarget(self,
                              action: #selector(registerButtonTapped),
                              for: .touchUpInside)
        
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        scrollView.isUserInteractionEnabled = true
        
        scrollViewTapGesture()
        
    }
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private let scrollView: UIScrollView = {    // scrollView를 사용하는 이유는 키보드에 텍스트 입력할때 밀려올라가는듯한 느낌을 내기 위해서! (중요)
        // 키보드가 텍스트필드의 영역을 가리는 경우를 막기위해서
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
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
    
    
    func UIinit() {
        
        nameField.autocapitalizationType = .none    // 자동 대문자 전환
        nameField.autocorrectionType = .no  // 자동 맞춤법 조정
        nameField.returnKeyType = .continue // 키보드 우측 하단 부분 설정
        nameField.layer.cornerRadius = 12   // text filed 의 모양 조절 (숫자가 클수록 둥글어진다)
        nameField.layer.borderWidth = 1     // border: 가장자리, width: 폭, 너비
        nameField.layer.borderColor = UIColor.lightGray.cgColor // cgColor : A set of components that define a color, with a color space specifying how to interpret them.
        nameField.placeholder = "이름을 입력해주세요"
        nameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0)) // placeholder의 시작 위치를 약간 우측으로 조정해줄 수 있음
        nameField.leftViewMode = .always // leftView에서 정의한 설정을 사용하는 방법
        nameField.backgroundColor = .white
        
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
        
        registerBtn.setTitle("등록하기", for: .normal)
        registerBtn.backgroundColor = .systemRed
        registerBtn.setTitleColor(.white, for: .normal)
        registerBtn.layer.cornerRadius = 12
        registerBtn.layer.masksToBounds = true   // masksToBounds는 layer의 프로퍼티이다
        registerBtn.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        
        view.addSubview(scrollView)
        scrollView.addSubview(nameField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerBtn)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    
    
    func showSuccessHUD() {
        let spinner = JGProgressHUD()
        spinner.textLabel.text = "회원가입에 성공하였습니다!"
        spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
        spinner.show(in: view)
        spinner.dismiss(afterDelay: 2.0)
    }
    
    @objc private func registerButtonTapped() {
        
        emailField.resignFirstResponder()   // 키보드 숨기기
        passwordField.resignFirstResponder()
        nameField.resignFirstResponder()
        
        guard
            let name = nameField.text,
            let email = emailField.text,
            let password = passwordField.text,
            !email.isEmpty,
            !password.isEmpty,
            !name.isEmpty,
            password.count >= 6 else {
            alertUserLoginError()
            return
        }
        
        spinner.show(in: view)
// 157-171 기존에 진행했던 코드 (정상 실행되는 것)
//        // Firebase Log In
//        let yeogigajaUser = YeogigajaAppUser(name: name, emailAddress: email)
//
//
//        DispatchQueue.main.async {
//            self.spinner.dismiss()
//            self.showSuccessHUD()
//            print("성공!")
//        }
//
//        DatabaseManager.shared.insertUser(with: yeogigajaUser, completion: { success in
//            if success {
//                print("success")
//            }
//        })
        DatabaseManager.shared.userExists(with: email, completion: { [weak self] exists in
            guard let strongSelf = self else {
                return
            }
            
            DispatchQueue.main.async {
                strongSelf.spinner.dismiss()
            }

            guard !exists else {
                // user already exists
                strongSelf.alertUserLoginError(message: "Looks like a user account for that email address already exists.")
                return
            }

            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
                // 189-192에서 중복 아이디를 잡아야하는데 잡지 못하고 있음. 그리고 이 부분을 주석처리한 후 중복 아이디를 만들게 될 경우엔 "빈 값이 존재합니다" 코드로 넘어가게 됨
                guard authResult != nil, error == nil else {
                    print("Error currenting user")
                    return
                }

                UserDefaults.standard.setValue(email, forKey: "email")
//                UserDefaults.standard.setValue("\(name)", forKey: "name")

                let yeogigajaUser = YeogigajaAppUser(name: name, emailAddress: email)
                
                
                DatabaseManager.shared.insertUser(with: yeogigajaUser, completion: { success in
                    if success {
                        print("success")
                    }
                })

                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            })
        })
//        print("register 이후 >> ", "\(FirebaseAuth.Auth.auth().currentUser)")
    }
    
    func alertUserLoginError(message: String = "Please enter all information to create a new account.") {
        let alert = UIAlertController(title: "중복된 아이디 혹은\n빈 값이 존재합니다",
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인",
                                      style: .cancel,
                                      handler: nil))
        present(alert,animated: true)
        
    }
    
}


extension registerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        
        if textField == nameField {
            emailField.becomeFirstResponder()   // 키보드 입력커서가 nameField에 존재하고 return 버튼을 누를경우 emailField로 넘어가게 된다.
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            registerButtonTapped()
        }
        
        return true
    }
    
}
