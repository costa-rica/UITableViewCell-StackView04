//
//  RinconVC.swift
//  UITableViewCell-StackView04
//
//  Created by Nick Rodriguez on 13/08/2023.
//

import UIKit

class RinconVC: UIViewController {
    
    var requestStore: RequestStore!
    var urlStore:URLStore!
    var imageStore:ImageStore!
    var rincon:Rincon!
    
    let vwVCHeaderOrange = UIView()
    let vwVCHeaderOrangeTitle = UIView()
    let imgVwIconNoName = UIImageView()
    let lblHeaderTitle = UILabel()
    let btnToTable = UIButton()
    
    var stckVwRincon=UIStackView()
    var tblRincon = UITableView()
    
    var arryPosts:[Post]!
    
//    var stckVwAuxilary = UIStackView()
//    var btnAuxilary = UIButton()
    // New properties
    let stckVwAuxilary = UIStackView()
    let btnAuxilary = UIButton()
    let whlAuxilary = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        urlStore = URLStore()
        imageStore = ImageStore()
        
        if !imageStore.rinconPhotosFolderExists(rincon: rincon){
            imageStore.createRinconPhotosFolder(rincon: rincon)
        }
        
        tblRincon.delegate = self
        tblRincon.dataSource = self
        // Register a UITableViewCell
        tblRincon.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tblRincon.rowHeight = UITableView.automaticDimension
        tblRincon.estimatedRowHeight = 100
        
        setup_vwVCHeaderOrange()
        setup_vwVCHeaderOrangeTitle()
        setup_stckVw()
//        setup_btnAuxilary()
        setupAuxilaryViews()
        
        stckVwRincon.addArrangedSubview(tblRincon)

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
        
        lblHeaderTitle.text = "RinconVC"
        lblHeaderTitle.font = UIFont(name: "Rockwell", size: 35)
        vwVCHeaderOrangeTitle.addSubview(lblHeaderTitle)
        lblHeaderTitle.translatesAutoresizingMaskIntoConstraints=false
        lblHeaderTitle.accessibilityIdentifier = "lblHeaderTitle"
        lblHeaderTitle.leadingAnchor.constraint(equalTo: imgVwIconNoName.trailingAnchor, constant: widthFromPct(percent: 2.5)).isActive=true
        lblHeaderTitle.centerYAnchor.constraint(equalTo: vwVCHeaderOrangeTitle.centerYAnchor).isActive=true
    }
    
    func setup_stckVw(){
        stckVwRincon.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(stckVwRincon)
        stckVwRincon.topAnchor.constraint(equalTo: vwVCHeaderOrangeTitle.bottomAnchor).isActive=true
        stckVwRincon.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
        stckVwRincon.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true
        stckVwRincon.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        stckVwRincon.axis = .vertical
        
    }
    
    func setupAuxilaryViews() {
        // Configure UIButton
        btnAuxilary.setTitle("Auxilary Row", for: .normal)
        btnAuxilary.addTarget(self, action: #selector(btnAuxilaryTapped), for: .touchUpInside)
        btnAuxilary.layer.borderWidth = 2
        btnAuxilary.layer.borderColor = UIColor.blue.cgColor
        btnAuxilary.layer.cornerRadius = 5
        
        // Configure UIPickerView
        whlAuxilary.delegate = self
        whlAuxilary.dataSource = self
        whlAuxilary.heightAnchor.constraint(equalToConstant: 50).isActive=true
        
        // Add views to stckVwAuxilary
//        stckVwAuxilary.axis = .vertical
        stckVwAuxilary.addArrangedSubview(btnAuxilary)
        stckVwAuxilary.addArrangedSubview(whlAuxilary)
        stckVwAuxilary.distribution = .fillEqually
        

        
        // Add stckVwAuxilary to top of stckVwRincon
        stckVwRincon.insertArrangedSubview(stckVwAuxilary, at: 0)
    }

    
    
//    @objc func touchDownBtnAuxilary(_ sender: UIButton) {
//        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseOut], animations: {
//            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
//        }, completion: nil)
//    }
//
//    @objc func touchUpInsideBtnAuxilary(_ sender: UIButton) {
//        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
//            sender.transform = .identity
//        }, completion: nil)
//        print("-touched button Auxliliary")
//        tblRincon.reloadRows(at: <#T##[IndexPath]#>, with: <#T##UITableView.RowAnimation#>)
//    }
    @objc func btnAuxilaryTapped() {
        let selectedRowIndex = whlAuxilary.selectedRow(inComponent: 0)
        
        // Ensure the selected index is within the valid range
        if selectedRowIndex < arryPosts.count {
            let postToReload = arryPosts[selectedRowIndex]
            
            // Assuming you have a method or way to get IndexPath from post_id
            if let indexPath = getIndexPathForPostID(postToReload.post_id) {
//                tblRincon.reloadRows(at: [indexPath], with: .automatic)
                let current_post_cell = tblRincon.cellForRow(at: indexPath) as! PostCell
                print("current_post_cell_stckVwPost.height: \(current_post_cell.stckVwPost.frame.size)")
                print(current_post_cell.stckVwPost.arrangedSubviews)
                
//                print("current_post_cell.frame.size: \(current_post_cell.frame.size)")
//
//                print("---- ChatG's reqeustd diagnostics --")
//                print("stckVwPost.spacing: \(current_post_cell.stckVwPost.spacing)")
//                print("stckVwPost.distribution: \(current_post_cell.stckVwPost.distribution)")
//
//                print("lblUsername.isHidden: \(current_post_cell.lblUsername.isHidden)")
//                print("lblUsername.alpha: \(current_post_cell.lblUsername.alpha)")
//                print("lblUsername.frame: \(current_post_cell.lblUsername.frame)")
//                print("lblUsername.bounds: \(current_post_cell.lblUsername.bounds)")
                print("------------")
                
                listSubviews(of: current_post_cell.contentView)
                print("------------")

                
            }
            
        }
    }

    // Sample method to get IndexPath from post_id
    func getIndexPathForPostID(_ postID: String) -> IndexPath? {
        if let index = arryPosts.firstIndex(where: { $0.post_id == postID }) {
            return IndexPath(row: index, section: 0)
        }
        return nil
    }
    
    func listSubviews(of view: UIView, indent: Int = 0) {
        let indentation = String(repeating: " ", count: indent)
        
        if let identifier = view.accessibilityIdentifier {
            print("\(indentation)\(view) - \(identifier)")
        } else {
            print("\(indentation)\(view)")
        }
        
        for subview in view.subviews {
            listSubviews(of: subview, indent: indent + 2)
        }
    }


}

extension RinconVC: UITableViewDelegate{
    
}

extension RinconVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arryPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for:indexPath) as! PostCell
        
        let current_post = arryPosts[indexPath.row]
        cell.imageStore = imageStore
        cell.requestStore = requestStore
        cell.rincon = rincon
        cell.indexPath = indexPath
        cell.configure(with: current_post)
        
        return cell
    }
    
    
}



extension RinconVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arryPosts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arryPosts[row].post_id
    }
}

