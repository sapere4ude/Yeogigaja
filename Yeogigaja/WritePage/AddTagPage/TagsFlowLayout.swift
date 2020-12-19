import UIKit

class TagsFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesForElementsInRect = super.layoutAttributesForElements(in: rect)
        var newAttributesForElementsInRect = [UICollectionViewLayoutAttributes]()

        var leftMargin: CGFloat = 0.0
        guard var collectionViewWidth = self.collectionView?.frame.width else { return attributesForElementsInRect }
        collectionViewWidth -= (self.sectionInset.right + self.sectionInset.left)

        for attributes in attributesForElementsInRect! {
            if attributes.frame.origin.x == self.sectionInset.left {
                leftMargin = self.sectionInset.left
            } else {
                var newLeftAlignedFrame = attributes.frame
                newLeftAlignedFrame.origin.x = leftMargin
                attributes.frame = newLeftAlignedFrame
            }
            if attributes.frame.origin.x + attributes.frame.size.width > collectionViewWidth {
                var newLeftAlignedFrame = attributes.frame
                newLeftAlignedFrame.origin.x = self.sectionInset.left
                attributes.frame = newLeftAlignedFrame
            }
            leftMargin += attributes.frame.size.width + 8 // Makes the space between cells
            newAttributesForElementsInRect.append(attributes)
        }

        return newAttributesForElementsInRect
    }
}
