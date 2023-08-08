//
//  TimelineViewController.swift
//  OneLineDiary
//
//  Created by 박다혜 on 2023/08/02.
//

import UIKit
/*
1. 프로토콜(ex. 부하직원)
2. 컬렉션뷰와 부하직원을 연결 : delegate = self (타입으로서 프로토콜 사용)
3. 컬렉션뷰 아웃렛
 */

class TimelineViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var todayCollectionView: UICollectionView!
    @IBOutlet var bestCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)

        todayCollectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        bestCollectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")

        todayCollectionView.dataSource = self
        bestCollectionView.dataSource = self

        todayCollectionView.delegate = self
        bestCollectionView.delegate = self

        configureCollectionViewLayout()
        configureBestCollectionViewLayout()
    }

    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        todayCollectionView.collectionViewLayout = layout
    }

    func configureBestCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        bestCollectionView.collectionViewLayout = layout
        //deviceWidth 기준으로..
        bestCollectionView.isPagingEnabled = true // 한번에 하나씩? 넘어감
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == todayCollectionView ? 5 : 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell

        if collectionView == todayCollectionView {
            cell.contentLabel.text = "\(indexPath.item)"
            cell.backgroundColor = .yellow
        } else {
            cell.contentLabel.text = "\(indexPath.item)"
            cell.backgroundColor = [.red, .gray, .blue, .green].randomElement()
        }
        return cell
    }

}
