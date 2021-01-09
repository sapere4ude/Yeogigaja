//
//  SettingDetailViewController.swift
//  Yeogigaja
//
//  Created by 송서영 on 2020/12/31.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class SettingDetailViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userPasswordCheck: UITextField!
    @IBOutlet weak var passwordCheckLabel: UILabel!
    
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISet(self.userName)
        UISet(self.userId)
        UISet(self.userPassword)
        UISet(self.userPasswordCheck)
        self.passwordCheckLabel.isHidden = true
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.userImg.addGestureRecognizer(tapGesture)
        imagePicker.delegate = self
        self.makeCircleImg()
    }
    // 사용자 이미지 원형으로 만들기
    func makeCircleImg(){
        self.userImg.layer.cornerRadius = userImg.frame.size.height/2
        self.userImg.layer.borderWidth = 1
        self.userImg.layer.borderColor = UIColor.clear.cgColor
        self.userImg.clipsToBounds = true
    }
    //MARK: UISetting
    func UISet(_ textField: UITextField) {
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        
        if textField == self.userPassword || textField == self.userPasswordCheck {
            textField.isSecureTextEntry = true
        }
        
    }

    //MARK: 비밀번호가 같은지 체크
    func checkingSafe() -> Bool {
        if self.userPassword.text != self.userPasswordCheck.text {
            print("password 일치x")
            self.passwordCheckLabel.text = "비밀번호가 일치하지 않습니다."
            self.passwordCheckLabel.textColor = .red
            self.passwordCheckLabel.isHidden = false
            return false
        }
        else{
            return true
        }
    }
    
    //MARK: navigation bar button 완료 (데이터 전송 필요)
    @IBAction func completeBtnPressed(_ sender: Any) {
        if checkingSafe() && (self.userId.text != nil) && (self.userName.text != nil) {
            print("성공적으로 회원정보 수정 완료")
            //MARK: 서버로 수정된 데이터 정보 보내기 필요
            self.navigationController?.popViewController(animated: true)
        }
        
        // 회원정보를 제대로 넘길 수 없는 경우 alert
        else{
            if checkingSafe() == false{
                makeAlert(style: UIAlertController.Style.alert, "회원정보 수정", "비밀번호가 일치하지 않습니다.")
            }
            else{
                    if self.userId.text == nil {
                    makeAlert(style: UIAlertController.Style.alert, "회원정보 수정", "아이디가 입력되지 않았습니다.")
                } else{
                    makeAlert(style: UIAlertController.Style.alert, "회원정보 수정", "이름이 입력되지 않았습니다.")
                }
            }
            
        }
    }
    
    //MARK: making alert controller
    func makeAlert(style: UIAlertController.Style, _ title: String, _ message: String){
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {_ in print("확인")})
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK: user image change 관련 메소드
    @IBAction func tapImgeSelect(_ sender: Any) {
        let alert = UIAlertController(title: "사용자 사진", message: "사진을 추가하는 방법 선택하기.", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "갤러리", style: .default) {
            (action) in self.openLibrary()      }
        let camera = UIAlertAction(title: "카메라", style: .default) {
            (action) in self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    func openLibrary(){
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    func openCamera(){
        //카메라 타입을 사용할 수 있는지 체크
        if (UIImagePickerController .isSourceTypeAvailable(.camera)){
            imagePicker.sourceType = .camera
            present(imagePicker, animated: false, completion: nil)
        } else{
            print("not available")
        }

    }
    
}

//MARK:- extension ImagePicker
extension SettingDetailViewController: UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //갤러리에서 이미지 형식에 맞는 이미지를 가져오는지 옵셔널체크
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.userImg.image = originalImage
        }
        self.dismiss(animated: true, completion: nil)
    }

}
