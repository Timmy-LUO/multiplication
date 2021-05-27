//
//  ViewController.swift
//  multiplication
//
//  Created by 羅承志 on 2021/5/27.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionSlider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var assessLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var upNumberLabel: UILabel!
    @IBOutlet weak var downNumberLabel: UILabel!
    @IBOutlet weak var isHiddenView: UIView!
    
    var index = 1
    var score = 0
    //亂數(被乘數&乘數)
    var count1 = Int.random(in: 1...9)
    var count2 = Int.random(in: 1...9)
    //選擇題選項（生成兩個亂數一個答案）
    var options:[Int] = []
    var option1 = Int.random(in: 1...99)
    var option2 = Int.random(in: 1...99)
    var answer = 0
    
    func randomQuestions() {
        count1 = Int.random(in: 1...9)
        count2 = Int.random(in: 1...9)
        upNumberLabel.text = "\(count1)"
        downNumberLabel.text = "\(count2)"
        //選擇題選項-Array三個選項(btn)
        //每次array須歸零，否則將一直append上去！
        options = []
        //選項需要三個數字（兩個錯誤答案，一個正確答案）
        option1 = Int.random(in: 1...99)
        option2 = Int.random(in: 1...99)
        answer = count1 * count2
        //三個數字加進array
        options.append(option1)
        options.append(option2)
        options.append(answer)
        //答案btn位置變換
        options.shuffle()
        //選擇題選項-數字顯示
        for i in 0...2{
            answerButtons[i].setTitle(String(options[i]), for: .normal)
        }
        //題數連動slider
        questionLabel.text = "Q.\(index)"
        questionSlider.value = Float(index)
        //分數label顯示
        scoreLabel.text = "\(score)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomQuestions()
        upNumberLabel.text = "\(count1)"
        downNumberLabel.text = "\(count2)"
        questionLabel.text = "Q.\(index)"
        questionSlider.value = Float(index)
        scoreLabel.text = "\(score)"
        playAgainButton.isHidden = true
        isHiddenView.isHidden = true
    }
    
    @IBAction func selectAnswer(_ sender: UIButton) {
        index += 1
        if sender.currentTitle == String(answer) {
            score += 10
            scoreLabel.text = "\(score)"
            assessLabel.text = "🥳🥳🥳🥳"
        } else {
            assessLabel.text = "😈😈😈😈"
        }
        //第十題時（遊戲結束）
        if index > 10 {
            index = 10
            if score <= 30 {
                assessLabel.text = "爛透了👎！！"
            } else if score <= 60 {
                assessLabel.text = "再加油🙏！！"
            } else {
                assessLabel.text = "完美全答對👍"
            }
            isHiddenView.isHidden = false
            playAgainButton.isHidden = false
        }
        randomQuestions()
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        index = 1
        score = 0
        assessLabel.text = ""
        playAgainButton.isHidden = true
        isHiddenView.isHidden = true
        randomQuestions()
    }
}

