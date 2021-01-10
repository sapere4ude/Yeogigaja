//
//  AddTagViewController.swift
//  Yeogigaja
//
//  Created by 김진태 on 2020/11/29.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

protocol AddTagViewControllerDelegate {
    func saveTagsAfterClosing(tags: [String])
}

class AddTagViewController: UIViewController {
    // MARK: - @IBOutlet Properties
    @IBOutlet var backingImageView: UIImageView!
    @IBOutlet var dimmerView: UIView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var cardContentView: UIView!
    @IBOutlet var handleView: UIView!
    @IBOutlet var tagTextField: UITextField!
    @IBOutlet var tagsFlowCollectionView: UICollectionView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!

    @IBOutlet var cardViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var cardViewBottomConstraint: NSLayoutConstraint!

    @IBOutlet var cardContentViewBottomConstraint: NSLayoutConstraint!
    
    var initialCardContentViewBottomConstant: CGFloat {
        return self.view.safeAreaInsets.bottom
    }

    var delegate: AddTagViewControllerDelegate?
    
    // MARK:- 배경 이미지를 전달받기 위한 Property
    var backingImage: UIImage?

    // MARK:- Card 애니메이션의 constant값을 저장하기 위한 Properties
    let cardStartingTopConstant: CGFloat = 45.0
    var cardPanStartingTopConstant: CGFloat!

    // MARK:- tag 관련 Properties
    var tagsArray: [String] = [String]()
    let tagFont: UIFont = {
        let tagFontSize: CGFloat = 15.0
        let font = UIFont.systemFont(ofSize: tagFontSize, weight: .regular)
        return font
    }()
    
    let maxTagTextCount: Int = 10
    let maxTagCount: Int = 6

    // MARK:- toast 관련 Property
    var toastAnimator: UIViewPropertyAnimator?

    // MARK:- AddTagViewController의 Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backingImageView.image = self.backingImage
        self.setView()
        self.setHandleView()
        self.setCardView()
        self.setDimmerView()
        self.setAnimationInitialValue()
        self.setTagsFlowCollectionView()
        self.setTagTextField()
        self.setButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerForKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unregisterForKeyboardNotifications()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showCard()
        self.tagTextField.becomeFirstResponder()
    }

    // MARK:- AddTagViewController의 각 뷰에 대한 초기값 설정 메소드들
    private func setView() {
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(self.viewPanned(_:)))
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        self.view.addGestureRecognizer(viewPan)
    }

    private func setHandleView() {
        self.handleView.clipsToBounds = true
        self.handleView.layer.cornerRadius = 3.0
    }

    private func setCardView() {
        self.cardView.clipsToBounds = false
        self.cardView.layer.cornerRadius = 10.0
        self.cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.cardContentViewBottomConstraint.constant = self.initialCardContentViewBottomConstant
    }

    private func setDimmerView() {
        let dimmerTap = UITapGestureRecognizer(target: self, action: #selector(self.dimmerViewTapped(_:)))
        self.dimmerView.addGestureRecognizer(dimmerTap)
        self.dimmerView.isUserInteractionEnabled = true
    }

    private func setAnimationInitialValue() {
        let keyWindows: UIWindow? = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        if let safeAreaHeight = keyWindows?.safeAreaLayoutGuide.layoutFrame.height, let bottomPadding = keyWindows?.safeAreaInsets.bottom {
            self.cardViewTopConstraint.constant = safeAreaHeight + bottomPadding
        }
        self.dimmerView.alpha = 0.0
    }

    private func setTagsFlowCollectionView() {
        self.tagsFlowCollectionView.delegate = self
        self.tagsFlowCollectionView.dataSource = self
        self.tagsFlowCollectionView.collectionViewLayout = TagsFlowLayout()
    }

    private func setTagTextField() {
        self.tagTextField.delegate = self
        self.tagTextField.returnKeyType = .done
        self.tagTextField.autocorrectionType = .no
        self.tagTextField.smartQuotesType = .no
        self.tagTextField.smartDashesType = .no
        self.tagTextField.smartInsertDeleteType = .no
    }
    
    private func setButtons() {
        self.saveButton.backgroundColor = .orange
        self.saveButton.contentEdgeInsets = UIEdgeInsets(top: 8.0, left: 64.0, bottom: 8.0, right: 64.0)
        self.saveButton.layer.cornerRadius = self.saveButton.layer.bounds.height / 2.0
        self.saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        self.saveButton.setTitleColor(.white, for: .normal)
        self.saveButton.clipsToBounds = true
        self.setSaveButtonDisabled()
        self.saveButton.setTitleColor(.darkGray, for: .disabled)
        self.cancelButton.backgroundColor = .red
        self.cancelButton.contentEdgeInsets = UIEdgeInsets(top: 8.0, left: 64.0, bottom: 8.0, right: 64.0)
        self.cancelButton.layer.cornerRadius = self.cancelButton.layer.bounds.height / 2.0
        self.cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        self.cancelButton.tintColor = .white
        self.cancelButton.clipsToBounds = true
    }
    
    private func setSaveButtonEnabled() {
        self.saveButton.isEnabled = true
        self.saveButton.backgroundColor = .orange
    }
    
    private func setSaveButtonDisabled() {
        self.saveButton.isEnabled = false
        self.saveButton.backgroundColor = .lightGray
    }

    // MARK:- card 애니메이션 관련 메소드들
    private func showCard() {
        self.view.layoutIfNeeded()
        self.cardViewTopConstraint.constant = self.cardStartingTopConstant
        let showCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn) {
            self.view.layoutIfNeeded()
        }

        showCard.addAnimations {
            self.dimmerView.alpha = 0.7
        }

        showCard.startAnimation()
    }

    private func hideCardAndGoBack() {
        self.hideKeyboard()
        self.view.layoutIfNeeded()
        self.delegate?.saveTagsAfterClosing(tags: tagsArray)
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        self.cardViewTopConstraint.constant = safeAreaHeight + bottomPadding
        let hideCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn) {
            self.view.layoutIfNeeded()
        }

        hideCard.addAnimations {
            self.dimmerView.alpha = 0.0
        }

        hideCard.addCompletion { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }

        hideCard.startAnimation()
    }

    private func dimAlphaWithCardTopConstraint(value: CGFloat) -> CGFloat {
        let fullDimAlpha: CGFloat = 0.7

        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom

        let fullDimPosition = self.cardStartingTopConstant
        let noDimPosition = safeAreaHeight + bottomPadding

        if value < fullDimPosition {
            return fullDimAlpha
        }

        if value > noDimPosition {
            return 0.0
        }

        return fullDimAlpha * (1 - ((value - fullDimPosition) / (noDimPosition - fullDimPosition)))
    }

    @IBAction func dimmerViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        self.hideCardAndGoBack()
    }

    @IBAction func viewPanned(_ panRecognizer: UIPanGestureRecognizer) {
        let transition = panRecognizer.translation(in: self.view)

        self.hideKeyboard()
        self.view.layoutIfNeeded()

        switch panRecognizer.state {
        case .began:
            self.cardPanStartingTopConstant = self.cardViewTopConstraint.constant
        case .changed:
            if self.cardPanStartingTopConstant + transition.y > self.cardStartingTopConstant {
                self.cardViewTopConstraint.constant = self.cardPanStartingTopConstant + transition.y
            }
            self.dimmerView.alpha = self.dimAlphaWithCardTopConstraint(value: self.cardViewTopConstraint.constant)
        case .ended:
            let velocity = panRecognizer.velocity(in: self.view)
            if velocity.y > 1500.0 {
                self.hideCardAndGoBack()
                return
            }
            let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
            let bottomPadding = view.safeAreaInsets.bottom
            if self.cardViewTopConstraint.constant < (safeAreaHeight + bottomPadding) * 0.5 {
                self.showCard()
            } else {
                self.hideCardAndGoBack()
            }
        default:
            break
        }
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction private func addTagViewCloseButtonPressed(_ sender: UIButton) {
        self.hideCardAndGoBack()
    }
    
    @IBAction private func addTagViewConfirmButtonPressed(_ sender: UIButton) {
        self.hideCardAndGoBack()
    }
}

// MARK:- tagsFlowCollectionView의 Layout을 잡아주기 위한 Delegate 구현 Extension
extension AddTagViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = self.tagsArray[indexPath.row]
        let font = self.tagFont
        // String인 태그를 UI로 바꾸었을 때의 Size를 구하는 메소드
        let size = (tag as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
        let dynamicCellWidth = size.width

        /*
           "20.0 + 16.0 * 2"는 셀 내부에 padding을 추가해준다. 20.0은 임의의 값이고 16.0은 cell의 cornerRadius 값이다
         */
        return CGSize(width: dynamicCellWidth + 20.0 + 16.0 * 2, height: 35.0)
    }

    // 상하단 사이의 거리
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }

    // Cell 사이의 거리
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}

// MARK:- tagsFlowCollectionView에 Data를 전달하기 위한 Delegate 구현 Extension
extension AddTagViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tagsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = String(describing: TagsFlowCollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TagsFlowCollectionViewCell

        cell.tagLabel.text = "#\(self.tagsArray[indexPath.row])"

        cell.layer.cornerRadius = 16.0
        cell.layer.backgroundColor = UIColor.systemGray6.cgColor
        cell.tagLabel.textColor = .black
        cell.tagLabel.font = self.tagFont
        cell.contentView.isUserInteractionEnabled = false
        cell.isUserInteractionEnabled = true

        return cell
    }
}

// MARK:- tagsFlowCollectionView의 Cell을 터치하였을 때 삭제되도록 하는 기능을 구현하기 위한 Extension
extension AddTagViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tagsArray.remove(at: indexPath.row)
        collectionView.performBatchUpdates {
            UIView.setAnimationsEnabled(false)
            collectionView.deleteItems(at: [indexPath])
        } completion: { (_) in
            UIView.setAnimationsEnabled(true)
        }
        if self.saveButton.isEnabled {
            self.setSaveButtonDisabled()
        }
    }
}

// MARK:- tagTextField에 입력한 값에 따른 반응을 구현하기 위한 Delegate. Tag 추가도 담당
extension AddTagViewController: UITextFieldDelegate {
    // Return 키의 작동 여부를 판단하는 메소드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if var tagText: String = textField.text {
            // 입력값이 없을 경우 반응하지 않음
            if tagText.isEmpty { return false }
            // 맨 앞의 # 제거
            tagText.removeFirst()
            if tagsArray.contains(tagText) {
                Toast.show(message: "같은 태그는 입력할 수 없습니다.", font: .preferredFont(forTextStyle: .subheadline), in: cardContentView)
                return false
            }
            self.tagsArray.append(tagText)
            let newTagIndex: Int = self.tagsArray.count - 1

            // insertItems 메소드를 사용하면서도 애니메이션 효과를 제거하기 위한 코드
            self.tagsFlowCollectionView.performBatchUpdates({
                UIView.setAnimationsEnabled(false)
                self.tagsFlowCollectionView.insertItems(at: [IndexPath(row: newTagIndex, section: 0)])
            }) { _ in
                UIView.setAnimationsEnabled(true)
            }
            if !self.saveButton.isEnabled {
                self.setSaveButtonEnabled()
            }
            textField.text = ""
            return true
        } else {
            return false
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !textField.isFirstResponder { return true }

        // 사용할 수 없는 특수 문자를 모아놓은 CharacterSet
        let validString = CharacterSet(charactersIn: " !@#$%^&*()+{}[]|\"<>,.~`/:;?-=\\¥'£•¢₩")

        let curTextFieldText: String = textField.text ?? ""

        if curTextFieldText.isEmpty && string == "#" {
            return true
        }

        // 입력값이 emoji일 경우
        if (textField.textInputMode?.primaryLanguage == "emoji") || textField.textInputMode?.primaryLanguage == nil {
            Toast.show(message: "특수문자는 입력할 수 없습니다.", font: .preferredFont(forTextStyle: .subheadline), in: cardContentView)
            return false
        }
        // 입력값이 위에서 지정한 특수 문자일 경우
        if string.rangeOfCharacter(from: validString) != nil {
            Toast.show(message: "특수문자는 입력할 수 없습니다.", font: .preferredFont(forTextStyle: .subheadline), in: cardContentView)
            return false
        }
        
        let isErasing: Bool = string.isEmpty
        
        if curTextFieldText.count >= (maxTagTextCount + 1), !isErasing {
            Toast.show(message: "태그는 최대 \(maxTagTextCount)자까지 입력할 수 있습니다.", font: .preferredFont(forTextStyle: .subheadline), in: cardContentView)
            return false
        }

        if self.tagsArray.count >= self.maxTagCount {
            Toast.show(message: "태그는 최대 \(self.maxTagCount)개까지만 입력할 수 있습니다.", font: .preferredFont(forTextStyle: .subheadline), in: cardContentView)
            return false
        }

        // 처음 입력값이 들어오는 경우 (예 : "" -> "#ㄱ"이 되는 경우)
        let isEmptyToString: Bool = curTextFieldText.isEmpty && range.location == 0 && range.length == 0

        if isEmptyToString {
            textField.text = "#"
            return true
        }

        return true
    }
}

// MARK: - 키보드 상태에 따른 뷰의 높이 조절을 구현하기 위한 extension

extension AddTagViewController {
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

        UIView.animate(withDuration: duration) {
            self.cardViewBottomConstraint.constant = 0.0
            self.cardContentViewBottomConstraint.constant = self.initialCardContentViewBottomConstant
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue

        // 키보드가 나타났을 경우 키보드의 상단에 toolbar가 붙어있도록 toolbarBottomConstraint 조절
        UIView.animate(withDuration: duration) {
            self.cardViewBottomConstraint.constant = keyboardRectangle.height
            self.cardContentViewBottomConstraint.constant = 0.0
            self.view.layoutIfNeeded()
        }
    }
}
