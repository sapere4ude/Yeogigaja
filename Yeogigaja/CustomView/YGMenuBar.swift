import UIKit

protocol YGMenuBarDelegate: class {
    func menuBar(scrollTo index: Int)
}

class YGMenuBar: UIView {
    weak var delegate: YGMenuBarDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        setupTabBar()
        setupSeparatorView()
    }

    private var tabBarCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()

    private var separatorView: UIView = {
        let separatorView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .lightGray
        return separatorView
    }()

    // MARK: Properties

    /**
        탭의 타이틀에 지정해줄 폰트
     */
    var font: UIFont?
    /**
        탭과 탭 사이의 거리
     */
    var tabSpacing: CGFloat?
    /**
        탭 메뉴들의 타이틀
     */
    var menuTitles: [String]?

    private var _font: UIFont {
        return font ?? UIFont.systemFont(ofSize: 34.0, weight: .bold)
    }

    private var _tabSpacing: CGFloat {
        return tabSpacing ?? 16.0
    }

    private var _menuTitles: [String] {
        return menuTitles ?? ["메뉴 타이틀이", "설정되지 않았습니다", "menuTitles 프로퍼티를 설정해주세요"]
    }

    // MARK: Setup Views

    func showSeparatorView() {
        separatorView.isHidden = false
    }

    func hideSeparatorView() {
        separatorView.isHidden = true
    }

    private func setupCollectionView() {
        let xibname = String(describing: YGMenuBarCell.self)
        tabBarCollectionView.delegate = self
        tabBarCollectionView.dataSource = self
        tabBarCollectionView.showsHorizontalScrollIndicator = false
        tabBarCollectionView.register(UINib(nibName: xibname, bundle: nil), forCellWithReuseIdentifier: xibname)
        tabBarCollectionView.isScrollEnabled = true
        tabBarCollectionView.automaticallyAdjustsScrollIndicatorInsets = true

        let indexPath = IndexPath(item: 0, section: 0)
        selectMenuItem(at: indexPath, animated: false, scrollPosition: [])
    }

    private func setupSeparatorView() {
        addSubview(separatorView)
        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        showSeparatorView()
    }

    private func setupTabBar() {
        setupCollectionView()
        addSubview(tabBarCollectionView)
        tabBarCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tabBarCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tabBarCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tabBarCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    func selectMenuItem(at indexPath: IndexPath, animated: Bool, scrollPosition: UICollectionView.ScrollPosition) {
        tabBarCollectionView.selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)
    }

    func scrollToMenuItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        tabBarCollectionView.scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }
}

// MARK: - UICollectionViewDelegate, DataSource

extension YGMenuBar: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = String(describing: YGMenuBarCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! YGMenuBarCell
        cell.label.text = _menuTitles[indexPath.row]
        cell.label.font = _font
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _menuTitles.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (_menuTitles[indexPath.row] as NSString).size(withAttributes: [NSAttributedString.Key.font: _font]).width
        return CGSize(width: width, height: tabBarCollectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectMenuItem(at: indexPath, animated: true, scrollPosition: [])
        scrollToMenuItem(at: indexPath, at: .centeredHorizontally, animated: true)
        delegate?.menuBar(scrollTo: indexPath.row)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension YGMenuBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return _tabSpacing
    }
}
