//
//  MovieDetailsCollectionView.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 20/07/2022.
//

import UIKit

final class MovieDetailsCollectionView: UICollectionView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        alwaysBounceVertical = false
        bounces = false
        backgroundColor = .clear
        allowsMultipleSelection = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        let headerNib = UINib(nibName: MovieDetailsHeaderReusableView.reuseIdentifier, bundle: nil)
        register(headerNib, forSupplementaryViewOfKind: MovieDetailsCollectionView.elementKindSectionHeader, withReuseIdentifier: MovieDetailsHeaderReusableView.reuseIdentifier)
        
        let sectionHeaderNib = UINib(nibName: SectionTitleReusableHeaderView.reuseIdentifier, bundle: nil)
        register(sectionHeaderNib, forSupplementaryViewOfKind: MovieDetailsCollectionView.elementKindSectionHeader, withReuseIdentifier: SectionTitleReusableHeaderView.reuseIdentifier)
        
        let synopsisCellNib = UINib(nibName: SynopsisCollectionViewCell.reuseIdentifier, bundle: nil)
        register(synopsisCellNib, forCellWithReuseIdentifier: SynopsisCollectionViewCell.reuseIdentifier)
        
        let castCellNib = UINib(nibName: CastCollectionViewCell.reuseIdentifier, bundle: nil)
        register(castCellNib, forCellWithReuseIdentifier: CastCollectionViewCell.reuseIdentifier)
        
        let directorsCellNib = UINib(nibName: DirectorsCollectionViewCell.reuseIdentifier, bundle: nil)
        register(directorsCellNib, forCellWithReuseIdentifier: DirectorsCollectionViewCell.reuseIdentifier)
        
        let genresCellNib = UINib(nibName: GenresCollectionViewCell.reuseIdentifier, bundle: nil)
        register(genresCellNib, forCellWithReuseIdentifier: GenresCollectionViewCell.reuseIdentifier)
    }

}
