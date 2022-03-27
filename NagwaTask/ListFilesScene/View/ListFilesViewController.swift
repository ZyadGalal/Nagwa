//
//  ListFilesViewController.swift
//  NagwaTask
//
//  Created by Zyad Galal on 27/03/2022.
//

import UIKit

class ListFilesViewController: UIViewController {

    @IBOutlet weak var filesTableView: UITableView!
    var presenter: ListFilesPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

}

extension ListFilesViewController: ListFilesView {
    
}
