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

    @IBOutlet var nameTextField: RoundedTextField!
    @IBOutlet var locationTextField: RoundedTextField!
    @IBOutlet var tagTextField: RoundedTextField!
    @IBOutlet var friendsTextField: RoundedTextField!
    @IBOutlet var descriptionTextView: RoundedTextView!

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
        super.viewDidLoad()
        self.setWriteViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerGestureRecognizer()
    }

    override func viewWillDisappear(_ animated: Bool) {
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

    // MARKED: - TableView를 맨 아래로 스크롤하는 메소드
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
    }
}

extension WriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.scrollToBottom()
    }
}
