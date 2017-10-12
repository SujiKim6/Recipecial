//
//  ViewController.swift
//  Recipecial
//
//  Created by 김수지 on 2017. 10. 12..
//  Copyright © 2017년 Suji. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* 레시피명 및 상세레시피 내용 저장하는 배열 선언 */
        let subRecipeName = ["스테이크&치즈", "B.L.T 레시피 1", "B.L.T 레시피 2", "스파이시 이탈리안", "에그마요", "치킨데리야끼", "이탈리아 B.M.T"]
        let subDetailRecipe = ["빵: 플랫브래드 + 야채: 취향대로 + 소스: 마요네즈, 바베큐", "빵: 파마산 + 야채: 기본 또는 취향대로 + 추가: 오믈렛 + 소스: 스위트 어니언, 사우스 웨스트, 후추", "빵: 플랫브래드 + 야채: 취향대로 + 소스: 마요네즈, 스위트 칠리", "빵: 화이트 + 야채: 올리브 많이 + 소스: 핫칠리, 스위트칠리", "빵: 허니오트 + 야채: 야채많이 + 소스: 마요네즈, 렌치 드레싱, 후추듬뿍", "빵: 허니오트 + 야채: 취향대로 + 소스: 바베큐, 스위트 어니언, 렌치 드레싱", "빵: 플랫브래드 + 야채: 취향대로 + 소스: 스위트 칠리, 스위트 어니언, 랜치 드레싱"]
        let starRecipeName = ["슈렉프라푸치노", "캡틴크런치베리프라푸치노", "고디바프라푸치노", "돼지바프라푸치노", "트윅스프라푸치노", "스니커즈프라푸치노", "바닐라 크림파이 프라푸치노"]
        let starDetailRecipe = ["그린티프라푸치노 + 에스프레소 1샷 + 자바칩 + 초코휘핑 + 초코 드리즐 + 통자바칩", "두유딸기크림프라푸치노 + 헤이즐넛시럽 2펌프", "자바칩프라푸치노 + 헤이즐넛시럽 3펌프 + 모카시럽 5펌프 + 프라푸치노로스트 4번", "딸기크림프라푸치노 + 딸기시럽 6펌프 + 자바칩 + 초코드리즐(바닥에) + 초코드리즐(휘핑)", "카라멜프라푸치노 + 헤이즐넛시럽 1펌프 + 자바칩(반은 갈고 반은 토핑) + 초코드리즐(바닥, 휘핑) + 카라멜드리즐(바닥, 휘핑)", "자바칩프라푸치노 + 헤이즐넛시럽 2펌프 + 카라멜 드리즐", "바닐라프라푸치노 + 바닐라시럽 1펌프 + 헤이즐넛시럽 1펌프 + 바나나 추가"]
        
        /* 코어 데이터에 기존 추천 레시피 코어데이터에 저장 */
        // 처음 어플 실행시 한번 실행 후 주석 처리하기. 중복으로 들어가는 것을 방지하기 위함.
//        let context = self.getContext()
//        let newRecipes = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: context)
//        
//        for i in 0..<subRecipeName.count {
//            newRecipes.setValue("Subway", forKey: "brand")
//            newRecipes.setValue(subRecipeName[i], forKey: "menuName")
//            newRecipes.setValue(subDetailRecipe[i], forKey: "detailMenu")
//            do {
//                try context.save()
//                print("Success Saving")
//            }
//            catch {
//                //Error 발생시
//                print("Fail Saving")
//            }
//        }
//        
//        for i in 0..<starRecipeName.count {
//            newRecipes.setValue("Starbucks", forKey: "brand")
//            newRecipes.setValue(starRecipeName[i], forKey: "menuName")
//            newRecipes.setValue(starDetailRecipe[i], forKey: "detailMenu")
//            do {
//                try context.save()
//                print("Success Saving")
//            }
//            catch {
//                //Error 발생시
//                print("Fail Saving")
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }


}

