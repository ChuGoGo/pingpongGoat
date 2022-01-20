//
//  ViewController.swift
//  pingpongGoat
//
//  Created by Chu Go-Go on 2022/1/12.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var leftScoreButton: UIButton!
    @IBOutlet weak var rightScoreButton: UIButton!
    @IBOutlet weak var player1Name: UILabel!
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var leftRoundLabel: UILabel!
    @IBOutlet weak var rightRoundLabel: UILabel!
    @IBOutlet weak var leftPlayerNameTextField: UITextField!
    @IBOutlet weak var rightPlayerNameTextField: UITextField!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var leftPoint: UILabel!
    @IBOutlet weak var rightPoint: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pointruleSegmented: UISegmentedControl!
    @IBOutlet weak var leftserve: UILabel!
    @IBOutlet weak var rightServe: UILabel!
    var timer : Timer?
    var leftPlayer = Player(serve: true)
    var rightPlayer = Player(serve: false)
    var duce = false
    var records = [Record]()
    var rightpointNum = 0
    var leftPointNum = 0
    var leftWinCount = 0
    var rightWinCount = 0
    var roundCount = 1
    var timeCount = 0
    var serveScore = 0
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        .landscape
    }
    @objc func updateTime() {
    timeCount += 1
        timerLabel.text = timeSet(timeCount)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resetGame()
        
    }

    
    @IBAction func addPoint(_ sender: UIButton) {
//        先紀錄一個Rocord來儲存記錄他們的值
        saveRocord(leftPlayer: leftPlayer, rightPlayer: rightPlayer, duce: duce, serveScore: serveScore)
//        如果你得按鈕 === 左邊按鈕，然後11分制selectedSegmentIndex == 0
        if sender === leftScoreButton, pointruleSegmented.selectedSegmentIndex == 0 {
//            當你按下左變時左邊分數就會＋1
            leftPlayer.pointNum += 1
//            用label顯示左邊的分數
            leftPoint.text = "\(leftPlayer.pointNum)"
//            發球權就會 + 1 。 + 2時會便會發球權
            serveScore += 1
//            如果當duce成立時就會跑到這個if 裡面
            if duce == true {
//                會讓他每一分都變換發球權
                serveScore = 2
//                要計算duce的分數得2分者會獲勝，當分數同分時要讓對方的ducePoint = 0
                rightPlayer.ducePoint = 0
//                左邊的要加一分
                leftPlayer.ducePoint += 1
//              最後的發球權
                sevreChangeLast(sevreScore: serveScore)
                changeServe()
            }
        }else if sender === rightScoreButton , pointruleSegmented.selectedSegmentIndex == 0 {
                serveScore += 1
                rightPlayer.pointNum += 1
                rightPoint.text = "\(rightPlayer.pointNum)"
            if duce == true {
                serveScore = 2
                leftPlayer.ducePoint = 0
                rightPlayer.ducePoint += 1
                print("右邊", rightPlayer.ducePoint)
                print("左邊", leftPlayer.ducePoint)
                sevreChangeLast(sevreScore: serveScore)
                changeServe()
            }
        }//獲勝時要分數等於11分，而且沒有發生duce的情況，以11分制
        if leftPlayer.pointNum == 11 , duce == false ,pointruleSegmented.selectedSegmentIndex == 0 {
//            獲勝時分數要變成0
            leftPoint.text = "0"
            rightPoint.text = "0"
//            左邊玩家的勝場數+1
            leftPlayer.WinCount += 1
//            顯示在Label上
            leftRoundLabel.text = "\(leftPlayer.WinCount)"
//            分數歸0
            leftPlayer.pointNum = 0
            rightPlayer.pointNum = 0
//            duce也歸0
            leftPlayer.ducePoint = 0
            rightPlayer.ducePoint = 0
//            輪數加1
            roundCount += 1
//            顯示現在第幾輪
            roundLabel.text = "Round\(roundCount)"
//            計時暫停
            timer?.invalidate()
        }else if rightPlayer.pointNum == 11 , duce == false , pointruleSegmented.selectedSegmentIndex == 0{
            rightPoint.text = "0"
            leftPoint.text = "0"
            rightPlayer.WinCount += 1
            rightRoundLabel.text = "\(rightPlayer.WinCount)"
            leftPlayer.pointNum = 0
            rightPlayer.pointNum = 0
            rightPlayer.ducePoint = 0
            leftPlayer.ducePoint = 0
            roundCount += 1
            roundLabel.text = "Round\(roundCount)"
            timer = nil
//            當左邊跟右邊的比分一樣且分數大於=10分時會觸發。
    }else if leftPlayer.pointNum == rightPlayer.pointNum , rightPlayer.pointNum >= 10 , leftPlayer.pointNum >= 10 ,pointruleSegmented.selectedSegmentIndex == 0 {
//        duce變成true後就會跑到前面的duce迴圈
        duce = true
//        讓兩邊的duce從0開始算
        rightPlayer.ducePoint = 0
        leftPlayer.ducePoint = 0
//        如果duce成立的話
    }else if duce == true {
//        如果左邊的ducePoint == 2時會觸發勝利條件
         if leftPlayer.ducePoint == 2 {
                leftPoint.text = "0"
                rightPoint.text = "0"
                leftPlayer.WinCount += 1
                leftRoundLabel.text = "\(leftPlayer.WinCount)"
                leftPlayer.pointNum = 0
                rightPlayer.pointNum = 0
                leftPlayer.ducePoint = 0
                rightPlayer.ducePoint = 0
                roundCount += 1
                duce = false
                roundLabel.text = "Round\(roundCount)"
                
            }else if rightPlayer.ducePoint == 2 {
                rightPoint.text = "0"
                leftPoint.text = "0"
                rightPlayer.WinCount += 1
                rightRoundLabel.text = "\(rightPlayer.WinCount)"
                leftPlayer.pointNum = 0
                rightPlayer.pointNum = 0
                rightPlayer.ducePoint = 0
                leftPlayer.ducePoint = 0
                roundCount += 1
                roundLabel.text = "Round\(roundCount)"
                duce = false
                
                        }
    }
        if sender === leftScoreButton, pointruleSegmented.selectedSegmentIndex == 1 {
            leftPlayer.pointNum += 1
            leftPoint.text = "\(leftPlayer.pointNum)"
            serveScore += 1
            if duce == true {
                serveScore = 2
                rightPlayer.ducePoint = 0
                leftPlayer.ducePoint += 1
                print("右邊", rightPlayer.ducePoint)
                print("左邊", leftPlayer.ducePoint)
                sevreChangeLast(sevreScore: serveScore)
            }
        }else if sender === rightScoreButton , pointruleSegmented.selectedSegmentIndex == 1 {
                serveScore += 1
                rightPlayer.pointNum += 1
                rightPoint.text = "\(rightPlayer.pointNum)"
            if duce == true {
                serveScore = 2
                leftPlayer.ducePoint = 0
                rightPlayer.ducePoint += 1
                print("右邊", rightPlayer.ducePoint)
                print("左邊", leftPlayer.ducePoint)
                sevreChangeLast(sevreScore: serveScore)
            }
        }
        if leftPlayer.pointNum == 21 , duce == false ,pointruleSegmented.selectedSegmentIndex == 1 {
            leftPoint.text = "0"
            rightPoint.text = "0"
            leftPlayer.WinCount += 1
            leftRoundLabel.text = "\(leftPlayer.WinCount)"
            leftPlayer.pointNum = 0
            leftPlayer.ducePoint = 0
            rightPlayer.ducePoint = 0
            roundCount += 1
            roundLabel.text = "Round\(roundCount)"
           
        }else if rightPlayer.pointNum == 21 , duce == false , pointruleSegmented.selectedSegmentIndex == 1 {
            rightPoint.text = "0"
            leftPoint.text = "0"
            rightPlayer.WinCount += 1
            rightRoundLabel.text = "\(rightPlayer.WinCount)"
            rightPlayer.pointNum = 0
            rightPlayer.ducePoint = 0
            leftPlayer.ducePoint = 0
            roundCount += 1
            roundLabel.text = "Round\(roundCount)"
            
    }else if leftPlayer.pointNum == rightPlayer.pointNum , rightPlayer.pointNum >= 20 , leftPlayer.pointNum >= 20 ,pointruleSegmented.selectedSegmentIndex == 1 {
        duce = true
        rightPlayer.ducePoint = 0
        leftPlayer.ducePoint = 0
    }else if duce == true {
         if leftPlayer.ducePoint == 2 {
                leftPoint.text = "0"
                rightPoint.text = "0"
                leftPlayer.WinCount += 1
                leftRoundLabel.text = "\(leftPlayer.WinCount)"
                leftPlayer.pointNum = 0
                rightPlayer.pointNum = 0
                leftPlayer.ducePoint = 0
                rightPlayer.ducePoint = 0
                roundCount += 1
                duce = false
                roundLabel.text = "Round\(roundCount)"
               
            }else if rightPlayer.ducePoint == 2 {
                rightPoint.text = "0"
                leftPoint.text = "0"
                rightPlayer.WinCount += 1
                rightRoundLabel.text = "\(rightPlayer.WinCount)"
                leftPlayer.pointNum = 0
                rightPlayer.pointNum = 0
                rightPlayer.ducePoint = 0
                leftPlayer.ducePoint = 0
                roundCount += 1
                roundLabel.text = "Round\(roundCount)"
                duce = false
                
                        }
    }
        sevreChangeLast(sevreScore: serveScore)
        changeServe()

        
    }
    @IBAction func rewind(_ sender: Any) {
//        如果records不是空值的話
        guard !records.isEmpty else {return}
//        先宣告record是最後的動作
        let record = records.last
//        回到上一個動作
        leftPlayer = record!.leftPlayer
        rightPlayer = record!.rightPlayer
        duce = record!.duce
        serveScore = record!.serveScore
        print(serveScore)
        leftPoint.text = "\(leftPlayer.pointNum)"
        rightPoint.text = "\(rightPlayer.pointNum)"
//        把紀錄往前移一個動作
        records.removeLast()
//        發球方也要
        sevreChangeLast(sevreScore: serveScore)
        changeServe()
    }
    @IBAction func changeSide(_ sender: Any) {
//        先記錄原本的值
        saveRocord(leftPlayer: leftPlayer, rightPlayer: rightPlayer, duce: duce, serveScore: serveScore)
//        先儲存一個左邊玩家跟右邊玩家的值
        let switchLeftPlayer = leftPlayer
        let switchLeftRound = leftRoundLabel.text!
        let switchRightRound = rightRoundLabel.text!
        let switchRightPlayer = rightPlayer
        let switchLeftPiont = leftPoint.text!
        let switchRightPiont = rightPoint.text!
        let switchLeftName = player1Name.text!
        let switchRightName = player2NameLabel.text!
        let switchLeftServe = leftserve.text!
        let switchLeftServeScore = leftPlayer.serve
        let switchRightServeScore = rightPlayer.serve
        let switchRightSevre = rightServe.text!
//        把左邊儲存好的值帶入到右邊，再把儲存好的右邊值帶入到左邊
        rightPlayer.serve = switchLeftServeScore
        leftPlayer.serve = switchRightServeScore
        rightServe.text = switchLeftServe
        leftserve.text = switchRightSevre
        leftPlayer = switchRightPlayer
        rightPlayer = switchLeftPlayer
        leftRoundLabel.text = "\(switchRightRound)"
        rightRoundLabel.text = "\(switchLeftRound)"
        leftPoint.text = "\(switchRightPiont)"
        rightPoint.text = "\(switchLeftPiont)"
        player1Name.text = "\(switchRightName)"
        player2NameLabel.text = "\(switchLeftName)"
    }
    @IBAction func resetButton(_ sender: Any) {
        resetGame()
    }
    @IBAction func sentName(_ sender: Any) {
//        如果左邊玩家跟右邊玩家的名字都是空字串的話，就會取名玩家1，玩家2
        if leftPlayerNameTextField.text == "" , rightPlayerNameTextField.text == "" {
            player1Name.text? = "玩家1"
            player2NameLabel.text? = "玩家2"
//            如果有打值的話就是照他打的名字
        }else if leftPlayerNameTextField.text != nil , player2NameLabel.text != nil {
        player1Name.text = leftPlayerNameTextField.text!
        player2NameLabel.text = rightPlayerNameTextField.text!
        }
//        當按下遊戲開始時TextFiekd會隱藏
        leftPlayerNameTextField.isHidden = true
        rightPlayerNameTextField.isHidden = true
//        遊戲開始時會開始跑計時器
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
//    定義一個Func 裡面有判斷左邊玩家 右邊玩家 是否平分
    func saveRocord(leftPlayer: Player , rightPlayer: Player , duce: Bool , serveScore: Int ){
//        把分數給記錄起來
        let record = Record(leftPlayer: leftPlayer, rightPlayer: rightPlayer, duce: duce, serveScore: serveScore)
        records.append(record)
//        只能往前10次
        if KeepRecords(records: records) > 10 {
            records.removeFirst()
        }
    }
//    保存分數
    func KeepRecords(records:[Record]) -> Int{
//        計算分數後
        let roundCount = records.count
//        回傳到分數
        return roundCount
    }

    func resetGame(){
        saveRocord(leftPlayer: leftPlayer, rightPlayer: rightPlayer, duce: duce, serveScore: serveScore)
        leftPointNum = 0
        rightpointNum = 0
        leftPoint.text = "0"
        roundLabel.text = "Round 1"
        leftRoundLabel.text = "0"
        rightPoint.text = "0"
        rightRoundLabel.text = "0"
        leftPlayerNameTextField.isHidden = false
        rightPlayerNameTextField.isHidden = false
        player1Name.text = ""
        player2NameLabel.text = ""
        timerLabel.text = "00:00"
        timer?.invalidate()
        serveScore = 0
        leftPlayer.pointNum = 0
        rightPlayer.pointNum = 0
        rightPlayer.ducePoint = 0
        leftPlayer.ducePoint = 0
    }
//    發球的判定用0,1,2的判斷
    func sevreChangeLast(sevreScore: Int) {
//        如果發球的倫次到2的時候就會換邊，然後變成0
        guard sevreScore == 2 else {return}
        self.serveScore = 0
        changeServe()
    }
//    變換發球方的Func
    func changeServe() {
//       判斷左方發球
        if leftPlayer.serve{
//            左方是不是發球方的話
            leftPlayer.serve = false
//            左方的Label就隱藏
            leftserve.isHidden = true
//            如果是右邊發球
            rightPlayer.serve = true
//            右邊的字就顯示
            rightServe.isHidden = false
        }else{
            leftPlayer.serve = true
            leftserve.isHidden = false
            rightPlayer.serve = false
            rightServe.isHidden = true
        }
    }

    func timeSet(_ secs: Int) -> String{
        var minTime = ""
        var secTime = ""
        if secs / 60 == 0 {
            minTime = "00"
        } else if (secs / 60 > 0 && secs / 60 < 10) {
            minTime = "0\(secs / 60)"
        } else {
            minTime = "\(secs / 60)"
        }
        if secs % 60 == 0{
            secTime = "00"
        } else if (secs % 60 > 0 && secs % 60 < 10) {
            secTime = "0\(secs % 60)"
        }else{
            secTime = "\(secs % 60)"
        }
        return "\(minTime):\(secTime)"
    }
       
        
    
}
    
