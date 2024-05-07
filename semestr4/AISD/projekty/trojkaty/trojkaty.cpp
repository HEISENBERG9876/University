#define _CRT_SECURE_NO_WARNINGS

#include <algorithm>
#include <string>
#include <limits>
#include <vector>
#include <cmath>
#include <iostream>

double inf = std::numeric_limits<double>::infinity();
enum class SortingCoord { X, Y };

class Point {
public:
    int x;
    int y;

    Point(int X = 0, int Y = 0) {
        this->x = X;
        this->y = Y;
    }

    bool operator!=(const Point& other) const {
        return (x != other.x) || (y != other.y);
    }

    std::string to_string() const {
        return std::to_string(x) + " " + std::to_string(y);
    }
};

class TriangleInfo {
public:
    Point p1;
    Point p2;
    Point p3;
    double perimeter;

    TriangleInfo(const Point& point1 = Point(), const Point& point2 = Point(), const Point& point3 = Point(), double prmtr = inf) {
        this->p1 = point1;
        this->p2 = point2;
        this->p3 = point3;
        this->perimeter = prmtr;
    }
};

bool compareByX(const Point& p1, const Point& p2) {
    if (p1.x != p2.x) {
        return p1.x < p2.x;
    }
    else {
        return p1.y < p2.y;
    }
}

bool compareByY(const Point& p1, const Point& p2) {
    if (p1.y != p2.y) {
        return p1.y < p2.y;
    }
    else {
        return p1.x < p2.x;
    }
}

int scanSingleNumber() {
    int n;
    (void)scanf("%d", &n);
    return n;
}

std::vector<Point> createPointVector(int n) {
    std::vector<Point> pointVector(n);
    pointVector.reserve(n);

    for (int i = 0; i < n; i++) {
        int x = scanSingleNumber();
        int y = scanSingleNumber();
        pointVector[i] = Point(x, y);
    }

    return pointVector;
}

std::vector<Point> createSortedVector(const std::vector<Point>& pointVector, SortingCoord sortingCoord) {
    std::vector<Point> copiedVector = pointVector;

    if (sortingCoord == SortingCoord::X) {
        std::sort(copiedVector.begin(), copiedVector.end(), compareByX);
    }
    else {
        std::sort(copiedVector.begin(), copiedVector.end(), compareByY);
    }

    return copiedVector;
}

double calculateDistance(const Point& p1, const Point& p2) {
    return sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2));
}

double calculatePerimeter(Point& p1, Point& p2, Point& p3) {
    return calculateDistance(p1, p2) + calculateDistance(p1, p3) + calculateDistance(p2, p3);
}

TriangleInfo bruteForceClosestPoints(const std::vector<Point>& sortedByXVector, int sortedByXStartIndex, int sortedByXEndIndex) {
    TriangleInfo smallestTriangleInfo;

    for (int i = sortedByXStartIndex; i < sortedByXEndIndex - 2; i++) {
        for (int j = i + 1; j < sortedByXEndIndex - 1; j++) {
            for (int k = j + 1; k < sortedByXEndIndex; k++) {
                Point p1 = sortedByXVector[i];
                Point p2 = sortedByXVector[j];
                Point p3 = sortedByXVector[k];
                double perimeter = calculatePerimeter(p1, p2, p3);

                if (perimeter < smallestTriangleInfo.perimeter) {
                    smallestTriangleInfo = TriangleInfo(p1, p2, p3, perimeter);
                }
        }
        }
    }
    return smallestTriangleInfo;
}

TriangleInfo smallestPerimeterTriangleFinder(std::vector<Point>& sortedByX, std::vector<Point>& sortedByY, int sortedByXStartIndex, int sortedByXEndIndex) {
    int currentSortedByXSize = sortedByXEndIndex - sortedByXStartIndex + 1;
    if (currentSortedByXSize <= 20) {
        return bruteForceClosestPoints(sortedByX, sortedByXStartIndex, sortedByXEndIndex);
    }

    int sortedByXLeftSize = currentSortedByXSize / 2;

    int middleIndex = (sortedByXStartIndex + sortedByXEndIndex) / 2;
    Point middlePoint = sortedByX[middleIndex];

    int sortedByYsize = (int)sortedByY.size();
    std::vector<Point> sortedByYLeft;
    std::vector<Point> sortedByYRight;
    sortedByYLeft.reserve(sortedByYsize);
    sortedByYRight.reserve(sortedByYsize);

    for (int i = 0; i < sortedByYsize; i++) {
        if (sortedByY[i].x <= middlePoint.x) {
            sortedByYLeft.push_back(sortedByY[i]);
        }
        else {
            sortedByYRight.push_back(sortedByY[i]);
        }
    }

    TriangleInfo leftResult = smallestPerimeterTriangleFinder(sortedByX, sortedByYLeft, sortedByXStartIndex, sortedByXStartIndex + sortedByXLeftSize);
    TriangleInfo rightResult = smallestPerimeterTriangleFinder(sortedByX, sortedByYRight, sortedByXStartIndex + sortedByXLeftSize, sortedByXEndIndex);
    TriangleInfo minResult = (leftResult.perimeter < rightResult.perimeter) ? leftResult : rightResult;

    std::vector<Point> strip;
    strip.reserve(sortedByYsize);

    for (int i = 0; i < (int)sortedByY.size(); i++) {
        if (abs(sortedByY[i].x - middlePoint.x) < minResult.perimeter / 2) {
            strip.push_back(sortedByY[i]);
        }
    }

    int stripSize = (int)strip.size();
    for (int i = 0; i < stripSize - 2; i++) {
        int maxIndex1 = std::min(stripSize - 1, i + 15);
        for (int j = i + 1; j < maxIndex1; j++) {
            int maxIndex2 = std::min(stripSize, i + 15);
            for (int k = j + 1; k < maxIndex2; k++) {
                double perimeter = calculatePerimeter(strip[i], strip[j], strip[k]);
                if (perimeter < minResult.perimeter) {
                    minResult = TriangleInfo(strip[i], strip[j], strip[k], perimeter);
                }
            }
        }
    }

    return minResult;
}


int main() {
    int pointVectorSize = scanSingleNumber();

    std::vector<Point> pointVector = createPointVector(pointVectorSize);
    std::sort(pointVector.begin(), pointVector.end(), compareByX);
    std::vector<Point> sortedByYVector = createSortedVector(pointVector, SortingCoord::Y);

    TriangleInfo resultTriangle = smallestPerimeterTriangleFinder(pointVector, sortedByYVector, 0, pointVectorSize - 1);

    printf("%s\n", resultTriangle.p1.to_string().c_str());
    printf("%s\n", resultTriangle.p2.to_string().c_str());
    printf("%s\n", resultTriangle.p3.to_string().c_str());

    return 0;
}
