//
//  ViewController.swift
//  MARVELAPP
//
//  Created by jorge lengua on 27/7/22.
//

import UIKit
import Foundation
class ViewController: UIViewController {
    private var rootView: UINavigationController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func mainButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "tablesegue", sender: self)

    }
    
    private func configureView() {
        self.view.backgroundColor = .white
    }


}

