#pragma once
#include <iostream>
#include <vector>
#include <utility>
#include <map>
#include <string>
namespace gamestate {

	//przechowuje stan gry
	class GameState {
	public:
		std::map<std::string, std::string> taken_fields;

		GameState();
		bool isFull();
		bool isWon();
	};

}