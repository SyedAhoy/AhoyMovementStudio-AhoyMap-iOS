//
//  ViewController.swift
//  AhoyMap-Example
//
//  Created by Syed Ismail Ahamed on 14/05/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showMapTapped(_ sender: Any) {
        if let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsVC") as? DetailsViewController {
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
}

