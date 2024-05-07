#include "usercommunication.hpp"

//converts a1, A1, 1a inputs to form 1A.
std::string Convert(std::string& input){
	if(isdigit(input[1])){
		char temp = input[0];
		input[0] = input[1];
		input[1] = temp;
	}
	input[0] = std::toupper(input[0]);
	input[1] = std::toupper(input[1]);
	return input;
}

bool user_comm::isValid(gamestate::GameState& state, std::string& input, bool isPlayerMove) {
	try {
		if (input.length() != 2) {
			throw std::invalid_argument("Input length must be equal to 2. Form 1A, 2C etc.");
		}

		input = Convert(input);
		int row = std::stoi(input.substr(0, 1));
		std::string col = input.substr(1, 1);

		if (row != 1 && row != 2 && row != 3) {
			throw std::invalid_argument("Row doesn't exist");
		}

		else if (col != "A" && col != "B" && col != "C") {
			throw std::invalid_argument("Column doesn't exist");
		}

		else {
			auto it = state.taken_fields.find(input);
			if (it == state.taken_fields.end() || it->second != " ") {
				if(isPlayerMove){
					throw std::invalid_argument("Field is taken");
				}
				else{
					return false;
				}
			}
		}
	}

	catch (const std::invalid_argument& e) {
		std::cerr << "Invalid input: " << e.what() << std::endl;
		return false;
	}
	
	return true;
}


void user_comm::move(gamestate::GameState& state) {
	std::cout << "Player move: ";

	std::string movePos;
	std::cin >> movePos;

	if (isValid(state, movePos, true)) {
		movePos = Convert(movePos);
		//player move
		state.taken_fields[movePos] = "X";

		if (state.isWon()){
			std::cout << std::endl  << "PLAYER WON" << std::endl;
			return;
		}

		if (state.isFull()){
			std::cout << std::endl << "REMIS" << std::endl;
			return;
		}

		//AI move
		std::string aiPos = ai::SelectAiMove(state);
		state.taken_fields[aiPos] = "O";

		if (state.isWon()){
			std::cout << std::endl;
			std::cout << std::endl << "AI WON" << std::endl;
			return;
		}

		if (state.isFull()){
			std::cout << std::endl;
			std::cout << std::endl << "REMIS" << std::endl;
			return;
		}
	}
	else {
		std::cout << "Select new move" << std::endl;
		move(state);
	}
}


void user_comm::displayGameState(gamestate::GameState& state) {
	std::cout << std::endl;
	std::cout << "  A B C" << std::endl;
	std::cout << "1 " << state.taken_fields["1A"] << " " << state.taken_fields["1B"] << " " << state.taken_fields["1C"] << std::endl;
	std::cout << "2 " << state.taken_fields["2A"] << " " << state.taken_fields["2B"] << " " << state.taken_fields["2C"] << std::endl;
	std::cout << "3 " << state.taken_fields["3A"] << " " << state.taken_fields["3B"] << " " << state.taken_fields["3C"] << std::endl;
	std::cout << std::endl;
}

