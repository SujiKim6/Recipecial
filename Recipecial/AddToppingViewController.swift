//
//  AddToppingViewController.swift
//  Recipecial
//
//  Created by 김수지 on 2017. 10. 12..
//  Copyright © 2017년 Suji. All rights reserved.
//

import UIKit

class AddToppingViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var labelSelectedRecipe: UILabel!
    @IBOutlet var textFieldTopping: UITextField!
    @IBOutlet var btnAdd: UIButton!
    @IBOutlet var btnGoThrough: UIButton!
    
    var selectedRecipeDetail:String?
    
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
    
    /* 키보드에 대한 delegate 함수 */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /* segue에 따른 처리 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddFinal" {
            let destVC = segue.destination as! FinalRecipeViewController
            
            // 선택된 레시피에 대한 레시피 전달 받고 그에 대한 추가된 토핑 넣어서 전달
            if let originalRecipe = selectedRecipeDetail {
                var sendRecipe:String = originalRecipe
                sendRecipe += " + "
                sendRecipe += textFieldTopping.text!
                destVC.finalDetailRecipe = sendRecipe
            }
        }
        else {
            let destVC = segue.destination as! FinalRecipeViewController

            if let originalRecipe = selectedRecipeDetail {
                destVC.finalDetailRecipe = originalRecipe
            }
        }
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        /* 추가하기 버튼이 눌렸을 경우 */
        if sender == btnAdd {
            
            /* text field가 비어있는 상태로 눌렀을 경우 경고창 띄우기 */
            if textFieldTopping.text == "" {
                let dialog = UIAlertController(title: "오류", message: "추가할 토핑을 입력해주세요.", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
                dialog.addAction(action)
                
                self.present(dialog, animated: true, completion: nil)
            }
        }

    }
    
}
