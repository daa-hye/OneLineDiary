//
//  DetailViewController.swift
//  OneLineDiary
//
//  Created by 박다혜 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet var contentsLabel: UILabel!

    //Pass Data 1. 데이터를 받을 공간(프로퍼티) 생성
    var contents: String = "빈공간"

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        //3. 전달받은 값을 뷰에 표현
        print(contents)
        contentsLabel.text = contents
    }
    @IBAction func deleteButtonDidTap(_ sender: UIBarButtonItem) {
        // push - pop
        navigationController?.popViewController(animated: true)
    }
}
