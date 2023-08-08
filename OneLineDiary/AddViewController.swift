//
//  ViewController.swift
//  OneLineDiary
//
//  Created by 박다혜 on 2023/07/31.
//

import UIKit

enum TransitionType: String {
    case add = "추가 화면"
    case edit = "수정 화면"
}

//1. UITextViewDelegate
//2. ~.delegate = self
//3. 필요한 메서드 호출해서 구현


class AddViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var detailTextView: UITextView!

    var type: TransitionType = .add
    var detail: String = ""

    //placeholder
    let placeholderText = "내용을 입력해주세요"

    override func viewDidLoad() {
        super.viewDidLoad()

        detailTextView.delegate = self

        setBackgroundColor()

        detailTextView.text = detail
        title = type.rawValue

        switch type {
        case .add:
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
            navigationItem.leftBarButtonItem?.tintColor = .systemPink
            detailTextView.text = placeholderText
            detailTextView.textColor = .lightGray
        case .edit:
            print("")
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
        title = "\(textView.text.count)"
    }

    // 편집이 시작될 때 (커서가 시작될 때)
    //플레이스 홀더와 텍스트뷰 글자가 같다면
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }

    // 편집이 끝날 때 (커서가 없어지는 순간)
    //사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자 보이게 설정
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }

    @objc
    func closeButtonClicked() {
        //present-dismiss
        dismiss(animated: true)
    }

}

