/*
This is the implementation file.  If defines header functions
to recursive call a function to find the solution to a given maze,
printing out the results and cell tested as it goes.
*/

#include "maze.h"
#include <cstdlib>
#include <iostream>

// Maze class constructor which takes a file that specifies row and col
// size and uses a nested for loop to populate the maze
Maze::Maze(std::ifstream& os)
{
    char tempRows, tempCols;

    os >> tempRows;
    os >> tempCols;
    MaxRows = tempRows-48;
    MaxCols = tempCols-48;
    // Nested For Loop to create the maze array and populate with Xs
    // on the border and file-fed maze coords inside
    for (int i=0; i<MaxRows+2; i++)
    {
        for (int j=0; j<MaxCols+2; j++)
        {
            if (i==0)
               maze[0][j]='X';
            else if (j==0)
               maze[i][0]='X';
            else if (i==MaxRows+1)
                maze[MaxRows+1][j]='X';
            else if (j==MaxCols+1)
                maze[i][MaxCols+1]='X';
            else
                os >> maze[i][j];
        }
    }

}

// Prints the maze in current form
void Maze::Print()
{
    std::cout << "Maze state: \n";

    for (int i=1; i<=MaxRows; i++)
    {
        for (int j=1; j<=MaxCols; j++)
        {
            std::cout << maze[i][j] << " ";

        }

        std::cout << std::endl;
    }
}

// Populates the coords vector, derives a random number (rand % vec.size)
// and returns the randomly selected coords to establish the maze's starting point
Coordinate Maze::GetStartPt()
{
    //for loop to populate the vector
    for (int i=1; i<=MaxRows; i++)
    {
        for (int j=0; j<=MaxCols; j++)
        {
             if (maze[i][j]=='O')
             {
                 Coordinate temp(i,j);
                 coords.push_back(temp);
             }
        }
    }

    return coords[rand() % coords.size()];
}

// Recursively calls itself (going E,S,W,N) until either the
// exit is found or it's determined no exit is available.
void Maze::FindExit(int x, int y, bool& B)
{
     if ( maze[x][y]=='E' && B==true)
     {
            std::cout << "Trying " << x << "," << y << "\nFound exit!\n";
     }

     else
     {
        if (maze[x][y]=='O' && B==false)
        {
             std::cout << "Trying " << x << "," << y << "\n";
             maze[x][y] = '*';
             Print();

            //Go East
             FindExit(x,y+1,B);
            // Go South
             FindExit(x+1,y,B);
            // Go West
             FindExit(x,y-1,B);
            // Go North
             FindExit(x-1,y,B);
        }

        else if (maze[x][y] == 'E' && B==false)
        {
            B = true;
            FindExit(x,y,B);
        }
    }


}
