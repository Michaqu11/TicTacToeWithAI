import Foundation

class Board {
  
  var board = [[String]]()
  
  var boardSize = 3
  var numerOfSigns = 0
  init(_ boardSize: Int){
    self.boardSize = boardSize
   board = Array(repeating: Array(repeating: "_", count: boardSize), count: boardSize)
  }

  func resetGame(){
    numerOfSigns = 0
    
     for i in 0...boardSize-1 {
      for j in 0...boardSize-1 {
        board[i][j] = "_" 
      }
    }
  }
  
  func checkWin() -> String {
     for y in 0...2 {
        if board[y][0] == board[y][1] && board[y][1] == board[y][2] && board[y][0] != "_" {
          return board[y][0]
        }
      }

      for x in 0...2 {
        if board[0][x] == board[1][x] && board[1][x] == board[2][x] && board[0][x] != "_" {
          return  board[0][x]
        }
      }
      if board[0][0] == board[1][1] && board[1][1] == board[2][2]  && board[0][0] != "_" {
        return board[0][0]
      }
      if board[2][0] == board[1][1] && board[1][1] == board[0][2]  && board[2][0] != "_" {
       return board[2][0] 
      }
  return "_"
  }

  func checkBoard() -> (Bool, String){
    var game = true
    let winner = checkWin() 
    if numerOfSigns == boardSize * boardSize ||  winner != "_"{
      game = false
    }
    return (game, winner)

  }  
}

class Player {
  var sign = ""
  var name = ""
  init(_ sign: String, _ name: String){
    self.sign = sign
    self.name = name
  }

  func move(_ board: Board){
    while(true){
      print("wybierz pole [1-9]")
      let position = readLine()
      if let positionNumber = Int(position!) {
        var k = 0
        for i in 0...board.boardSize-1 {
          for j in 0...board.boardSize-1 {
            if k == positionNumber-1 {
              if board.board[i][j] == "_"{
                board.board[i][j] = self.sign
                board.numerOfSigns =  board.numerOfSigns + 1
                return
              }
              else{
                print("Wybierz puste pole")
              }
            }
            k = k + 1
          }
        }
      }
    }
  }

}

class AI: Player {
  var level = 0

  func setLevel(_ lvl: Int){
    level = lvl
  }
  
  func easyMove(_ board: Board){
    while(true){
      let positionNumber = Int.random(in: 1..<board.boardSize*board.boardSize)
      for i in 0...board.boardSize-1 {
        var k = 0
        for j in 0...board.boardSize-1 {
          if k == positionNumber-1{
            if board.board[i][j] == "_"{
              board.board[i][j] = self.sign
              board.numerOfSigns =  board.numerOfSigns + 1
              return
            }
          }
          k = k + 1
        }  
      }
    }
  }

  func mediumMove(_ board: Board){

    if  board.board[0][0] ==  board.board[2][2] &&  board.board[0][0] != "_" &&  board.board[1][1] == "_" {
      board.board[1][1] = self.sign
      board.numerOfSigns =  board.numerOfSigns + 1
      return
    }
    else if  board.board[2][0] ==  board.board[0][2] &&  board.board[2][0] != "_" &&  board.board[1][1] == "_" {
      board.board[1][1] = self.sign
      board.numerOfSigns =  board.numerOfSigns + 1
      return
    }
    else if  board.board[0][0] ==  board.board[1][1] &&  board.board[0][0] != "_" &&  board.board[2][2] == "_" {
      board.board[2][2] = self.sign
      board.numerOfSigns =  board.numerOfSigns + 1
      return
    }
    else if  board.board[2][2] ==  board.board[1][1] &&  board.board[1][1] != "_" &&  board.board[0][0] == "_" {
      board.board[0][0] = self.sign
      board.numerOfSigns =  board.numerOfSigns + 1
      return
    }
    else if  board.board[2][0] ==  board.board[1][1] &&  board.board[1][1] != "_" &&  board.board[0][2] == "_" {
      board.board[0][2] = self.sign
      board.numerOfSigns =  board.numerOfSigns + 1
      return
    }
    else if  board.board[0][2] ==  board.board[1][1] &&  board.board[1][1] != "_" &&  board.board[2][0] == "_" {
      board.board[2][0] = self.sign
      board.numerOfSigns =  board.numerOfSigns + 1
      return
    }

    for i in 0...board.boardSize-1 {
      if board.board[i][0] == board.board[i][1] && board.board[i][0] != "_" && board.board[i][2] == "_" {
        board.board[i][2] = self.sign
        board.numerOfSigns =  board.numerOfSigns + 1
        return
      }
       if board.board[i][0] == board.board[i][2] && board.board[i][0] != "_" && board.board[i][1] == "_" {
        board.board[i][1] = self.sign
        board.numerOfSigns =  board.numerOfSigns + 1
        return
      }
      if board.board[i][2] == board.board[i][1] && board.board[i][1] != "_" && board.board[i][0] == "_" {
        board.board[i][0] = self.sign
        board.numerOfSigns =  board.numerOfSigns + 1
        return
      }  
    }
    for i in 0...board.boardSize-1 {
      
      if board.board[0][i] == board.board[1][i] &&  board.board[0][i] != "_" &&  board.board[2][i] == "_" {
        board.board[2][i] = self.sign
        board.numerOfSigns =  board.numerOfSigns + 1
        return
      }
      else if  board.board[0][i] ==  board.board[2][i] &&  board.board[0][i] != "_" &&  board.board[1][i] == "_" {
        board.board[1][i] = self.sign
        board.numerOfSigns =  board.numerOfSigns + 1
        return
      }
      else if board.board[2][i] == board.board[1][i] && board.board[1][i] != "_" && board.board[0][i] == "_" {
        board.board[0][i] = self.sign
        board.numerOfSigns =  board.numerOfSigns + 1
        return
      }
    }
      easyMove(board)
}

   func hardMove(_ board: Board){

    let searchSign = self.sign
    if  board.board[0][0] ==  board.board[2][2] && board.board[2][2]  == searchSign &&  board.board[0][0] != "_" &&  board.board[1][1] == "_" {
      board.board[1][1] = self.sign
      board.numerOfSigns =  board.numerOfSigns + 1
      return
    }
    else if  board.board[2][0] ==  board.board[0][2] && board.board[0][2]  == searchSign &&  board.board[2][0] != "_" &&  board.board[1][1] == "_" {
      board.board[1][1] = self.sign
      board.numerOfSigns =  board.numerOfSigns + 1
      return
    }
    else if  board.board[0][0] ==  board.board[1][1] && board.board[1][1]  == searchSign &&  board.board[0][0] != "_" &&  board.board[2][2] == "_" {
      board.board[2][2] = self.sign
      board.numerOfSigns =  board.numerOfSigns + 1
      return
    }
    else if  board.board[2][2] ==  board.board[1][1] && board.board[2][2]  == searchSign &&  board.board[1][1] != "_" &&  board.board[0][0] == "_" {
      board.board[0][0] = self.sign
      board.numerOfSigns =  board.numerOfSigns + 1
      return
    }
    else if  board.board[2][0] ==  board.board[1][1] && board.board[1][1]  == searchSign &&  board.board[1][1] != "_" &&  board.board[0][2] == "_" {
      board.board[0][2] = self.sign
      board.numerOfSigns =  board.numerOfSigns + 1
      return
    }
    else if  board.board[0][2] ==  board.board[1][1] && board.board[1][1]  == searchSign &&  board.board[1][1] != "_" &&  board.board[2][0] == "_" {
      board.board[2][0] = self.sign
      board.numerOfSigns =  board.numerOfSigns + 1
      return
    }

    for i in 0...board.boardSize-1 {
      if board.board[i][0] == board.board[i][1] && board.board[i][0] != "_" && board.board[i][2] == "_" {
        board.board[i][2] = self.sign
        board.numerOfSigns =  board.numerOfSigns + 1
        return
      }
       if board.board[i][0] == board.board[i][2] && board.board[i][0] != "_" && board.board[i][1] == "_" {
        board.board[i][1] = self.sign
        board.numerOfSigns =  board.numerOfSigns + 1
        return
      }
      if board.board[i][2] == board.board[i][1] && board.board[i][1] != "_" && board.board[i][0] == "_" {
        board.board[i][0] = self.sign
        board.numerOfSigns =  board.numerOfSigns + 1
        return
      }  
    }
    for i in 0...board.boardSize-1 {
      if board.board[0][i] == board.board[1][i] && board.board[1][i]  == searchSign &&  board.board[0][i] != "_" &&  board.board[2][i] == "_" {
        board.board[2][i] = self.sign
        board.numerOfSigns =  board.numerOfSigns + 1
        return
      }
      else if  board.board[0][i] ==  board.board[2][i] && board.board[2][i]  == searchSign &&  board.board[0][i] != "_" &&  board.board[1][i] == "_" {
        board.board[1][i] = self.sign
        board.numerOfSigns =  board.numerOfSigns + 1
        return
      }
      else if board.board[2][i] == board.board[1][i] && board.board[1][i]  == searchSign && board.board[1][i] != "_" && board.board[0][i] == "_" {
        board.board[0][i] = self.sign
        board.numerOfSigns =  board.numerOfSigns + 1
        return
      }
    }
      mediumMove(board)
   }

  override func move(_ board: Board){
    if self.level == 0 {
      easyMove(board)
    }
    else if self.level == 1{
      mediumMove(board)
    }
    else{
      hardMove(board)
    }
  }
}


func printBoard(_ board: Board){
  print()
  for i in 0...board.boardSize-1 {
      print("| ", terminator: "")
      for j in 0...board.boardSize-1 {
        if j != board.boardSize-1 {
          print(board.board[i][j], terminator: " | ")
        }
        else{
          print(board.board[i][j],terminator: " |\r\n")
          if(i != board.boardSize-1){
            print("-------------")
          }
        }
      }
  }
  print("\r\n")
}

func printWinner(_ board: Board, _ winSign: String,  _ player1: Player, _ player2: Player ){
  printBoard(board)
  print()
  if winSign == player1.sign{
    print("---------------\r\n| \(player1.name) won game |\r\n---------------")
  }
  else if winSign == player2.sign {
        print("\r\n---------------\n| \(player2.name) won game |\r\n---------------")
  }
  else{
    print("\r\n------------------\r\n| No one won game |\r\n------------------")
  }

}

func reset(_ board: Board, _ player: AI)-> Bool{


  print("\r\nCzy chcesz zagrac jeszcze raz? [T, N]")
  let dalej = readLine()
  if dalej! == "T"{
    print("Wybierz poziom bota\r\n- easy = 1\r\n- medium = 2\r\n- hard = 3")
    let lvl = readLine()
    if let level = Int(lvl!) {
      player.setLevel(level-1)
    }
    print("Start gry!\r\n")
    
    board.resetGame()
    return true
  }
  return false
}


func game(_ board: Board, _ player1: Player, _ player2: AI){

  var game = true
  var i = 0
  var winner = "_"
  while(game){
    printBoard(board)
    if i.isMultiple(of:2) {
      player1.move(board)
    }
    else{
       player2.move(board)
    }
    (game, winner) = board.checkBoard()

    if game == false {
      printWinner(board, winner, player1, player2)
      game = reset(board, player2 )
    }
    i = i + 1
  }
}

var b = Board(3)
var p1 = Player("X", "p1")
var a1 = AI("O", "a1")
print("Wybierz poziom bota\r\n- easy = 1\r\n- medium = 2\r\n- hard = 3")
let lvl = readLine()
if let level = Int(lvl!) {
  a1.setLevel(level-1)
}
print("Start gry!\r\n")
game(b, p1, a1)

/*

| 1 | 2 | 3 |
-------------
| 4 | 5 | 6 |
-------------
| 7 | 8 | 9 |

*/
