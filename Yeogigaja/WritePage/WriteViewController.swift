//
//  WriteViewController.swift
//  Yeogigaja
//
//  Created by 김진태 on 2020/11/26.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class WriteViewController: UITableViewController {
    // MARK: - @IBOutlet Properties

    @IBOutlet var selectImageStackView: UIStackView!
    @IBOutlet var scrollableHorizontalStackView: UIStackView!

    @IBOutlet var nameTextField: RoundedTextField! {
        didSet {
            self.nameTextField.tag = 0
            self.nameTextField.returnKeyType = .continue
        }
    }

    @IBOutlet var locationTextField: RoundedTextField! {
        didSet {
            self.locationTextField.tag = 1
            self.locationTextField.returnKeyType = .continue
        }
    }

    @IBOutlet var tagTextField: RoundedTextField! {
        didSet {
            self.tagTextField.tag = 2
            self.tagTextField.returnKeyType = .continue
        }
    }

    @IBOutlet var friendsTextField: RoundedTextField! {
        didSet {
            self.friendsTextField.tag = 3
            self.friendsTextField.returnKeyType = .continue
        }
    }

    @IBOutlet var descriptionTextView: RoundedTextView! {
        didSet {
            self.descriptionTextView.tag = 4
            self.descriptionTextView.returnKeyType = .done
        }
    }

    // MARK: - 키보드 상태에 따른 뷰의 크기 조절을 위한 Properties

    var keyboardShown: Bool = false // 키보드 상태 확인
    var originY: CGFloat? // 오브젝트의 기본 위치
    var activeTextField: UITextField?

    // MARK: - Gesture Recognizer Properties

    lazy var hideKeyboardTapGestureRecognizer: UITapGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        return gestureRecognizer
    }()

    lazy var selectImageTapGestureRecognizer: UITapGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        return gestureRecognizer
    }()

    // MARK: - Toolbar Properties

    let toolbarFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    let toolbarTagButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "tag"), style: .done, target: self, action: nil)
        button.tintColor = .black
        return button
    }()

    lazy var toolbarCloseKeyboardButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"), style: .done, target: self, action: #selector(hideKeyboard))
        button.tintColor = .black
        return button
    }()

    lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.setItems([toolbarFlexibleSpace, toolbarTagButton], animated: false)
        toolbar.isTranslucent = false
        toolbar.barTintColor = .white
        view.addSubview(toolbar)
        return toolbar
    }()

    var toolbarBottomConstraint: NSLayoutConstraint!

    // MARK: - WriteViewController의 Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setWriteViewController()
        self.addToolbar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerForKeyboardNotifications()
        self.registerGestureRecognizer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.unregisterForKeyboardNotifications()
        self.unregisterGestureRecognizer()
    }

    // MARK: - WriteViewController 초기 설정 담당 Method

    private func setWriteViewController() {
        self.tableView.separatorStyle = .none
        self.descriptionTextView.placeholder = "내용 입력"
        self.descriptionTextView.placeholderFont = .preferredFont(forTextStyle: .subheadline)
    }

    // MARK: - WriteViewController의 Toolbar 설정

    /*
        1. toolbar를 view에 추가해줌
        2. toolbar의 constraint 설정
        3. toolbar의 bottomConstraint를 따로 저장함
     */
    private func addToolbar() {
        view.addSubview(self.toolbar)
        self.toolbar.translatesAutoresizingMaskIntoConstraints = false
        self.toolbar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
        self.toolbar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true
        self.toolbarBottomConstraint = self.toolbar.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0)
        self.toolbarBottomConstraint.isActive = true
    }

    // MARK: - 키보드 상태에 따른 뷰 크기 조절 메소드

    // 코드 출처 - https://m.blog.naver.com/PostView.nhn?blogId=tngh818&logNo=221539007835&categoryNo=29

    func registerForKeyboardNotifications() {
        // 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unregisterForKeyboardNotifications() {
        // 옵저버 등록 해제
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        view.transform = .identity
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double

        // toolbar에서 키보드 닫기 버튼 제거
        self.toolbar.setItems([self.toolbarFlexibleSpace, self.toolbarTagButton], animated: false)
        self.view.layoutIfNeeded()

        // 키보드가 나타났을 경우 키보드의 상단에 toolbar가 붙어있도록 toolbarBottomConstraint 조절
        UIView.animate(withDuration: duration) {
            self.toolbarBottomConstraint.constant = 0.0
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        if let activeTextField: UITextField = activeTextField, activeTextField.isEditing == true {
            self.keyboardAnimate(keyboardRectangle: keyboardRectangle, textField: activeTextField)
        }
        // toolbar에 키보드 닫기 버튼 추가
        self.toolbar.setItems([self.toolbarFlexibleSpace, self.toolbarTagButton, self.toolbarCloseKeyboardButton], animated: false)
        self.view.layoutIfNeeded()

        // 키보드가 나타났을 경우 키보드의 상단에 toolbar가 붙어있도록 toolbarBottomConstraint 조절
        UIView.animate(withDuration: duration) {
            self.toolbarBottomConstraint.constant = self.view.safeAreaInsets.bottom - keyboardRectangle.height
            self.view.layoutIfNeeded()
        }
    }

    func keyboardAnimate(keyboardRectangle: CGRect, textField: UITextField) {
        if keyboardRectangle.height > (view.frame.height - textField.frame.maxY) {
            view.transform = CGAffineTransform(translationX: 0, y: view.frame.height - keyboardRectangle.height - textField.frame.maxY)
        }
    }

    // MARK: - 화면 스크롤 시 또는 터치 시 키보드 숨기기 / 카메라 아이콘 터치 시 이미지 선택

    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }

    @objc func selectImage() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.modalPresentationStyle = .fullScreen
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }

    func registerGestureRecognizer() {
        self.view.addGestureRecognizer(self.hideKeyboardTapGestureRecognizer)
        self.tableView.keyboardDismissMode = .onDrag
        self.selectImageStackView.addGestureRecognizer(self.selectImageTapGestureRecognizer)
    }

    func unregisterGestureRecognizer() {
        self.view.removeGestureRecognizer(self.hideKeyboardTapGestureRecognizer)
        self.tableView.keyboardDismissMode = .none
        self.selectImageStackView.removeGestureRecognizer(self.selectImageTapGestureRecognizer)
    }

    // MARK: - 네비게이션 바 버튼이 눌렸을 때 불리는 메소드

    @IBAction func writeViewClosePressed(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func writeViewDonePressed(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

// 이미지를 선택하였을 때에 이미지 정보를 가져오도록 하는 Delegate. 아직 구현 안함
extension WriteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        self.dismiss(animated: true, completion: nil)
    }
}
