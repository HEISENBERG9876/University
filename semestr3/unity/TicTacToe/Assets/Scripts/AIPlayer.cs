using UnityEngine;

public class AIPlayer : MonoBehaviour{
     private (int row, int col)? FindRandomMove(GameManager.Player[,] gameStateArray){
        int starting_row = UnityEngine.Random.Range(0, 3);
        int starting_col = UnityEngine.Random.Range(0, 3);
        //zaczynamy od losowego indeksu, a potem iterujemy po wszystkich pozostałych.
        for(int i = 0; i < 3; i++){
            int row = (starting_row + i) % 3;
            for(int j = 0; j < 3; j++){
                int col = (starting_col + j) % 3;
                if(gameStateArray[row, col] == GameManager.Player.Empty){
                    return (row, col);
                }
            }
        }
        return null;
    }

    private (int row, int col)? FindWinningMove(GameManager.Player player, GameManager.Player[,] gameStateArray){
        for(int row = 0; row < 3; row++){
            for(int col = 0; col < 3; col++){
                if(gameStateArray[row, col] == GameManager.Player.Empty){
                    //sprawdzamy wiersze i kolumny
                    if((gameStateArray[(row + 1) % 3, col] == player && gameStateArray[(row + 2) % 3, col] == player) ||
                        (gameStateArray[row, (col + 1) % 3] == player && gameStateArray[row, (col + 2) % 3] == player) ){
                        return (row, col);
                    }
                    //pierwsza kolumna
                     if(row == col){
                        if(gameStateArray[(row + 1) % 3, (col + 1) % 3] == player && gameStateArray[(row + 2) % 3, (col + 2) % 3] == player){
                            return (row, col);
                        }
                    }
                    //druga kolumna
                    if(row + col == 2){
                         if(gameStateArray[(row + 1) % 3, (col + 2) % 3] == player && gameStateArray[(row + 2) % 3, (col + 1) % 3] == player){
                            return (row, col);
                         }
                    }
                }
            }
        }
        return null;
    }

    public (int row, int col)? FindBestMove(GameManager.Player player, GameManager.Player[,] gameStateArray){
        (int row, int col)? winningMove = FindWinningMove(GameManager.Player.AI, gameStateArray);
        if(winningMove != null){
            return winningMove;
        }
        else{
            //jesli nie mozemy wygrac, to szukamy miejsca, w ktorym przeciwny gracz moze wygrac, zeby go zablokowac.
            (int row, int col)? blockingMove = FindWinningMove(GameManager.Player.Human, gameStateArray);
            return (blockingMove != null) ? blockingMove : FindRandomMove(gameStateArray);
        }
    }
}
