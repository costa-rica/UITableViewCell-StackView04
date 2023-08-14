//
//  Utilities.swift
//  UITableViewCell-StackView04
//
//  Created by Nick Rodriguez on 13/08/2023.
//

import UIKit

func environmentColor(urlStore:URLStore) -> UIColor{
    if urlStore.apiBase == .prod{
        return UIColor(named: "orangePrimary") ?? UIColor.cyan
    } else if urlStore.apiBase == .dev{
        return UIColor(named: "orangePrimaryDev") ?? UIColor.cyan
    } else if urlStore.apiBase == .local{
        return UIColor(hex: "#8ea202")
    }
    return UIColor.cyan
}

extension UIImage {
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        var newImage: UIImage?
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            context.draw(cgImage, in: newRect)
            if let img = context.makeImage() {
                newImage = UIImage(cgImage: img)
            }
            UIGraphicsEndImageContext()
        }
        return newImage
    }
}

func widthFromPct(percent:Float) -> CGFloat {
    let screenWidth = UIScreen.main.bounds.width
    let width = screenWidth * CGFloat(percent/100)
    return width
}

func heightFromPct(percent:Float) -> CGFloat {
    let screenHeight = UIScreen.main.bounds.height
    let height = screenHeight * CGFloat(percent/100)
    return height
}


extension UIColor {
    
    /// Initialize UIColor from hex string
    ///
    /// - Parameters:
    ///   - hex: hex string, e.g. "8ea202"
    ///   - alpha: alpha value (optional, default is 1.0)
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }
        
        var rgb: UInt64 = 0
        
        Scanner(string: hex).scanHexInt64(&rgb)
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

func rinconImageFolderName(rincon:Rincon)->String{
    "\(rincon.id)_\(rincon.name_no_spaces)"
}


func imageFileNameParser(_ input: String) -> [String] {
    let components = input.components(separatedBy: ",")
    if components.count > 1 {
        return components
    } else {
        return [input]
    }
}




