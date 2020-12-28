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

    // 이미지 추가를 위한 IBOutlet
    @IBOutlet weak var inputImage: UIImageView!
    
    
    @IBOutlet var selectImageStackView: UIStackView! {
        didSet {
            self.selectImageStackView.layer.cornerRadius = 8.0
            self.selectImageStackView.layer.borderWidth = 1.0
            self.selectImageStackView.layer.borderColor = UIColor.lightGray.cgColor

            // selectImageStackView에 Padding 추가
            self.selectImageStackView.layoutMargins = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
            self.selectImageStackView.isLayoutMarginsRelativeArrangement = true
        }
    }
    @IBOutlet var scrollableHorizontalStackView: UIStackView!


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

    @IBOutlet var nameTextField: RoundedTextField!
    @IBOutlet var locationTextField: RoundedTextField!
//    @IBOutlet var friendsTextField: RoundedTextField!
//    @IBOutlet var descriptionTextView: RoundedTextView!
    
    // MARK: - Gesture Recognizer Properties

    lazy var hideKeyboardTapGestureRecognizer: UITapGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        return gestureRecognizer
    }()

    lazy var selectImageTapGestureRecognizer: UITapGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        return gestureRecognizer
    }()
    
    // MARK: - WriteViewController의 Lifecycle
    override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()
        self.setWriteViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        super.viewWillAppear(animated)
        self.registerGestureRecognizer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        print(#function)
        super.viewWillDisappear(true)
        self.unregisterGestureRecognizer()
    }

    // MARK: - WriteViewController 초기 설정 담당 Method

    private func setWriteViewController() {
        self.tableView.separatorStyle = .none
        self.descriptionTextView.placeholder = "내용 입력"
        self.descriptionTextView.placeholderFont = .preferredFont(forTextStyle: .subheadline)
        self.descriptionTextView.delegate = self
    }

    // MARK: - 화면 스크롤 시 또는 터치 시 키보드 숨기기 / 카메라 아이콘 터치 시 이미지 선택

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    // 이미지 선택
    @objc private func selectImage() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.modalPresentationStyle = .fullScreen
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }

    private func registerGestureRecognizer() {
        self.view.addGestureRecognizer(self.hideKeyboardTapGestureRecognizer)
        self.tableView.keyboardDismissMode = .onDrag
        self.selectImageStackView.addGestureRecognizer(self.selectImageTapGestureRecognizer)
    }

    private func unregisterGestureRecognizer() {
        self.view.removeGestureRecognizer(self.hideKeyboardTapGestureRecognizer)
        self.tableView.keyboardDismissMode = .none
        self.selectImageStackView.removeGestureRecognizer(self.selectImageTapGestureRecognizer)
    }

    // MARK: - TableView를 맨 아래로 스크롤하는 메소드
    private func scrollToBottom() {
        let point = CGPoint(x: 0, y: self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.frame.height)
        if point.y >= 0 {
            self.tableView.setContentOffset(point, animated: true)
        }
    }
}

// MARK: - 이미지를 선택하였을 때에 이미지 정보를 가져오도록 하는 Delegate. 아직 구현 안함

extension WriteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        self.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
    }
}

// MARK: - TextView를 선택하였을 때 맨 아래로 스크롤되도록 하기 위한 Delegate.

extension WriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.scrollToBottom()
    }
}
