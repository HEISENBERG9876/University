#pragma once
#include "gamestate.hpp"
#include "botAI.hpp"

using namespace gamestate;
using namespace ai;

namespace user_comm {
	bool isValid(gamestate::GameState& state, std::string& playerInput, bool isPlayerMove);
	void move(gamestate::GameState& state);
	void displayGameState(gamestate::GameState& state);
}
