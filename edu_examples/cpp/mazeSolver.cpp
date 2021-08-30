/*
This is the driver file.  It implements the functions
to recursive call a function to find the solution to a given maze,
printing out the results and cell tested as it goes.
*/

#include "maze.h"
#include <iostream>
#include <cstdlib>

int main()
{
    srand(1000);
    std::ifstream inFile;
    inFile.open("maze.txt");

    bool isFound = false;

    int startX, startY;

    Maze secMaze(inFile);
    Coordinate realOne(secMaze.GetStartPt());

    secMaze.Print();

    std::cout << "Start position: " << realOne.x << "," << realOne.y << "\n";

    startX = (int) realOne.x;
    startY = (int) realOne.y;

    secMaze.FindExit(startX, startY, isFound);

    if (isFound==false)
        std::cout << "No solution\n";

    inFile.close();

    return 0;
}
