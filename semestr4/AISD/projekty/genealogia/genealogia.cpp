#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <algorithm>
#include <stack>


class ChildNode {
public:
    int nodeNumber;
    int motherNumber;

    ChildNode(int nNumber = 0, int mNumber = 0) {
        this->nodeNumber = nNumber;
        this->motherNumber = mNumber;
    }

    static bool isVisited(int nodeIndex, std::pair<int, int>*& timesArray) {
        return (timesArray[nodeIndex].first > 0);
    }
}


bool compareByMotherNumber(const ChildNode& a, const ChildNode& b) {
    return a.motherNumber < b.motherNumber;
}


int findChildIndexBinarySearch(ChildNode*& childArray, int left, int right, int motherNum) {
    while (left <= right) {
        int mid = left + (right - left) / 2;

        if (childArray[mid].motherNumber == motherNum) {
            return mid;
        }
        else if (childArray[mid].motherNumber < motherNum) {
            left = mid + 1;
        }
        else {
            right = mid - 1;
        }
    }

    return -1;
}


std::pair<int, int> findFirstAndLastChildIndex(ChildNode*& childArray, int n, int motherNum) {
    int leftmostChildIndex = findChildIndexBinarySearch(childArray, 0, n - 2, motherNum);
    int rightmostChildIndex = leftmostChildIndex;

    if (leftmostChildIndex == -1) {
        return std::make_pair(-1, -1);
    }

    while (leftmostChildIndex > 0) {
        if (childArray[leftmostChildIndex - 1].motherNumber == motherNum) {
            leftmostChildIndex--;
        }
        else {
            break;
        }
    }

    while (rightmostChildIndex < n - 2) {
        if (childArray[rightmostChildIndex + 1].motherNumber == motherNum) {
            rightmostChildIndex++;
        }
        else {
            break;
        }
    }

    return std::make_pair(leftmostChildIndex, rightmostChildIndex);
}


int scanSingleNumber() {
    int n;
    scanf("%d", &n);
    return n;
}


ChildNode* createChildArray(int n) {
    ChildNode* childArray = new ChildNode[n - 1];

    for (int i = 0; i < n - 1; i++) {
        int k = scanSingleNumber();
        childArray[i] = ChildNode(i + 2, k);
    }

    return childArray;
}


void assignTimesDFS(ChildNode*& childArray, std::pair<int, int>*& timesArray, int n) {
    int counter = 1;
    std::stack<int> nodeStack;
    std::pair<int, int> childrenOfRootIndexes = findFirstAndLastChildIndex(childArray, n, 1);

    for (int i = childrenOfRootIndexes.first; i <= childrenOfRootIndexes.second; i++) {
        nodeStack.push(childArray[i].nodeNumber);
    }

    while (!nodeStack.empty()) {
        int currentNodeNum = nodeStack.top();

        if (!ChildNode::isVisited(currentNodeNum - 2, timesArray)) {
            counter++;
            timesArray[currentNodeNum - 2].first = counter;

            std::pair<int, int> childRange = findFirstAndLastChildIndex(childArray, n, currentNodeNum);
            if (childRange.first != -1) {
                for (int i = childRange.first; i <= childRange.second; i++) {
                    nodeStack.push(childArray[i].nodeNumber);
                }
            }
        }
        else {
            counter++;
            timesArray[currentNodeNum - 2].second = counter;
            nodeStack.pop();
        }
    }
}


bool isAncestor(int a, int b, std::pair<int, int>*& timesArray) {
    if (a == b) {
        return false;
    }
    if (a == 1) {
        return true;
    }
    if (b == 1) {
        return false;
    }
    a = a - 2;
    b = b - 2;

    int x1in = timesArray[a].first;
    int x2in = timesArray[b].first;
    int x1out = timesArray[a].second;
    int x2out = timesArray[b].second;

    if (x1in < x2in && x1out > x2out) {
        return true;
    }
    return false;
}


void answerQueries(int q, std::pair<int, int>*& timesArray) {
    for (int i = 0; i < q; i++) {
        int a = scanSingleNumber();
        int b = scanSingleNumber();
        if (isAncestor(a, b, timesArray)) {
            printf("TAK\n");
        }
        else {
            printf("NIE\n");
        }
    }
}


int main() {
    int n = scanSingleNumber();
    int q = scanSingleNumber();

    ChildNode* childArray = createChildArray(n);
    std::sort(childArray, childArray + n - 1, compareByMotherNumber);

    std::pair<int, int>* timesArray = new std::pair<int, int>[n - 1];

    assignTimesDFS(childArray, timesArray, n);
    answerQueries(q, timesArray);

    delete[] childArray;
    delete[] timesArray;

    return 0;
}