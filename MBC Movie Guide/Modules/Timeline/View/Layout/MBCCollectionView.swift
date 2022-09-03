//
//  MBCCollectionView.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 14/07/2022.
//

import UIKit

final class MBCCollectionView: UICollectionView {
    
    private let compositionalLayout: UICollectionViewCompositionalLayout = {
        
        let item = CompositionalLayout.createItem(width: .fractionalWidth(0.99), height: .fractionalHeight(1), padding: 0)
        let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .absolute(118), height: .absolute(200), items: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 1
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 2, bottom: 15, trailing: 2)
        
        // background for section
        let sectionBackgroundSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(250))
        let sectionBackgroundAnchor = NSCollectionLayoutAnchor(edges: [.all])
        let sectionBackground = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: sectionBackgroundSize,
                    elementKind: BackgroundSupplementaryView.kind,
                    containerAnchor: sectionBackgroundAnchor)
        sectionBackground.zIndex = 0
        sectionBackground.contentInsets = NSDirectionalEdgeInsets(top: -40, leading: 0, bottom: 10, trailing: 0)
               
        // header
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: MBCCollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [sectionBackground, headerItem]
        
        section.supplementariesFollowContentInsets = false
        
        // Carousel effect
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                if item.representedElementKind != BackgroundSupplementaryView.kind {
                    
                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                    let minScale: CGFloat = 0.95
                    let maxScale: CGFloat = 1.1
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
            }
        }
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionViewLayout = compositionalLayout

        backgroundColor = .clear
        allowsMultipleSelection = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        register(BackgroundSupplementaryView.self,
                forSupplementaryViewOfKind: BackgroundSupplementaryView.kind,
                withReuseIdentifier: BackgroundSupplementaryView.reuseIdentifier)
    }

}
