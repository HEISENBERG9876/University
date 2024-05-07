using UnityEngine;
using System.Collections;

//plytki dzielimy na Tile, XTile i OTile. Tile to prefab bedacy rodzicem XTile i OTile.
public class TileManager : MonoBehaviour{
    public float offset = 1.07f;
    public GameObject tile;
    
    public void InstantiateTiles(){
        for (int row = 0; row < 3; row++){
            for (int col = 0; col < 3; col++){
                Vector3 position = new Vector3(col * offset, 0.0f, row * offset);
                Instantiate(tile, position, Quaternion.identity);
            }
        }
    }

    public GameObject GetTileClickedByPlayer(){
        if (Input.GetMouseButtonDown(0)){
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;

            if (Physics.Raycast(ray, out hit, 100.0f)){
                GameObject clickedTile = hit.collider.gameObject;
                if (clickedTile.CompareTag("Tile")){
                    return clickedTile;
                }
            }
        }
        return null;
    }
    public GameObject GetTileAtPosition((int row, int col)? pos){
        float rowPos = pos.Value.row * offset;
        float colPos = pos.Value.col * offset;
        Vector3 rayOrigin = new Vector3(colPos, 5.0f, rowPos);
        Ray ray = new Ray(rayOrigin, Vector3.down);

        if (Physics.Raycast(ray, out RaycastHit hit, 100.0f)){
            GameObject clickedTile = hit.collider.gameObject;
            if (clickedTile.CompareTag("Tile")){
                return clickedTile;
            }
        }
        return null;
    }

    //usuwamy plytke przeciwnika, zostawiamy plytke gracza
    public void ModifyClickedTile(GameObject clickedTile, GameManager.Player currentPlayer){
        string playerTileTag = (currentPlayer == GameManager.Player.Human) ? "XTile" : "OTile";
        string otherTileTag = (currentPlayer == GameManager.Player.AI) ? "XTile" : "OTile";

        Transform playerTile = clickedTile.transform.Find(playerTileTag);
        Transform otherTile = clickedTile.transform.Find(otherTileTag);

        otherTile.gameObject.SetActive(false);
        Destroy(clickedTile.GetComponent<BoxCollider>());

        if(currentPlayer == GameManager.Player.Human){
            StartCoroutine(FullTileAnimation(playerTile, 1.0f));
        }
        else{
            StartCoroutine(DelayedFullTileAnimation(playerTile, 1.0f, 0.5f));
        }
    }
    private IEnumerator RotateTile(Transform playerTile, float duration){
        Quaternion initialRotation = playerTile.rotation;
        Quaternion targetRotation = initialRotation * Quaternion.Euler(0f, 0f, 180f);
        float timePassed = 0f;

        while (timePassed < duration){
            timePassed += Time.deltaTime;
            playerTile.rotation = Quaternion.Slerp(initialRotation, targetRotation, timePassed / duration);

            yield return null;
        }

        playerTile.rotation = targetRotation;
    }

    private IEnumerator ChangeTileAltitude(Transform playerTile, float duration, string direction){
        Vector3 initialPosition = playerTile.transform.position;
        Vector3 directionVector;
        float timePassed = 0f;

        if(direction == "up"){
            directionVector = new Vector3(0f, 1.0f, 0f);
        }
        else{
            directionVector = new Vector3(0f, -1.0f, 0f);
        }

        Vector3 targetPosition = playerTile.transform.position + directionVector;

        while (timePassed < duration){
            timePassed += Time.deltaTime;
            playerTile.position = Vector3.Lerp(initialPosition, targetPosition, timePassed / duration);

            yield return null;
        }

        playerTile.position = targetPosition;
    }

    private IEnumerator FullTileAnimation(Transform playerTile, float duration){
        yield return StartCoroutine(ChangeTileAltitude(playerTile, duration, "up"));
        yield return StartCoroutine(RotateTile(playerTile, duration));
        yield return StartCoroutine(ChangeTileAltitude(playerTile, duration, "down"));
    }

    private IEnumerator DelayedFullTileAnimation(Transform playerTile, float duration, float delay){
        yield return new WaitForSeconds(delay);
        yield return StartCoroutine(FullTileAnimation(playerTile, duration));
    }

    public void DestroyAllTiles(){
        GameObject[] tiles = GameObject.FindGameObjectsWithTag("Tile");

        foreach (GameObject tile in tiles){
            Destroy(tile);
        }
    }

}