//
//  General.swift
//  Labany
//
//  Created by Eman Gaber on 7/4/21.
//

import Foundation
import UIKit
import AVKit
import AVFoundation
import LSDialogViewController
class General: NSObject {


    var cartID = -1
    var tabBar:TabBarVC?
    
       static let sharedInstance = General()
       private override init()
       {
           super.init()
           
       }
    
 class func CurrentDeviceLanguage() -> String {
    
    let returnL : String = NSLocale.preferredLanguages[0]
    print (returnL)
    
    if returnL.range(of:"en") != nil {
        return "en"
    }else
        if returnL.range(of:"ar") != nil {
            return "ar"
        }else
            if returnL.range(of:"fr") != nil {
                return "fr"
            }else
                { // if returnL.range(of:"tu") != nil
                    return "tu"
    }
    
    }
    
    
    class func CheckNull(_ string: Any?) -> String? {
        if !(string == nil)  {
            if let string = string {
                return "\(string)"
            }
            return nil

        } else {
            return ""
        }

    }
    
    
    
   class func encodeVideo(at videoURL: URL, completionHandler: ((URL?, Error?) -> Void)?)  {
        let avAsset = AVURLAsset(url: videoURL, options: nil)
        
        let startDate = Date()
        
        //Create Export session
        guard let exportSession = AVAssetExportSession(asset: avAsset, presetName: AVAssetExportPresetPassthrough) else {
            completionHandler?(nil, nil)
            return
        }
        
        //Creating temp path to save the converted video
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        let filePath = documentsDirectory.appendingPathComponent("rendered-Video.mp4")
        
        //Check if the file already exists then remove the previous file
        if FileManager.default.fileExists(atPath: filePath.path) {
            do {
                try FileManager.default.removeItem(at: filePath)
            } catch {
                completionHandler?(nil, error)
            }
        }
        
        exportSession.outputURL = filePath
        exportSession.outputFileType = AVFileType.mp4
        exportSession.shouldOptimizeForNetworkUse = true
        let start = CMTimeMakeWithSeconds(0.0, preferredTimescale: 0)
        let range = CMTimeRangeMake(start: start, duration: avAsset.duration)
        exportSession.timeRange = range
        
        exportSession.exportAsynchronously(completionHandler: {() -> Void in
            switch exportSession.status {
            case .failed:
                print(exportSession.error ?? "NO ERROR")
                completionHandler?(nil, exportSession.error)
            case .cancelled:
                print("Export canceled")
                completionHandler?(nil, nil)
            case .completed:
                //Video conversion finished
                let endDate = Date()
                
                let time = endDate.timeIntervalSince(startDate)
                print(time)
                print("Successful!")
                print(exportSession.outputURL ?? "NO OUTPUT URL")
                completionHandler?(exportSession.outputURL, nil)
                
            default: break
            }
            
        })
    }
    
    
    
    
 
    
    
    class func compressImage(image:UIImage) -> Data {
        // Reducing file size to a 10th
        
        var actualHeight : CGFloat = image.size.height
        var actualWidth : CGFloat = image.size.width
        let maxHeight : CGFloat = 1136.0
        let maxWidth : CGFloat = 640.0
        var imgRatio : CGFloat = actualWidth/actualHeight
        let maxRatio : CGFloat = maxWidth/maxHeight
        var compressionQuality : CGFloat = 0.5
        
        if (actualHeight > maxHeight || actualWidth > maxWidth){
            if(imgRatio < maxRatio){
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight;
                actualWidth = imgRatio * actualWidth;
                actualHeight = maxHeight;
            }
            else if(imgRatio > maxRatio){
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth;
                actualHeight = imgRatio * actualHeight;
                actualWidth = maxWidth;
            }
            else{
                actualHeight = maxHeight;
                actualWidth = maxWidth;
                compressionQuality = 1;
            }
        }
        
        let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
        
        UIGraphicsBeginImageContext(rect.size);
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext();
        let imageData = img!.jpegData(compressionQuality: compressionQuality)
        UIGraphicsEndImageContext();
        
        return imageData!
    }
    class func ChangeArabicNumbersToEnglish( arabicNumber: String) -> String {
        var newPass = arabicNumber
        newPass = newPass.replacingOccurrences(of: "٠", with: "0")
        newPass = newPass.replacingOccurrences(of: "١", with: "1")
        newPass = newPass.replacingOccurrences(of: "٢", with: "2")
        newPass = newPass.replacingOccurrences(of: "٣", with: "3")
        newPass = newPass.replacingOccurrences(of: "٤", with: "4")
        newPass = newPass.replacingOccurrences(of: "٥", with: "5")
        newPass = newPass.replacingOccurrences(of: "٦", with: "6")
        newPass = newPass.replacingOccurrences(of: "٧", with: "7")
        newPass = newPass.replacingOccurrences(of: "٨", with: "8")
        newPass = newPass.replacingOccurrences(of: "٩", with: "9")
        return newPass
    }
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
   
    class func OpenUrl(scheme: String) {
      if let url = URL(string: scheme) {
         if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:],
              completionHandler: {
                  (success) in
                     print("Open \(scheme): \(success)")
              })
        } else {
            let success = UIApplication.shared.openURL(url)
            print("Open \(scheme): \(success)")
        }
      }
    }
    
    class func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
    }
    
    
    
    
    class func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
             
              let label = UILabel(frame: CGRect(x: 0, y: 0, width:width, height:CGFloat.greatestFiniteMagnitude))
                  
              label.numberOfLines = 0
              label.lineBreakMode = NSLineBreakMode.byWordWrapping
              label.font = font
              label.text = text

              label.sizeToFit()
              return label.frame.height
          }
       
      class func WidthForView(text:String, font:UIFont, height:CGFloat) -> CGFloat{
             
              let label = UILabel(frame: CGRect(x: 0, y: 0, width:CGFloat.greatestFiniteMagnitude, height:height))
                  
              label.numberOfLines = 0
              label.lineBreakMode = NSLineBreakMode.byWordWrapping
              label.font = font
              label.text = text

              label.sizeToFit()
              return label.frame.width
          }
    
    
}
