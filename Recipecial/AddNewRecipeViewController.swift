//
//  AddNewRecipeViewController.swift
//  Recipecial
//
//  Created by 김수지 on 2017. 10. 12..
//  Copyright © 2017년 Suji. All rights reserved.
//

import UIKit

class AddNewRecipeViewController: UIViewController {

    @IBOutlet var textFieldNewName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func buttonOK() {
        /* text field를 다 입력하지 않았을 경우 */
        if textFieldNewName.text == "" {
            let dialog = UIAlertController(title: "오류", message: "새로운 이름을 입력해주세요.", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
            dialog.addAction(action)
            
            self.present(dialog, animated: true, completion: nil)
        }
        /* 다 입력했을 경우 -> core data에 저장하고 홈화면으로 돌아가기 */
        else {
            
        }
    }

}
