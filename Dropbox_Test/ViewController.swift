//
//  ViewController.swift
//  Dropbox_Test
//
//  Created by Dragon on 9/1/22.
//

import UIKit
import SwiftyDropbox

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.requestPermission()
    }

    func requestPermission() {
        let scopeRequest = ScopeRequest(scopeType: .user, scopes: ["account_info.read"], includeGrantedScopes: false)
            DropboxClientsManager.authorizeFromControllerV2(
                UIApplication.shared,
                controller: self,
                loadingStatusDelegate: nil,
                openURL: { (url: URL) -> Void in UIApplication.shared.open(url, options: [:], completionHandler: nil) },
                scopeRequest: scopeRequest
            )
    }

    @IBAction func onUpload(_ sender: Any) {
        let client = DropboxClient(accessToken: "sl.BOesjTWTw62U9tIihb3c7SrZAbFbPcX0-13jqvWWwqrIVEvDNM4db1PoxStQyfl8LMJNMPsbd7B_2nveZs2GcI7gxqBMW6PzbYQ_f9635F90LfjupaA0_SjBarJ3WazPUspQE3g")
        client.files.createFolderV2(path: "/test/path/in/Dropbox/account").response { response, error in
            if let response = response {
                print(response)
            } else if let error = error {
                print(error)
            }
        }
        
        let fileData = "testing data example".data(using: String.Encoding.utf8, allowLossyConversion: false)!

        let request = client.files.upload(path: "/test/path/in/Dropbox/account", input: fileData)
            .response { response, error in
                if let response = response {
                    print(response)
                } else if let error = error {
                    print(error)
                }
            }
            .progress { progressData in
                print(progressData)
            }

        // in case you want to cancel the request
//        if someConditionIsSatisfied {
//            request.cancel()
//        }
    }
    
    @IBAction func onDownload(_ sender: Any) {
        let client = DropboxClient(accessToken: "sl.BOesjTWTw62U9tIihb3c7SrZAbFbPcX0-13jqvWWwqrIVEvDNM4db1PoxStQyfl8LMJNMPsbd7B_2nveZs2GcI7gxqBMW6PzbYQ_f9635F90LfjupaA0_SjBarJ3WazPUspQE3g")
        
        // Download to URL
        let fileManager = FileManager.default
        let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destURL = directoryURL.appendingPathComponent("myTestFile")
        let destination: (URL, HTTPURLResponse) -> URL = { temporaryURL, response in
            return destURL
        }
        print (destination)
        client.files.download(path: "/test/path/in/Dropbox/account", overwrite: true, destination: destination)
            .response { response, error in
                if let response = response {
                    print(response)
                } else if let error = error {
                    print(error)
                }
            }
            .progress { progressData in
                print(progressData)
            }
        
        
        // Download to Data
//        client.files.download(path: "/test/path/in/Dropbox/account")
//            .response { response, error in
//                if let response = response {
//                    let responseMetadata = response.0
//                    print(responseMetadata)
//                    let fileContents = response.1
//                    print(fileContents)
//                } else if let error = error {
//                    print(error)
//                }
//            }
//            .progress { progressData in
//                print(progressData)
//            }
    }
}

