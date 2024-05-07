#include "usercommunication.hpp"


std::string ai::SelectAiMove(gamestate::GameState& state) {
	srand(time(NULL));
	int randomMoveIndex = rand() % state.taken_fields.size();
	auto it = state.taken_fields.begin();
	std::advance(it, randomMoveIndex);
	std::string randomMove = it->first;

	while (!user_comm::isValid(state, randomMove, false)) {
		randomMoveIndex = rand() % 9;
		it = state.taken_fields.begin();
		std::advance(it, randomMoveIndex);
		randomMove = it->first;
	}
	return randomMove;
}

