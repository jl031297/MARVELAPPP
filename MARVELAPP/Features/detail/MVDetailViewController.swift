//
//  MVDetailViewController.swift
//  MARVELAPP
//
//  Created by jorge lengua on 29/7/22.
//

import Foundation
import UIKit

class MVDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var seriesButton: UIButton!
    @IBOutlet weak var eventsButton: UIButton!
    @IBOutlet weak var storiesButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    public var urlBase: String? = ""
    @IBOutlet weak var comicsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
    }
    
    public func setData(data: Character){
        
        
    }
    public func setImage(image: Image){
        if let url = image.url {
             RestManager.loadImage(from: url, success: { (image) in
                 self.imageView.image = image

             })
         }
    }
    public func setID(id: Int){
        RestManager.getCharacterData(id, success: { (result) in
            let character = result.data?.results?.first as? Character
            self.titleLabel?.text = character?.name
            self.descriptionTextLabel?.text = character?.description

            self.reloadInputViews()

        })
    }
    func configureUI() {
        seriesButton.titleLabel?.text  = "Series"
        eventsButton.titleLabel?.text = "events"
        storiesButton.titleLabel?.text = "stories"
        comicsButton.titleLabel?.text = "comics"

    }
    @IBAction func storiesClicked(_ sender: Any) {
        
        
    }
    @IBAction func eventsClicked(_ sender: Any) {
    }
    
    @IBAction func comicsClicked(_ sender: Any) {
    }
    
    @IBAction func seriesClicked(_ sender: Any) {
    }
}
