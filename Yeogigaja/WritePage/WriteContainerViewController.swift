//
//  WriteContainerViewController.swift
//  Yeogigaja
//
//  Created by 김진태 on 2020/11/28.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class WriteContainerViewController: UIViewController {
    // MARK: - @IBOutlet Properties

    @IBOutlet var toolbar: UIToolbar! {
        didSet {
            self.toolbar.setItems([self.toolbarFlexibleSpace, self.toolbarAddTagButton], animated: false)
        }
    }
    @IBAction func btnDone(_ sender: Any) {
        
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

    // MARKED:- WriteContainerViewController의 Lifecycle
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
