import MobileCoreServices
import Social
import UIKit

/**
 캡쳐를 통해서 또는 이미지 파일을 선택하여 공유하였을 때 나타나는 뷰와 연결된 컨트롤러
 */
@objc(ShareViewController)
class ShareViewController: UITableViewController {
    // MARK: - @IBOutlet Properties

    /**
      공유하기로 선택한 이미지가 나타나는 이미지뷰

     1. **이미지뷰의 사이즈가 작은 이유**: 이미지뷰의 크기를 너무 크게 할 경우 공유하기를 시도하고 취소하고 시도하고 취소하고... 이 과정을 반복하면 메모리 오류가 발생할 수 있다.
     2. ShareImage.storyboard에서 크기는 width 100, height 100으로 지정되어 있다.
                             */
    @IBOutlet var passedImageView: UIImageView!

    @IBOutlet var descriptionTextView: RoundedTextView! {
        didSet {
            descriptionTextView.tag = 0
            descriptionTextView.returnKeyType = .continue
        }
    }

    @IBOutlet var nameTextField: RoundedTextField! {
        didSet {
            nameTextField.tag = 1
            nameTextField.returnKeyType = .continue
            nameTextField.delegate = self
        }
    }

    @IBOutlet var locationTextField: RoundedTextField! {
        didSet {
            locationTextField.tag = 2
            locationTextField.returnKeyType = .continue
            locationTextField.delegate = self
        }
    }

    @IBOutlet var dateTextField: RoundedTextField! {
        didSet {
            dateTextField.tag = 3
            dateTextField.returnKeyType = .continue
            dateTextField.delegate = self
        }
    }

    @IBOutlet var friendsTextField: RoundedTextField! {
        didSet {
            friendsTextField.tag = 4
            friendsTextField.returnKeyType = .done
            friendsTextField.delegate = self
        }
    }

    // MARK: - 키보드 상태에 따른 뷰의 크기 조절을 위한 Properties

    var keyboardShown: Bool = false // 키보드 상태 확인
    var originY: CGFloat? // 오브젝트의 기본 위치
    var activeTextField: UITextField?

    // MARK: - ShareViewController의 Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        descriptionTextView.placeholder = "내용"
        descriptionTextView.notifier = self
        handleSharedFile()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        descriptionTextView.becomeFirstResponder() // 뷰가 열릴 때마다 descriptionTextView에 포커싱이 맞추어진 채 키보드가 자동 열리도록 함
        registerForKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }

    // MARK: - 네비게이션바의 취소, 확인 버튼 눌렀을 때 실행되는 메소드 구현

    @IBAction func shareViewControllerCancelPressed(sender: UIBarButtonItem) {
        extensionContext!.completeRequest(returningItems: nil, completionHandler: nil)

        extensionContext!.cancelRequest(withError: NSError(domain: "sapere4ude.Yeogigaja.ShareImageData", code: 0, userInfo: nil))
    }

    @IBAction func shareViewControllerDonePressed(sender: UIBarButtonItem) {
        extensionContext!.completeRequest(returningItems: nil, completionHandler: nil)

        extensionContext!.cancelRequest(withError: NSError(domain: "sapere4ude.Yeogigaja.ShareImageData", code: 0, userInfo: nil))
    }

    // MARK: - 공유한 이미지 처리 코드

    /**
        공유하기 버튼을 이용해 공유된 이미지를 다루는 메소드이다.
        [원본 코드 링크](https://medium.com/macoclock/ios-share-extension-swift-5-1-1606263746b)

        **중요** : '캡쳐한 이미지를 공유하는 경우'와 '사진/파일에서 고른 이미지일 경우'를 따로 나누어 놓았음.
     */
    private func handleSharedFile() {
        // extracting the path to the URL that is being shared
        let attachments: [NSItemProvider] = (extensionContext?.inputItems.first as? NSExtensionItem)?.attachments ?? []
        for provider in attachments {
            // Check if the content type is the same as we expected
            guard let contentType = provider.registeredTypeIdentifiers.first else { return }
            print("contentType : \(contentType)")
            if provider.hasItemConformingToTypeIdentifier(contentType) {
                provider.loadItem(forTypeIdentifier: contentType,
                                  options: nil) { [unowned self] data, error in
                    // Handle the error here if you want
                    guard error == nil else { return }

                    if data is UIImage { // 캡쳐한 이미지일 경우 if문 내부, 사진/파일에서 고른 이미지일 경우 if문 아래의 코드로 이동
                        DispatchQueue.main.async {
                            passedImageView.image = data as? UIImage
                        }
                        return
                    }

                    let savedImageUrl: URL? = getImageUrl(urlKey: "sharedImageUrl")

                    let screenSize = CGSize(width: 300, height: 300)

                    if let url = data as? URL {
                        if url != savedImageUrl {
                            let image: UIImage = downsample(imageAt: url, to: screenSize, scale: 1.0)
                            DispatchQueue.main.async {
                                saveImageUrl(imageUrl: url, urlKey: "sharedImageUrl", value: url)
                                if let imageData: Data = image.pngData() {
                                    saveImage(imageData: imageData, imageKey: "sharedImage", value: imageData)
                                }
                                passedImageView.image = image
                            }

                        } else {
                            DispatchQueue.main.async {
                                guard let imageData: Data = getImage(imageKey: "sharedImage") else { return }
                                passedImageView.image = UIImage(data: imageData)
                            }
                        }
                    }
                }
            }
        }
    }

    private func saveImage(imageData: Data, imageKey: String, value: Any) {
        let userDefaults = UserDefaults()
        userDefaults.set(imageData, forKey: imageKey)
    }

    private func saveImageUrl(imageUrl: URL, urlKey: String, value: Any) {
        let userDefaults = UserDefaults()
        userDefaults.set(imageUrl, forKey: urlKey)
    }

    private func getImageUrl(urlKey: String) -> URL? {
        return UserDefaults().url(forKey: urlKey)
    }

    private func getImage(imageKey: String) -> Data? {
        return UserDefaults().data(forKey: imageKey)
    }

    // Downsampling large images for display at smaller size
    func downsample(imageAt imageURL: URL, to pointSize: CGSize, scale: CGFloat) -> UIImage {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary

        let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions)!

        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [kCGImageSourceCreateThumbnailFromImageAlways: true,
                                 kCGImageSourceShouldCacheImmediately: true,
                                 kCGImageSourceCreateThumbnailWithTransform: true,
                                 kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary
        let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions)!
        return UIImage(cgImage: downsampledImage)
    }

    // MARK: - 키보드 상태에 따른 뷰 크기 조절 메소드

    // 코드 출처 - https://m.blog.naver.com/PostView.nhn?blogId=tngh818&logNo=221539007835&categoryNo=29

    func registerForKeyboardNotifications() {
        // 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unregisterForKeyboardNotifications() {
        // 옵저버 등록 해제
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        view.transform = .identity
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        if let activeTextField: UITextField = activeTextField, activeTextField.isEditing == true {
            keyboardAnimate(keyboardRectangle: keyboardRectangle, textField: activeTextField)
        }
    }

    func keyboardAnimate(keyboardRectangle: CGRect, textField: UITextField) {
        if keyboardRectangle.height > (view.frame.height - textField.frame.maxY) {
            view.transform = CGAffineTransform(translationX: 0, y: view.frame.height - keyboardRectangle.height - textField.frame.maxY)
        }
    }
}

// MARK: - RoundedTextViewDelegate 구현 부분

extension ShareViewController: RoundedTextViewDelegate {
    func roundedTextViewDidReturnPressed() {
        descriptionTextView.resignFirstResponder()
        nameTextField.becomeFirstResponder()
    }
}

// MARK: - 키보드의 다음 버튼을 누를 시 UITextField의 포커싱 이동 구현 부분

extension ShareViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let currentTextFieldTag: Int = textField.tag

        textField.resignFirstResponder()

        if currentTextFieldTag < friendsTextField.tag {
            guard let nextTextField: UITextField = view.viewWithTag(textField.tag + 1) as? UITextField else { return false }
            nextTextField.becomeFirstResponder()
        }
        return true
    }
}
