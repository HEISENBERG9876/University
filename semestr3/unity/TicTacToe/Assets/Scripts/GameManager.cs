using UnityEngine;

public class GameManager : MonoBehaviour{
    public TileManager tileManager;
    public UIManager uiManager;
    public AIPlayer aiPlayer;

    public enum Player{
        Human,
        AI,
        Empty
    }

    public enum GameResult{
        InProgress,
        HumanWon,
        AIWon,
        Draw
    }

    private Player currentPlayer = Player.Human;
    private Player startingPlayer = Player.Human;
    private Player[,] gameStateArray = new Player[3, 3];
    private int moveCounter = 0;
    private int humanScore;
    private int aiScore;
    private int drawScore;
    private bool isGameEnded = false;

    private void Start(){
        ClearGameStateArray(); //zeby miec tylko Player.Empty w gameStateArray, tzn. same niezapelnione pola.
        tileManager.InstantiateTiles();
    }

    private void Update(){
        GameResult gameResult = GetGameResult();
        if (!isGameEnded){
            if (gameResult != GameResult.InProgress){
                EndGame(gameResult);
                isGameEnded = true;
                return;
            }
            if (currentPlayer == Player.Human)
            {
                GameObject tileClickedByPlayer = tileManager.GetTileClickedByPlayer();
                if (tileClickedByPlayer != null){
                    HandleTileClick(tileClickedByPlayer);
                }
            }
            else{
                GameObject tileClickedByAI = tileManager.GetTileAtPosition(aiPlayer.FindBestMove(currentPlayer, gameStateArray));
                if (tileClickedByAI != null){
                    HandleTileClick(tileClickedByAI);
                }
            }
        }
    }

    private void HandleTileClick(GameObject clickedTile){
        tileManager.ModifyClickedTile(clickedTile, currentPlayer);
        UpdateGameStateArray(clickedTile.transform.position, currentPlayer);
        currentPlayer = (currentPlayer == Player.Human) ? Player.AI : Player.Human;
        IncrementMoveCounter();
    }

    //zamieniamy pozycje plytki na pozycje w tablicy ze stanem gry
    private void UpdateGameStateArray(Vector3 tilePosition, Player currentPlayer){
        int row = Mathf.RoundToInt(tilePosition.z / tileManager.offset);
        int col = Mathf.RoundToInt(tilePosition.x / tileManager.offset);
        gameStateArray[row, col] = currentPlayer;
    }

    private GameResult GetGameResult(){
        for (int i = 0; i < 3; i++){
            //wiersze
            if(CheckThreeInSequence(gameStateArray[i, 0], gameStateArray[i, 1], gameStateArray[i, 2])){
                return GetGameResultForPlayer(gameStateArray[i, 0]);
            }
            //kolumny
            if(CheckThreeInSequence(gameStateArray[0, i], gameStateArray[1, i], gameStateArray[2, i])){
                return GetGameResultForPlayer(gameStateArray[0, i]);
            }
        }
        //przekatne
        if(CheckThreeInSequence(gameStateArray[0, 0], gameStateArray[1, 1], gameStateArray[2, 2])){
            return GetGameResultForPlayer(gameStateArray[0, 0]);
        }
        if(CheckThreeInSequence(gameStateArray[2, 0], gameStateArray[1, 1], gameStateArray[0, 2])){
            return GetGameResultForPlayer(gameStateArray[2, 0]);
        }

        if (CheckDraw()){
            return GameResult.Draw;
        }

        return GameResult.InProgress;
    }

    private bool CheckThreeInSequence(Player field1, Player field2, Player field3){
        return field1 == field2 && field2 == field3 && field1 != Player.Empty;
    }

    private GameResult GetGameResultForPlayer(Player player){
        return player == Player.Human ? GameResult.HumanWon : GameResult.AIWon;
    }

    private bool CheckDraw(){
        return moveCounter == 9;
    }

    private void EndGame(GameResult result){
        uiManager.ShowEndMessage(result);
        IncrementScore(result);
        uiManager.UpdateScoreboard(result, humanScore, aiScore, drawScore);
    }

    private void ClearGameStateArray(){
        for (int i = 0; i < 3; i++){
            for (int j = 0; j < 3; j ++){
                gameStateArray[i, j] = Player.Empty;
            }
        }
    }

    private void RestartGameGeneric(bool playerChange){
        ClearGameStateArray();

        tileManager.StopAllCoroutines();
        tileManager.DestroyAllTiles();
        tileManager.InstantiateTiles();

        uiManager.HideEndMessage();

        moveCounter = 0;
        isGameEnded = false;

        if (playerChange){
            startingPlayer = ChangePlayer(startingPlayer);
        }

        currentPlayer = startingPlayer;
    }
    public void RestartGame(){
        RestartGameGeneric(false);
    }

    public void ChangePlayerAndRestart(){
        RestartGameGeneric(true);
    }

    private Player ChangePlayer(Player player){
        return (player == Player.Human) ? Player.AI : Player.Human;
    }

    private void IncrementScore(GameResult result){
        if(result == GameResult.HumanWon){
            humanScore++;
        }
        else if (result == GameResult.AIWon){
            aiScore++;
        }
        else{
            drawScore++;
        }
    }

    private void IncrementMoveCounter(){
        moveCounter++;
    }

}
