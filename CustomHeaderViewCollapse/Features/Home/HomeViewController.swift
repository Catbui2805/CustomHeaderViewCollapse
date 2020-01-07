//
//  HomeViewController.swift
//  CustomHeaderViewCollapse
//
//  Created by Nguyen Tran Cong on 1/7/20.
//  Copyright © 2020 Nguyen Tran. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    let headerViewMaxHeight: CGFloat = 250
    var headerViewMinHeight: CGFloat = 44

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
}

private extension HomeViewController {
    func setupViews() {
        setupHeaderView()
        setupCollectionView()
    }
    
    func setupHeaderView() {
        headerViewMinHeight += view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    func setupCollectionView() {
        collectionView.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as? HomeCell else {
            fatalError("can't dequeue reusable cell Homecell")
        }
        cell.backgroundColor = .brown
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y
        let newHeaderViewHeight: CGFloat = headerViewHeightConstraint.constant - y

        if newHeaderViewHeight > headerViewMaxHeight {
            headerViewHeightConstraint.constant = headerViewMaxHeight
        } else if newHeaderViewHeight < headerViewMinHeight {
            headerViewHeightConstraint.constant = headerViewMinHeight
        } else {
            headerViewHeightConstraint.constant = newHeaderViewHeight
            scrollView.contentOffset.y = 0
        }
    }
}

