//
//  NotificationService.swift
//  ImageNotification
//
//  Created by Buson on 18/11/2023.
//

import UIKit
import UserNotifications
import FirebaseMessaging

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        guard let bestAttemptContent = bestAttemptContent else { return }
        // Modify the notification content here as you wish
        let data = bestAttemptContent.userInfo as NSDictionary
        let pref = UserDefaults.init(suiteName: "group.id.gits.notifserviceextension")
        pref?.set(data, forKey: "NOTIF_DATA")
        pref?.synchronize()
        NSLog("notificationserviceExtension")
        guard let attachmentURL = data["image"] as? String else {
                    contentHandler(bestAttemptContent)
                    return
                }
        do {
             print("unNotification sucesss01---\(attachmentURL)")
            let imageData = try Data(contentsOf: URL(string: attachmentURL)!)
            guard let attachment = UNNotificationAttachment.create(imageFileIdentifier: "image.jpg", data: imageData, options: nil) else {
                contentHandler(bestAttemptContent)
                return
            }
            bestAttemptContent.attachments = [attachment]
            contentHandler(bestAttemptContent.copy() as! UNNotificationContent)
            
        } catch {
            self.bestAttemptContent?.title = "\(self.bestAttemptContent?.title ?? "")."
            self.bestAttemptContent?.body = "\(self.bestAttemptContent?.body ?? "")"
            contentHandler(bestAttemptContent)
            print("Unable to load data: \(error)")

        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
extension UNNotificationAttachment {
    /// Save the image to disk
    static func create(imageFileIdentifier: String, data: Data, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
        let fileManager = FileManager.default
        let tmpSubFolderName = ProcessInfo.processInfo.globallyUniqueString
        let tmpSubFolderURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(tmpSubFolderName, isDirectory: true)

        do {
            try fileManager.createDirectory(at: tmpSubFolderURL!, withIntermediateDirectories: true, attributes: nil)
            let fileURL = tmpSubFolderURL?.appendingPathComponent(imageFileIdentifier)
            try data.write(to: fileURL!, options: [])
            let imageAttachment = try UNNotificationAttachment.init(identifier: imageFileIdentifier, url: fileURL!, options: options)
            return imageAttachment
        } catch let error {
            print("error \(error)")
        }
        return nil
    }
}
// extension UNNotificationAttachment {
//     static func create(imageFileIdentifier: String, data: Data, options: [NSObject: AnyObject]?) -> UNNotificationAttachment? {
//         let fileManager = FileManager.default
//         let tmpSubFolderName = ProcessInfo.processInfo.globallyUniqueString
//         let tmpSubFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(tmpSubFolderName, isDirectory: true)

//         do {
//             try fileManager.createDirectory(at: tmpSubFolderURL, withIntermediateDirectories: true, attributes: nil)
//             let fileURL = tmpSubFolderURL.appendingPathComponent(imageFileIdentifier)
//             try data.write(to: fileURL)
//             let attachment = try UNNotificationAttachment(identifier: imageFileIdentifier, url: fileURL, options: options)
//             return attachment
//         } catch {
//             print("Error creating attachment: \(error)")
//         }
//         return nil
//     }
// }
