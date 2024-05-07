using TMPro;
using UnityEngine;
using System.Collections;

public class UIManager : MonoBehaviour{
    public TextMeshProUGUI endMessage;
    public TextMeshProUGUI humanScoreCounter;
    public TextMeshProUGUI aiScoreCounter;
    public TextMeshProUGUI drawCounter;

    private void ToggleEndMessage(bool toggle){
        endMessage.gameObject.SetActive(toggle);
    }

    public void HideEndMessage(){
        ToggleEndMessage(false);
    }

    public void UpdateScoreboard(GameManager.GameResult result, int humanScore, int aiScore, int drawScore){
        if(result == GameManager.GameResult.HumanWon){
            humanScoreCounter.text = humanScore.ToString();
        }
        else if(result == GameManager.GameResult.AIWon){
            aiScoreCounter.text = aiScore.ToString();
        }
        else{
            drawCounter.text = drawScore.ToString();
        }
    }

    public void ShowEndMessage(GameManager.GameResult result){
        string message = "";
        if(result == GameManager.GameResult.HumanWon){
            message = "Player won!";
        }
        else if(result == GameManager.GameResult.AIWon){
            message = "Computer won!";
        }
        else if (result == GameManager.GameResult.InProgress){
            Debug.LogError("Error: game ended with result InProgress.");
            message = "Error :(";
        }
        else{
            message = "DRAW";
        }
        StartCoroutine(TypeEndMessage(message));
    }
    private IEnumerator TypeEndMessage(string message){
        endMessage.text = "";
        ToggleEndMessage(true);
        float letterDelay = 0.1f;

        foreach (char letter in message.ToCharArray()){
            endMessage.text += letter;
            yield return new WaitForSeconds(letterDelay);
        }
    }

}
