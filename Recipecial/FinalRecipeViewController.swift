//
//  FinalRecipeViewController.swift
//  Recipecial
//
//  Created by 김수지 on 2017. 10. 12..
//  Copyright © 2017년 Suji. All rights reserved.
//

import UIKit

class FinalRecipeViewController: UIViewController {
    
    @IBOutlet var labelFinalRecipe: UILabel!
    @IBOutlet var labelName: UILabel!
    
    var finalDetailRecipe:String?
    var finalRecipeName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        /* 최종 레시피의 이름과 최종 레시피를 출력 */
        if let showFinalRecipe = finalDetailRecipe, let showRecipeName = finalRecipeName {
            labelName.text = showRecipeName + "의 최종 레시피"
            labelFinalRecipe.text = showFinalRecipe
        }
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
    
}
