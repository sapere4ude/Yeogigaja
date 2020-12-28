//
//  WriteViewController.swift
//  Yeogigaja
//
//  Created by 김진태 on 2020/11/26.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import DKImagePickerController
import UIKit

class WriteViewController: UITableViewController {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet var horizontalCollectionImageView: UICollectionView!

//<<<<<<< HEAD
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

//=======
    @IBOutlet var nameTextField: RoundedTextField!
//>>>>>>> YGPageViewController
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

//<<<<<<< HEAD
    // MARK: - 키보드 상태에 따른 뷰의 크기 조절을 위한 Properties

    var keyboardShown: Bool = false // 키보드 상태 확인
    var originY: CGFloat? // 오브젝트의 기본 위치
    var activeTextField: UITextField?

//    @IBOutlet var nameTextField: RoundedTextField!
//    @IBOutlet var locationTextField: RoundedTextField!
//    @IBOutlet var friendsTextField: RoundedTextField!
//    @IBOutlet var descriptionTextView: RoundedTextView!
    
//=======
    @IBOutlet var locationTextField: RoundedTextField!

    // MARK: - Firebase로 옮겨주기 위한 작업

    private var writePages = [WritePage]()

    // MARK: - Firebase 작업

    public func configure(with model: WritePage) {
        self.nameTextField.text = model.name
        self.locationTextField.text = model.location
        self.friendsTextField.text = model.withFriends
        self.descriptionTextView.text = model.description
    }

//>>>>>>> YGPageViewController
    // MARK: - Gesture Recognizer Properties

    lazy var hideKeyboardTapGestureRecognizer: UITapGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gestureRecognizer.cancelsTouchesInView = false
        return gestureRecognizer
    }()

    let maxSelectableImageCount: Int = 6
    var selectableImageCount: Int!
    private var selectedImageAssets: [DKAsset]?
    private lazy var imagePickerController: DKImagePickerController = {
        let imagePickerController = DKImagePickerController()
        imagePickerController.sourceType = .photo
        imagePickerController.assetType = .allPhotos
        imagePickerController.allowSwipeToSelect = true
        imagePickerController.fetchLimit = selectableImageCount
        imagePickerController.showsCancelButton = true
        imagePickerController.showsEmptyAlbums = false
        imagePickerController.modalPresentationStyle = .fullScreen
        imagePickerController.navigationBar.tintColor = .black
        imagePickerController.navigationBar.barTintColor = .white
        imagePickerController.navigationBar.isTranslucent = false
        return imagePickerController
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
        self.selectableImageCount = self.maxSelectableImageCount
        self.setDescriptionTextView()
        self.setHorizontalCollectionImageView()
    }

    private func setDescriptionTextView() {
        self.descriptionTextView.placeholder = "내용 입력"
        self.descriptionTextView.placeholderFont = .preferredFont(forTextStyle: .subheadline)
        self.descriptionTextView.delegate = self
    }

    private func setHorizontalCollectionImageView() {
        self.horizontalCollectionImageView.showsHorizontalScrollIndicator = false
        self.horizontalCollectionImageView.dataSource = self
        self.horizontalCollectionImageView.delegate = self
    }

    // MARK: - 카메라 아이콘 터치 시 이미지 선택

//    private func selectImage() {
//        if self.selectableImageCount <= 0 {
//            let alertController = UIAlertController(title: nil, message: "이미지는 최대 \(maxSelectableImageCount)개만 선택할 수 있습니다.", preferredStyle: .alert)
//            let alertConfirmAction = UIAlertAction(title: "확인", style: .default, handler: nil)
//            alertController.addAction(alertConfirmAction)
//            self.present(alertController, animated: true, completion: nil)
//            return
//        }
//        self.imagePickerController.didSelectAssets = {
//            [unowned self] assets in
//            self.updateAssets(assets: assets)
//            self.imagePickerController.setSelectedAssets(assets: [])
//        }
//
//        self.present(self.imagePickerController, animated: true, completion: nil)
//    }
//<<<<<<< HEAD
    
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
//=======

    private func updateAssets(assets: [DKAsset]) {
        let from = (self.selectedImageAssets?.count ?? 0) + 1
        let to = from + assets.count - 1
        self.selectedImageAssets = (self.selectedImageAssets ?? []) + assets
        var newIndexPaths = [IndexPath]()
        for i in from ... to {
            let newIndexPath = IndexPath(row: i, section: 0)
            newIndexPaths.append(newIndexPath)
//>>>>>>> YGPageViewController
        }
        self.selectableImageCount -= assets.count
        self.imagePickerController.maxSelectableCount = self.selectableImageCount
        self.horizontalCollectionImageView.insertItems(at: newIndexPaths)

        guard let cell = self.horizontalCollectionImageView.cellForItem(at: IndexPath(row: 0, section: 0)) as? HorizontalCollectionImageViewStackCell else { fatalError("Cell Error Occured") }
        cell.setImageCount(count: self.selectedImageAssets?.count ?? 0, maxCount: self.maxSelectableImageCount)
    }

    // MARK: - 화면 스크롤 시 또는 터치 시 키보드 숨기기

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    private func registerGestureRecognizer() {
        self.view.addGestureRecognizer(self.hideKeyboardTapGestureRecognizer)
        self.tableView.keyboardDismissMode = .onDrag
    }

    private func unregisterGestureRecognizer() {
        self.view.removeGestureRecognizer(self.hideKeyboardTapGestureRecognizer)
        self.tableView.keyboardDismissMode = .none
    }

    // MARK: - TableView를 맨 아래로 스크롤하는 메소드

    private func scrollToBottom() {
        let point = CGPoint(x: 0, y: self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.frame.height)
        if point.y >= 0 {
            self.tableView.setContentOffset(point, animated: true)
        }
    }
}

//<<<<<<< HEAD
// MARK: - 이미지를 선택하였을 때에 이미지 정보를 가져오도록 하는 Delegate. 아직 구현 안함

extension WriteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        self.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
    }
}

//=======
//>>>>>>> YGPageViewController
// MARK: - TextView를 선택하였을 때 맨 아래로 스크롤되도록 하기 위한 Delegate.

extension WriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.scrollToBottom()
    }
}

extension WriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + (self.selectedImageAssets?.count ?? 0)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cellIdentifier = String(describing: HorizontalCollectionImageViewStackCell.self)
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? HorizontalCollectionImageViewStackCell else { fatalError("Cell Error Occured") }
            cell.setImageCount(count: self.selectedImageAssets?.count ?? 0, maxCount: self.maxSelectableImageCount)
            return cell
        default:
            let cellIdentifier = String(describing: HorizontalCollectionImageViewImageCell.self)
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? HorizontalCollectionImageViewImageCell else { fatalError("Cell Error Occured") }
            let collectionViewLayout = self.horizontalCollectionImageView.collectionViewLayout as! UICollectionViewFlowLayout
            guard let asset = self.selectedImageAssets?[indexPath.row - 1] else { fatalError("Asset Error Occured") }
            asset.fetchImage(with: CGSize(width: collectionViewLayout.itemSize.width, height: collectionViewLayout.itemSize.height)) { image, _ in
                cell.imageView.image = image
            }
            return cell
        }
    }
}

extension WriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("indexPath.row : \(indexPath.row)")
        switch indexPath.row {
        case 0:
            self.selectImage()
        default:
            self.selectedImageAssets?.remove(at: indexPath.row - 1)
            collectionView.deleteItems(at: [indexPath])
            self.selectableImageCount += 1
            guard let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? HorizontalCollectionImageViewStackCell else { fatalError("Cell Error Occured") }
            cell.setImageCount(count: self.selectedImageAssets?.count ?? 0, maxCount: self.maxSelectableImageCount)
        }
    }
}
