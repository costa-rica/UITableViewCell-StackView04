//
//  PostCell.swift
//  UITableViewCell-StackView04
//
//  Created by Nick Rodriguez on 13/08/2023.
//

import UIKit

class PostCell: UITableViewCell{
    var requestStore:RequestStore!
    var imageStore:ImageStore!
    var post:Post!
    var rincon:Rincon!
    let screenWidth = UIScreen.main.bounds.width
    var indexPath:IndexPath!
    var stckVwPost=UIStackView()
    var lblUsername=UILabel()
    typealias dictImgValue = (image:UIImage, downloaded:Bool)
    var dictImg: [String:dictImgValue]?
    
    var dictImgVw:[String:UIImageView]?
    
    var imageViewHeightConstraint: NSLayoutConstraint?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with post:Post){
        self.post = post
        stckVwPost.translatesAutoresizingMaskIntoConstraints=false
        contentView.addSubview(stckVwPost)
        stckVwPost.topAnchor.constraint(equalTo: contentView.topAnchor).isActive=true
        stckVwPost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive=true
        stckVwPost.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive=true
        stckVwPost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive=true
//        stckVwPost.contentMode = .scaleAspectFit
//        stckVwPost.distribution = .fillProportionally
        stckVwPost.axis = .vertical
        stckVwPost.spacing = 10
        stckVwPost.backgroundColor = .brown
        stckVwPost.accessibilityIdentifier = "stckVwPost"
        
        lblUsername.text = post.username
//        lblUsername.translatesAutoresizingMaskIntoConstraints=false
        lblUsername.backgroundColor = .cyan
        lblUsername.accessibilityIdentifier = "lblUsername"
        stckVwPost.addArrangedSubview(lblUsername)
        
        if post.image_files_array != nil{
            addImages()
        }
    }
    
    
    func creatSpinner(image_name:String)->UIImageView{
        let spinnerImgVw = UIImageView(image:UIImage(named: "blackScreen")!)
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinnerImgVw.accessibilityIdentifier = "spinnerImgVw-\(image_name)"
        spinner.color = UIColor.white.withAlphaComponent(1.0) // Make spinner brighter
        spinner.transform = CGAffineTransform(scaleX: 2, y: 2)
        spinner.startAnimating()
        
        spinnerImgVw.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: spinnerImgVw.centerXAnchor).isActive=true
        spinner.centerYAnchor.constraint(equalTo: spinnerImgVw.centerYAnchor).isActive=true
        
        print("spinnerImgVw size: \(spinnerImgVw.image!.size)")
        
        return spinnerImgVw
    }

//    func createDownloadingIndicatorView(accessId: String) -> UIImageView {
//        let screenWidth = UIScreen.main.bounds.width
//
//        // Create UIImageView with specified frame
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 250))
////        let imageView = UIImageView(image:UIImage(named: "blackScreen")!)
//        imageView.backgroundColor = .black
//        imageView.accessibilityIdentifier = accessId
//
//
//        // Create UIActivityIndicatorView
//        let activityIndicator = UIActivityIndicatorView(style: .large)
//        activityIndicator.startAnimating()
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//
//        // Add UIActivityIndicatorView to UIImageView
//        imageView.addSubview(activityIndicator)
//
//        // Center UIActivityIndicatorView in UIImageView
//        NSLayoutConstraint.activate([
//            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
//            imageView.heightAnchor.constraint(equalToConstant: 250)
//        ])
//
//        return imageView
//    }

    

    
    func addImages(){
        
        print("Post has images")
//        dictImg = [String:dictImgValue]()
        dictImgVw = [String:UIImageView]()
        for image_name in post.image_files_array!{
                
                self.dictImgVw![image_name] = self.createImgVwSpinner(imageAccessId: image_name)
                self.addImgVwToStckVwPost(imageAccessId: image_name, imgVw: self.dictImgVw![image_name]!)

                print("added spinner")
                /* Get image from ApI*/
                requestStore.getImages(rincon: rincon, imageFilename: image_name) { resultResponse in
                    switch resultResponse{
                    case let .success(uiimage):
                        OperationQueue.main.addOperation {
                            self.dictImgVw![image_name]!.removeFromSuperview()
                            let newImage = self.resizeImageToFitScreenWidth(uiimage)
                            self.dictImgVw![image_name]! = UIImageView(image: newImage)
                            self.addImgVwToStckVwPost(imageAccessId: image_name, imgVw: self.dictImgVw![image_name]!)
                            guard let tblVwRinconVC = self.superview as? UITableView else { return }
                            tblVwRinconVC.beginUpdates()
                            tblVwRinconVC.endUpdates()
                        }
                    case let .failure(error):
                        print("Failed to get image from API: \(error)")
                    }// switch resultResponse
                }// requestStore.getImages
                
                
//            } // else
        } // for image_name in post.image_files_array!{
    }// func addImages()
    
    func addImgVwToStckVwPost(imageAccessId:String, imgVw:UIImageView){
        imgVw.accessibilityIdentifier=imageAccessId
        stckVwPost.addArrangedSubview(imgVw)
    }
//    func addImage(imageAccessId:String,imgVw:UIImageView?, tempImage:Bool?){
//        if let unwp_imgVw = imgVw{
//            unwp_imgVw.accessibilityIdentifier=imageAccessId
//            stckVwPost.addArrangedSubview(unwp_imgVw)
//        } else {
//            let tempImage = createImgVwSpinner()
//            tempImage.accessibilityIdentifier="spinner"+imageAccessId
//            stckVwPost.addArrangedSubview(tempImage)
//        }
//    }
    
    func createImgVwSpinner(imageAccessId:String) -> UIImageView {
        
        // Create UIImageView with specified frame
        let imgVwSpinner = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 250))
        imgVwSpinner.backgroundColor = .black
        imgVwSpinner.accessibilityIdentifier = "imgVwSpinner"+imageAccessId

        // Create UIActivityIndicatorView
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.accessibilityIdentifier="spinner"+imageAccessId
        
        // Add UIActivityIndicatorView to UIImageView
        imgVwSpinner.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: imgVwSpinner.centerXAnchor).isActive=true
        spinner.centerYAnchor.constraint(equalTo: imgVwSpinner.centerYAnchor).isActive=true
        imgVwSpinner.heightAnchor.constraint(equalToConstant: 250).isActive=true
        
        return imgVwSpinner
    }
    
//    func removeSubview(with identifier: String, from view: UIView) {
//        for subview in view.subviews {
//            if subview.accessibilityIdentifier == identifier {
//                subview.removeFromSuperview()
//                return
//            }
//            removeSubview(with: identifier, from: subview)
//        }
//    }
//
//    func removeSubComponentes(view:UIImageView){
//        for sub_view in view.subviews{
//            sub_view.removeFromSuperview()
//        }
//    }
//
    
}


extension PostCell {
    

    func adjustImageViewHeight(for image: UIImage, image_name:String) {
        // If the constraint hasn't been initialized, find it
        if imageViewHeightConstraint == nil {
//            imageViewHeightConstraint = imageView.constraints.first(where: { $0.firstAttribute == .height })
            imageViewHeightConstraint = dictImgVw![image_name]!.constraints.first(where: { $0.firstAttribute == .height })
        }
        
        let aspectRatio = image.size.width / image.size.height
        let newHeight = UIScreen.main.bounds.width / aspectRatio
        
        print("post:\(post.post_id!) newHeight: \(newHeight)")
        dictImgVw![image_name]!.accessibilityIdentifier = "resizedImageView"
        dictImgVw![image_name]!.backgroundColor = .blue
        
        imageViewHeightConstraint?.constant = newHeight
        
    }

    
    func resizeImageToFitScreenWidth(_ image: UIImage) -> UIImage? {
        // Get screen width
        let screenWidth = UIScreen.main.bounds.width
        
        // Determine the aspect ratio of the image
        let aspectRatio = image.size.width / image.size.height
        
        // Calculate new height using the aspect ratio
        let newHeight = screenWidth / aspectRatio
        
        // Resize the image based on new dimensions
        let newSize = CGSize(width: screenWidth, height: newHeight)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}


