//
//  ViewController.swift
//  NetworkCore
//
//  Created by Top on 2021/2/4.
//

import UIKit

class ViewController: UIViewController {

    let provider = TestService.provider()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        _ = provider.rx.request(.test111).mapEmptyDataModel().subscribe { (_) in

        } onError: { (error) in
            print("错误信息", error.networkError.localizedDescription)
        }
    }
}

