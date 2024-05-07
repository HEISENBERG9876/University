#define _CRT_SECURE_NO_WARNINGS

#include <string>
#include <vector>
#include <cmath>
#include <iostream>
#include <limits>


class Coin {
public:
    int value;
    int weight;

    Coin(int val = 0, int w = 0) {
        this->value = val;
        this->weight = w;
    }
};


int scanSingleNumber() {
    int n;
    (void)scanf("%d", &n);
    return n;
}


std::vector<Coin> createCoinVector(int n) {
    std::vector<Coin> coinVector(n);
    coinVector.reserve(n);

    for (int i = 0; i < n; i++) {
        int faceValue  = scanSingleNumber();
        int coinWeight = scanSingleNumber();
        coinVector[i]  = Coin(faceValue, coinWeight);
    }

    return coinVector;
}


void printCoinsUsed(std::vector<Coin>& coinVector, std::vector<int>& coinsUsed, int achievedSumOfCoinWeights, int numberOfCoins) {
    std::vector<int> coinNumbers(numberOfCoins, 0);
    while (achievedSumOfCoinWeights > 0) {
        int coinUsed = coinsUsed[achievedSumOfCoinWeights];
        int coinWeight = coinVector[coinUsed].weight;
        coinNumbers[coinUsed] += 1;
        achievedSumOfCoinWeights -= coinWeight;
    }

    for (int i = 0; i < numberOfCoins; i++) {
        printf("%d", coinNumbers[i]);
        if (i != numberOfCoins - 1) {
            printf(" ");
        }
    }

    printf("\n");

}


void solveMaxCoinSum(std::vector<Coin>& coinVector, int desiredSumOfCoinWeights, int numberOfCoins) {
    int unachievableValue = -1;
    std::vector<int> previousDPVector(desiredSumOfCoinWeights + 1, unachievableValue); //przechowuje najwieksze osiagniete wartosci dla danych kombinacji moneta + waga. -1 dla nieprzypisanych/nieosiagalnych wag.
    std::vector<int> currentDPVector(desiredSumOfCoinWeights + 1, unachievableValue);
    std::vector<int> weightsUsed(desiredSumOfCoinWeights + 1, 0); //Sumuje wagi
    std::vector<int> coinsUsed(desiredSumOfCoinWeights + 1, -1);//indeks 0 niepotrzebny, ale latwiej bedzie operowac na tym. -1 to nieuzyta moneta. Zawiera monety potrzebne do osiagniecia danej wagi.
    currentDPVector[0] = 0;

    for (int currentCoinIndex = 0; currentCoinIndex < numberOfCoins; currentCoinIndex++) {
        for (int currentWeight = 1; currentWeight < desiredSumOfCoinWeights + 1; currentWeight++) {

            Coin coin = coinVector[currentCoinIndex];
            int coinValue = coin.value;
            int coinWeight = coin.weight;

            if (currentWeight - coinWeight >= 0 && currentDPVector[currentWeight - coinWeight] > unachievableValue) {
                if (currentDPVector[currentWeight - coinWeight] + coinValue > previousDPVector[currentWeight]) {
                    currentDPVector[currentWeight] = currentDPVector[currentWeight - coinWeight] + coinValue;
                    weightsUsed[currentWeight] = weightsUsed[currentWeight - coinWeight] + coinWeight;
                    coinsUsed[currentWeight] = currentCoinIndex;
                }
                else {
                    currentDPVector[currentWeight] = previousDPVector[currentWeight];
                }
            }
            else {
                currentDPVector[currentWeight] = previousDPVector[currentWeight];
            }
        }

        previousDPVector = currentDPVector;
        std::fill(currentDPVector.begin(), currentDPVector.end(), -1);
        currentDPVector[0] = 0;
    }

    if (weightsUsed[desiredSumOfCoinWeights] == desiredSumOfCoinWeights) {
        printf("%d\n", previousDPVector[desiredSumOfCoinWeights]);
        printCoinsUsed(coinVector, coinsUsed, desiredSumOfCoinWeights, numberOfCoins);
    }
}


void solveMinCoinSum(std::vector<Coin>& coinVector, int desiredSumOfCoinWeights, int numberOfCoins) {
    int unachievableValue = 2000000;
    std::vector<int> previousDPVector(desiredSumOfCoinWeights + 1, unachievableValue);
    std::vector<int> currentDPVector(desiredSumOfCoinWeights + 1, unachievableValue);
    std::vector<int> weightsUsed(desiredSumOfCoinWeights + 1, 0);
    std::vector<int> coinsUsed(desiredSumOfCoinWeights + 1, -1);
    currentDPVector[0] = 0;

    for (int currentCoinIndex = 0; currentCoinIndex < numberOfCoins; currentCoinIndex++) {
        for (int currentWeight = 1; currentWeight < desiredSumOfCoinWeights + 1; currentWeight++) {

            Coin coin = coinVector[currentCoinIndex];
            int coinValue = coin.value;
            int coinWeight = coin.weight;

            if (currentWeight - coinWeight >= 0 && currentDPVector[currentWeight - coinWeight] < unachievableValue) {
                if (currentDPVector[currentWeight - coinWeight] + coinValue < previousDPVector[currentWeight]) {
                    currentDPVector[currentWeight] = currentDPVector[currentWeight - coinWeight] + coinValue;
                    weightsUsed[currentWeight] = weightsUsed[currentWeight - coinWeight] + coinWeight;
                    coinsUsed[currentWeight] = currentCoinIndex;
                }
                else {
                    currentDPVector[currentWeight] = previousDPVector[currentWeight];
                }
            }
            else {
                currentDPVector[currentWeight] = previousDPVector[currentWeight];
            }
        }

        previousDPVector = currentDPVector;
        std::fill(currentDPVector.begin(), currentDPVector.end(), unachievableValue);
        currentDPVector[0] = 0;
    }

    if (weightsUsed[desiredSumOfCoinWeights] != desiredSumOfCoinWeights) {
        printf("NIE\n");
    }
    else {
        printf("TAK\n");
        printf("%d\n", previousDPVector[desiredSumOfCoinWeights]);
        printCoinsUsed(coinVector, coinsUsed, desiredSumOfCoinWeights, numberOfCoins);
    }
}


int main() {
    int desiredSumOfCoinWeights = scanSingleNumber();
    int numberOfCoins = scanSingleNumber();

    std::vector<Coin> coinVector = createCoinVector(numberOfCoins);

    solveMinCoinSum(coinVector, desiredSumOfCoinWeights, numberOfCoins);
    solveMaxCoinSum(coinVector, desiredSumOfCoinWeights, numberOfCoins);

    return 0;
}