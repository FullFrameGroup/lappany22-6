//
//  SemanticRTL.swift
//  Labany
//
//  Created by Eman Gaber on 05/07/2022.
//

import Foundation
import UIKit

protocol SemanticLayoutDelegate: UICollectionViewDelegateFlowLayout {
    func semanticDisposition() -> SemanticDisposition
}

enum SemanticDisposition {
    case leftToRigth
    case rigthToLeft
}

class SemanticLayout: UICollectionViewLayout {

    weak var delegate: SemanticLayoutDelegate!

    fileprivate var cellPadding: CGFloat = 10

    fileprivate var cache = [UICollectionViewLayoutAttributes]()

    fileprivate var contentHeight: CGFloat = 0
    private var rowsWidth : [CGFloat] = [0]
    private var avaiableSpaces : [(Int,CGFloat)] = []
    private var currentRow : Int = 0
    private var rowHeigths : CGFloat = -1.0

    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    private func availableWidthForRow(index:Int) -> CGFloat {
        let ocuppedWidth = self.rowsWidth[index]
        return self.contentWidth - ocuppedWidth
    }

    private func canAddCellAtRow(rowIndex:Int,size:CGSize) ->Bool
    {
        if(availableWidthForRow(index: rowIndex) >= size.width) {
            return true
        }

        return false
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {
        // Check if cache is empty
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }

        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {

            let indexPath = IndexPath(item: item, section: 0)

            let viewSize: CGSize = delegate.collectionView!(collectionView, layout: self, sizeForItemAt: indexPath)
            if(self.rowHeigths < 0) {
                self.rowHeigths = viewSize.height
            }

            let width = viewSize.width
            let height = viewSize.height

            var xOffset = self.rowsWidth[self.currentRow]
            if(self.canAddCellAtRow(rowIndex: self.currentRow, size: viewSize)) {

                if(self.delegate.semanticDisposition() == .rigthToLeft) {
                    xOffset = (contentWidth - self.rowsWidth[self.currentRow]) - width
                }

            } else {
                self.currentRow += 1
                self.rowsWidth.append(0.0)
                xOffset = self.rowsWidth[self.currentRow]
                if(self.delegate.semanticDisposition() == .rigthToLeft) {
                    xOffset = (contentWidth - self.rowsWidth[self.currentRow]) - width
                }

            }

            let yOffset = CGFloat(self.currentRow) * self.rowHeigths

            let frame = CGRect(x: xOffset, y: yOffset, width: width, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)

            contentHeight = max(contentHeight, frame.maxY)

            self.rowsWidth[self.currentRow]  += width
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()

        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
