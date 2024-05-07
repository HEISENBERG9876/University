#include "gamestate.hpp"
#include "botAI.hpp"
#include "usercommunication.hpp"
using namespace std;
using namespace gamestate;


void newGame() {
	GameState board = GameState();

	while (!board.isWon() && !board.isFull()) {
		user_comm::move(board);
		user_comm::displayGameState(board);
	}
}

int main() {
	newGame();
	return 1;
}
