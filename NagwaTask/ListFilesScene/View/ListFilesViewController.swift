//
//  ListFilesViewController.swift
//  NagwaTask
//
//  Created by Zyad Galal on 27/03/2022.
//

import UIKit

class ListFilesViewController: UIViewController {

    var presenter: ListFilesPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}

extension ListFilesViewController: ListFilesView {
    
}
