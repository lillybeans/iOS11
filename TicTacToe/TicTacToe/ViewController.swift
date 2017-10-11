//
//  ViewController.swift
//  TicTacToe
//
//  Created by Lilly Tong on 2017-10-10.
//  Copyright © 2017 Lilly Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var hasWon = false
    var player = 1 //1 = "O", 2 = "X"
    var gameState = [0,0,0,0,0,0,0,0,0] //0 - empty, 1 - nought, 2 - cross
    let winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    @IBOutlet var winnerLabel: UILabel!
    
    @IBOutlet var playAgainLabel: UIButton!
    
    @IBAction func playAgain(_ sender: Any) {
        //reset everything
        hasWon = false
        player = 1
        gameState = [0,0,0,0,0,0,0,0,0]
        
        for i in 1..<10 {
            if let button=view.viewWithTag(i) as? UIButton{ //need cast since this will return general view
                button.setImage(nil, for: []) //clear all O's and X's
            }
        }
        
        winnerLabel.isHidden = true
        playAgainLabel.isHidden = true
        
        winnerLabel.center = CGPoint(x:winnerLabel.center.x - 500, y:winnerLabel.center.y)
        playAgainLabel.center = CGPoint(x:playAgainLabel.center.x - 500, y:playAgainLabel.center.y)
        
    }
    

    @IBAction func buttonPressed(_ sender: AnyObject) {
        
        var position = sender.tag - 1 //since our tag is from 1-9 but array is 0-indexed, we need to subtract 1
        
        if gameState[position] == 0 && !hasWon { //only allow move if current spot is empty
            gameState[position] = player //mark position as current player
            if player == 1 {
                sender.setImage(UIImage(named:"nought.png"),for:[])
                player = 2
            } else {
                sender.setImage(UIImage(named:"cross.png"),for:[])
                player = 1
            }
        }
        
        for combo in winningCombinations {
            //make sure first one is not 0 (empty)
            if gameState[combo[0]] != 0 && gameState[combo[0]] == gameState[combo[1]] && gameState[combo[1]] == gameState[combo[2]] {
                
                //winner found
                hasWon = true
                
                //make labels appear
                winnerLabel.isHidden = false
                playAgainLabel.isHidden = false
                
                if gameState[combo[0]] == 1 {
                    winnerLabel.text = "Nought has won!"
                } else {
                    winnerLabel.text = "Cross has won!"
                }
                
                UIView.animate(withDuration: 1, animations: {
                    self.winnerLabel.center = CGPoint(x:self.winnerLabel.center.x+500, y:self.winnerLabel.center.y)
                    self.playAgainLabel.center = CGPoint(x:self.playAgainLabel.center.x+500, y:self.playAgainLabel.center.y)
                })
                
            }
        }

        
        print(sender.tag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winnerLabel.isHidden = true
        playAgainLabel.isHidden = true
        
        //for slide in animation later, first offset label's position by 500 to the left
        winnerLabel.center = CGPoint(x:winnerLabel.center.x - 500, y:winnerLabel.center.y)
        playAgainLabel.center = CGPoint(x:playAgainLabel.center.x - 500, y:playAgainLabel.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

