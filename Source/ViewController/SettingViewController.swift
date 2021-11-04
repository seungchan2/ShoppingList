//
//  SettingViewController.swift
//  ShoppingList
//
//  Created by 김승찬 on 2021/11/04.
//

import UIKit
import Zip
import MobileCoreServices

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    // 1. 백업할 도큐먼트 폴더 위치
    
    func documentDirectoryPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let directoryPath = path.first {
            return directoryPath
        } else {
            return nil
        }
    }
    
    func presentActivityViewController() {
        //압축 파일 경로 가져오기
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("archive.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
        print("압축 파일 경로 가져오기")
    }
    
    @IBAction func backupButtonClicked(_ sender: UIButton) {
        var urlPaths = [URL]()
        
        // 1. 도큐먼트 폴더 위치 (desktop/seungchan/document/default/realm)
        if let path = documentDirectoryPath() {
            // 2. 백업하고자 하는 파일 확인
            // 이미지 같은 경우 백업 편의성을 위해 폴더를 생성하고, 폴더 내에 이미지를 저장하는 것이 효율적
            let realm = (path as NSString).appendingPathComponent("default.realm")
            // 3. 백업하고자 하는 파일 존재 여부 확인
            if FileManager.default.fileExists(atPath: realm) {
                // 5. URL 배열에 백업 파일 URL 추가
                urlPaths.append(URL(string: realm)!)
            } else {
                print("백업할 파일이 없습니다.")
            }
        }
        // 3. 4번 배열에 대한 압축 파일 만들기
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "archive") // Zip
            print("압축 경로: \(zipFilePath)")
            presentActivityViewController()
        }
        catch {
          print("Something went wrong")
        }
    }
    
    @IBAction func restoreButtonClicked(_ sender: UIButton) {
        // 복구 1. 파일앱 열기 + 확장자
        // import MobileCoreServices
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
        documentPicker.delegate = self
        print("파일앱 열기 + 확장자")
        // 여러 파일 선택할 수 있는 옵션
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true, completion: nil)
    }
    

}

extension SettingViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        // 복구 - 2. 선택한 파일에 대한 경로 가져와야 함
        // ex.  iphone/seungchan/fileapp/archive.zip
        guard let selectedFileURL = urls.first else { return }
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // 예시를 보면 archive.zip 이 lastPathComponent
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        // 복구 - 3. 압축 해제
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            // 기존에 복구하고자 하는 zip파일을 document에 가지고 있을 경우, 도큐멘트에 위치한 zip을 압축 해제 하면 됨!
            print("압축 해제")
            do {
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                // overwrite : 덮어쓰기
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                    print("복구 완료")
                    // 복구가 완료되었습니다 메시지, 처음부터 앱을 다시 시작해달라는 얼럿
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                })
            } catch {
                print("ERROR")
            }
            
        } else {
            // 파일 앱의 zip -> 도큐먼트 폴더에 복사
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                // overwrite : 덮어쓰기
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                    // 복구가 완료되었습니다 메시지, 처음부터 앱을 다시 시작해달라는 얼럿
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                })

            } catch {
                print("ERRORERROR")
            }
        }
        
    }
}
 
