//
//  DetailViewController.swift
//  PRapp
//
//  Created by Mcrew Tech on 28/07/2021.
//

import UIKit
import RxSwift
import RxCocoa
class DetailViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameLabel.text = name
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
