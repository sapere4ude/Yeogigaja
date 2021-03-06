//
//  WriteContainerViewController.swift
//  Yeogigaja
//
//  Created by 김진태 on 2020/11/28.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class WriteContainerViewController: UIViewController {
    
    var storage = Storage.storage()
    var writePage: [WritePage] = []
    var name: String = ""

    // MARK: - @IBOutlet Properties

    @IBOutlet var toolbar: UIToolbar! {
        didSet {
            self.toolbar.setItems([self.toolbarFlexibleSpace, self.toolbarAddTagButton], animated: false)
        }
    }
    
    // MARK: - Segue. WriteViewController의 파라미터를 WriteViewContainer로 가져오기
    var writeViewController: WriteViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        writeViewController = segue.destination as? WriteViewController
    }
    
    
    // MARK: - Button Action + Firebase 연동
    
    @IBAction func btnDone(_ sender: Any) {
        print(#function)
        let userEmail = Auth.auth().currentUser?.email
        var safeEmail = userEmail!.replacingOccurrences(of: ".", with: "-") // 문자열에서 원하는 문자 다른것으로 대체
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        
        
        // Generate a unique ID for the post and prepare the post database reference
        // 이미지를 저장하기 위한 키를 생성
        let postDatabaseRef = Database.database().reference().child("\(safeEmail)").child("Contents").childByAutoId()

        guard let imageKey = postDatabaseRef.key else {
            dismiss(animated: true, completion: nil)

            return
        }
        
        print("imageKey--->\(imageKey)")
        
        // imageKey 이름으로 된 jpg 파일을 추가
        // Use the unique key as the image name and prepare the storage reference
        let imageStorageRef = Storage.storage().reference().child("photos").child("\(imageKey).jpg")
        
        //63 - 82 까지 test
//        let newElement = [
//            "name" : self.writeViewController?.nameTextField.text!,
//            "location" : self.writeViewController?.locationTextField.text!,
//            "withFriends" : self.writeViewController?.friendsTextField.text!,
//            "description" : self.writeViewController?.descriptionTextView.text!,
//            "image" : imageStorageRef.fullPath
//        ] as [String : Any]
//
////        print(self.writeViewController?.nameTextField.text!)
//
//        Database.database().reference().child("\(safeEmail)").child("Contents").observeSingleEvent(of: .value, with: { snapshot in
//            if var contents = snapshot.value as? [[String: Any]] {
//                // append
//                contents.append(newElement)
//                Database.database().reference().child("\(safeEmail)").child("Contents").setValue(contents)
//            }
//            else {
//                // create
//                Database.database().reference().child("\(safeEmail)").child("Contents").setValue([newElement])
//            }
            
        
        // 같은 사용자가 여러 게시물을 올려도 시간단위를 이용하여 게시물의 이름을 구분할 수 있음
        var data = Data()
            self.writeViewController!.shared.forEach {
                data = $0
                print("data->\(data)")
                let filePath = "\(safeEmail)-"+"images"
                let metaData = StorageMetadata()
                metaData.contentType = "image/png"
                
                let uploadTask = imageStorageRef.putData(data, metadata: metaData) {(metaData, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    } else {
                        print("success")
                    }
                }
                
                uploadTask.observe(.success) { (snapshot) in
                    snapshot.reference.downloadURL(completion: { (url, error) in
                        guard let url = url else { return }
                        let imageFileURL = url.absoluteString
                        print("imageFileURL:\(imageFileURL)")
                        
                        let newElement = [
                            "name" : self.writeViewController?.nameTextField.text!,
                            "location" : self.writeViewController?.locationTextField.text!,
                            "withFriends" : self.writeViewController?.friendsTextField.text!,
                            "description" : self.writeViewController?.descriptionTextView.text!,
                            "image" : "photos/\(imageKey).jpg"
                        ] as [String : Any]

                //        print(self.writeViewController?.nameTextField.text!)
                        
                        Database.database().reference().child("\(safeEmail)").child("Contents").observeSingleEvent(of: .value, with: { snapshot in
                            if var contents = snapshot.value as? [[String: Any]] {
                                // append
                                contents.append(newElement)
                                Database.database().reference().child("\(safeEmail)").child("Contents").setValue(contents)
                            }
                            else {
                                // create
                                Database.database().reference().child("\(safeEmail)").child("Contents").setValue([newElement])
                            }
                        
                    })
                    self.dismiss(animated: true, completion: nil)
                })
                }
            }
    }

    // MARK: - Toolbar Properties

    let toolbarFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    lazy var toolbarAddTagButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "tag"), style: .done, target: self, action: #selector(showAddTagView))
        button.tintColor = .black
        return button
    }()

    lazy var toolbarCloseKeyboardButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"), style: .done, target: self, action: #selector(hideKeyboard))
        button.tintColor = .black
        return button
    }()

    @IBOutlet var toolbarBottomConstraint: NSLayoutConstraint!

    // MARK:- WriteContainerViewController의 Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerForKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unregisterForKeyboardNotifications()
    }

    // MARK: - 키보드 상태에 따른 Toolbar 위치 조절 메소드

    // 코드 출처 - https://m.blog.naver.com/PostView.nhn?blogId=tngh818&logNo=221539007835&categoryNo=29

    private func registerForKeyboardNotifications() {
        // 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func unregisterForKeyboardNotifications() {
        // 옵저버 등록 해제
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double

        // toolbar에서 키보드 닫기 버튼 제거
        self.toolbar.setItems([self.toolbarFlexibleSpace, self.toolbarAddTagButton], animated: false)
        self.view.layoutIfNeeded()

        // 키보드가 나타났을 경우 키보드의 상단에 toolbar가 붙어있도록 toolbarBottomConstraint 조절
        UIView.animate(withDuration: duration) {
            self.toolbarBottomConstraint.constant = 0.0
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue

        // toolbar에 키보드 닫기 버튼 추가
        self.toolbar.setItems([self.toolbarFlexibleSpace, self.toolbarAddTagButton, self.toolbarCloseKeyboardButton], animated: false)
        self.view.layoutIfNeeded()

        // 키보드가 나타났을 경우 키보드의 상단에 toolbar가 붙어있도록 toolbarBottomConstraint 조절
        UIView.animate(withDuration: duration) {
            self.toolbarBottomConstraint.constant = keyboardRectangle.height - self.view.safeAreaInsets.bottom
            self.view.layoutIfNeeded()
        }
    }

    // MARK: - 키보드 숨김 버튼 메소드

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    @objc private func showAddTagView() {
        let writesb = UIStoryboard(name: "Write", bundle: nil)
        let addTagViewIdentifier: String = "AddTagView"
        guard let addTagView: AddTagViewController = writesb.instantiateViewController(identifier: addTagViewIdentifier) as? AddTagViewController else { return }
        addTagView.modalPresentationStyle = .fullScreen
        self.hideKeyboard()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            addTagView.backingImage = self.navigationController?.view.asImage()
            self.present(addTagView, animated: false, completion: nil)
        }
    }

    // MARK: - 네비게이션 바 버튼이 눌렸을 때 불리는 메소드

    @IBAction func writeViewCancelPressed(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func writeViewDonePressed(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension WriteContainerViewController: AddTagViewControllerDelegate {
    func saveTagsAfterClosing(tags: [String]) {
        UserDefaults.standard.set(tags, forKey: "WritePageTags")
    }
}
