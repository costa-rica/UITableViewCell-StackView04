//
//  ViewController.swift
//  UITableViewCell-StackView04
//
//  Created by Nick Rodriguez on 13/08/2023.
//

import UIKit

class LoginVC: UIViewController {

    var requestStore: RequestStore!
    var urlStore:URLStore!
    
    let vwVCHeaderOrange = UIView()
    let vwVCHeaderOrangeTitle = UIView()
    let imgVwIconNoName = UIImageView()
    let lblHeaderTitle = UILabel()
    let btnToTable = UIButton()
    
    var stckVwLogin = UIStackView()
    
    let btnGetPost = UIButton()
    var arryPosts:[Post]?
//    let btnGetImages
    
    // test rincon
    let rinconStackView04 = Rincon(id: "13", name: "StackView04", name_no_spaces: "StackView04")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        urlStore = URLStore()
        urlStore.apiBase = .local
        requestStore = RequestStore()
        print("urlStore is set")
        print(urlStore.apiBase.rawValue)
        setup_vwVCHeaderOrange()
        setup_vwVCHeaderOrangeTitle()
        setup_moreButtons()
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
    }

    func setup_vwVCHeaderOrange(){
        view.addSubview(vwVCHeaderOrange)
        vwVCHeaderOrange.backgroundColor = environmentColor(urlStore: urlStore)
        vwVCHeaderOrange.translatesAutoresizingMaskIntoConstraints = false
        vwVCHeaderOrange.accessibilityIdentifier = "vwVCHeaderOrange"
        vwVCHeaderOrange.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        vwVCHeaderOrange.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        vwVCHeaderOrange.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        vwVCHeaderOrange.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
    }
    func setup_vwVCHeaderOrangeTitle(){
        view.addSubview(vwVCHeaderOrangeTitle)
        vwVCHeaderOrangeTitle.backgroundColor = UIColor.brown
        vwVCHeaderOrangeTitle.translatesAutoresizingMaskIntoConstraints = false
        vwVCHeaderOrangeTitle.accessibilityIdentifier = "vwVCHeaderOrangeTitle"
        vwVCHeaderOrangeTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        vwVCHeaderOrangeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        vwVCHeaderOrangeTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
        
        if let unwrapped_image = UIImage(named: "android-chrome-192x192") {
            imgVwIconNoName.image = unwrapped_image.scaleImage(toSize: CGSize(width: 20, height: 20))
            vwVCHeaderOrangeTitle.heightAnchor.constraint(equalToConstant: imgVwIconNoName.image!.size.height + 10).isActive=true
        }
        imgVwIconNoName.translatesAutoresizingMaskIntoConstraints = false
        imgVwIconNoName.accessibilityIdentifier = "imgVwIconNoName"
        vwVCHeaderOrangeTitle.addSubview(imgVwIconNoName)
        imgVwIconNoName.topAnchor.constraint(equalTo: vwVCHeaderOrangeTitle.topAnchor).isActive=true
        imgVwIconNoName.leadingAnchor.constraint(equalTo: vwVCHeaderOrangeTitle.centerXAnchor, constant: widthFromPct(percent: -35) ).isActive = true
        
        lblHeaderTitle.text = "LoginVC"
        lblHeaderTitle.font = UIFont(name: "Rockwell", size: 35)
        vwVCHeaderOrangeTitle.addSubview(lblHeaderTitle)
        lblHeaderTitle.translatesAutoresizingMaskIntoConstraints=false
        lblHeaderTitle.accessibilityIdentifier = "lblHeaderTitle"
        lblHeaderTitle.leadingAnchor.constraint(equalTo: imgVwIconNoName.trailingAnchor, constant: widthFromPct(percent: 2.5)).isActive=true
        lblHeaderTitle.centerYAnchor.constraint(equalTo: vwVCHeaderOrangeTitle.centerYAnchor).isActive=true
    }
    
    func setup_moreButtons(){
        stckVwLogin.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(stckVwLogin)
        stckVwLogin.topAnchor.constraint(equalTo: vwVCHeaderOrangeTitle.bottomAnchor, constant: 100).isActive=true
        stckVwLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        stckVwLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
        stckVwLogin.axis = .vertical
        
        btnToTable.setTitle("Go To Table", for: .normal)
        btnToTable.translatesAutoresizingMaskIntoConstraints=false
        stckVwLogin.addArrangedSubview(btnToTable)
        btnToTable.addTarget(self, action: #selector(touchDownBtnToTable), for: .touchDown)
        btnToTable.addTarget(self, action: #selector(touchUpInsideBtnToTable), for: .touchUpInside)
        
        btnGetPost.setTitle("Get Posts", for: .normal)
        btnGetPost.translatesAutoresizingMaskIntoConstraints=false
        stckVwLogin.addArrangedSubview(btnGetPost)
        btnGetPost.addTarget(self, action: #selector(touchDownBtnGetPost), for: .touchDown)
        btnGetPost.addTarget(self, action: #selector(touchUpInsideBtnGetPost), for: .touchUpInside)
        
    }
    
    @objc func touchDownBtnToTable(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseOut], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: nil)
    }

    @objc func touchUpInsideBtnToTable(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        if sender === btnToTable {
            print("btnToTable")
            performSegue(withIdentifier: "goToRinconVC", sender: self)
        }
    }
    
    @objc func touchDownBtnGetPost(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseOut], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: nil)

    }

    @objc func touchUpInsideBtnGetPost(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        print("preseed get post")
        requestStore.getPosts(rincon: rinconStackView04) { resultResponse in
            switch resultResponse{
            case let .success(jsonDictPost):
                self.arryPosts=jsonDictPost
                for post in self.arryPosts! {
                    if post.image_filenames_ios != nil{
                        post.image_files_array = imageFileNameParser(post.image_filenames_ios!)
                    }
                }
                print("posts success")
                print(self.arryPosts ?? "no posts received")
            case let .failure(error):
                print("Failed to write to arryPosts, error: \(error.localizedDescription)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRinconVC" {
            let rinconVC = segue.destination as! RinconVC
            
            
            
            rinconVC.arryPosts = self.arryPosts
            rinconVC.requestStore = requestStore
            rinconVC.rincon = rinconStackView04
        }
    }
    
}

