//
//  UpdateStarbucksMenuViewController.swift
//  Recipecial
//
//  Created by 김수지 on 2017. 10. 13..
//  Copyright © 2017년 Suji. All rights reserved.
//

import UIKit

class UpdateStarbucksMenuViewController: UIViewController {
    
    @IBOutlet var labelRecipeName: UILabel!
    @IBOutlet var labelMenuName: UILabel!
    @IBOutlet var pickerCoffeeShot: UIPickerView!
    @IBOutlet var pickerSyrup: UIPickerView!
    @IBOutlet var textFieldMilk: UITextField!
    @IBOutlet var textFieldWhipping: UITextField!
    @IBOutlet var textFieldDrizzle: UITextField!
    
    
    let numberOfAdd:[String] = ["1","2","3","4","5","6","7","8","9"]
    let syrubTypes:[String] = ["바닐라", "헤이즐넛", "카라멜"]
    let coffeTypes:[String] = ["에스프레소", "디카페인", "1/2디카페인"]

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
