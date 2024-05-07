#include "gamestate.hpp"

using namespace gamestate;

GameState::GameState() {
	taken_fields = {
			{"1A", " "},
			{"1B", " "},
			{"1C", " "},
			{"2A", " "},
			{"2B", " "},
			{"2C", " "},
			{"3A", " "},
			{"3B", " "},
			{"3C", " "},
	};
}


bool GameState::isWon() {
	if ((taken_fields["1A"] == taken_fields["1B"] && taken_fields["1B"] == taken_fields["1C"] && taken_fields["1A"] != " ") ||
		(taken_fields["2A"] == taken_fields["2B"] && taken_fields["2B"] == taken_fields["2C"] && taken_fields["2A"] != " ") ||
		(taken_fields["3A"] == taken_fields["3B"] && taken_fields["3B"] == taken_fields["3C"] && taken_fields["3A"] != " ")) {
		return true;
	}

	if ((taken_fields["1A"] == taken_fields["2A"] && taken_fields["2A"] == taken_fields["3A"] && taken_fields["1A"] != " ") ||
		(taken_fields["1B"] == taken_fields["2B"] && taken_fields["2B"] == taken_fields["3B"] && taken_fields["1B"] != " ") ||
		(taken_fields["1C"] == taken_fields["2C"] && taken_fields["2C"] == taken_fields["3C"] && taken_fields["1C"] != " ")) {
		return true;
	}

	if ((taken_fields["1A"] == taken_fields["2B"] && taken_fields["2B"] == taken_fields["3C"] && taken_fields["1A"] != " ") ||
		(taken_fields["1C"] == taken_fields["2B"] && taken_fields["2B"] == taken_fields["3A"] && taken_fields["1C"] != " ")) {
		return true;
	}

	return false;
}


bool GameState::isFull(){
	bool full = true;
	for (auto const& x : taken_fields){
		if (x.second == " "){
			full = false;
		}
	}
	return full;

}