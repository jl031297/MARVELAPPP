//
//  tableViewController.swift
//  MARVELAPP
//
//  Created by jorge lengua on 29/7/22.
//

import Foundation
import UIKit
class tableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    var namesArray: [Character]?

    @IBOutlet weak var backNavigationItem: UINavigationItem!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray?.count ?? 0
    }
    
   
    
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        RestManager.dorestCall("", page: 0, success: { (offices) in
            
            self.namesArray = offices.data?.results
            self.tableView.reloadData()
        })
        
    }
    
    func createNavBar() {
        let buttonBack = UIButton(type: .custom)
        buttonBack.setTitle("S", for: .normal)
        buttonBack.frame = CGRect(x: 0, y: 0, width: 22, height: 20)
        buttonBack.addTarget(self, action: #selector(onBackButton), for: .touchUpInside)
        buttonBack.tintColor = UIColor(named: "333333")
        buttonBack.setTitleColor(UIColor(named: "333333"), for: .normal)
        let itemBack = UIBarButtonItem(customView: buttonBack)
        itemBack.tintColor = UIColor(named: "333333")
        backNavigationItem.leftBarButtonItem = itemBack

        
    }
    
    @objc func onBackButton() {
        dismiss(animated: true, completion: nil)
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int)
        -> CGFloat {
            return 0.1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MVDetailStoryboard", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "MVDetailViewController") as? MVDetailViewController else {             fatalError("Unable to dequeue Name Cell")
 }

        if let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? MVCharacterTableViewCell{

            let characterName   = namesArray?[indexPath.row]
            if let image = characterName?.thumbnail {
                viewController.setImage(image: image)

            }
            viewController.setID(id: characterName?.id ?? 0)
            viewController.hidesBottomBarWhenPushed = true
            self.present(viewController, animated: true, completion: nil)
          
          
          }
      }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? MVCharacterTableViewCell else {
            fatalError("Unable to dequeue Name Cell")
        }
        
        let characterName   = namesArray?[indexPath.row]

        // Sets nameLabel text to characterName in tableViewCell
        
        cell.title.text = characterName?.name
       if let url = characterName?.thumbnail?.url {
            RestManager.loadImage(from: url, success: { (image) in
                cell.characterImageView.image = image

            })
        }
       

        return cell
    }
}
