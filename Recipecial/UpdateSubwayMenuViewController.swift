//
//  UpdateSubwayMenuViewController.swift
//  Recipecial
//
//  Created by 김수지 on 2017. 10. 13..
//  Copyright © 2017년 Suji. All rights reserved.
//

import UIKit

class UpdateSubwayMenuViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var labelMenuName: UILabel!
    @IBOutlet var pickerBread: UIPickerView!
    @IBOutlet var pickerCheese: UIPickerView!
    @IBOutlet var textFieldAdditional: UITextField!
    @IBOutlet var textFieldVeget: UITextField!
    @IBOutlet var textFieldSauce: UITextField!
    @IBOutlet var segBreadCooked: UISegmentedControl!
    
    var menuName:String?
    let breadTypes:[String] = ["하티", "위트", "허니오트", "화이트", "파마산 오레가노", "플랫 브레드"]
    let cheeseTypes:[String] = ["아메리칸 치즈", "슈레드 치즈"]
    
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
    @IBAction func btnInitialize() {
    }
    
    /* segue에 따른 처리, 넘어가는 화면에 내용 넘겨주기 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewNameFinal" {
            
            let destVC = segue.destination as! FinalRecipeViewController
            
            
        }
    }
    
    
}
