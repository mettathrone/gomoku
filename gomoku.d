import std.stdio;
import std.algorithm;
import std.array;
import std.conv;
import std.string;
import std.csv;
import core.stdc.wchar_;
import std.math;
import std.system;

class Player
{
public:
    string name;
    char mark;
this(string name, char mark)
    {
        this.name = name;
        this.mark = mark; 
    }
 
    char getMark()
    {
        return mark;
    }
    string getName()
    {
        return name;
    }
 
};
 

class Board{ 
   Player currentPlayer;
    int size;
    static const int nWin = 5; 
    char[][] board;

public:
this(int n, Player beginningPlayer)
    {
        this.size = n;
this.board = new char[][](this.size, this.size);
for (int i = 0; i<this.size; i++)
            for (int k = 0; k<this.size; k++)
                this.board[i][k] = '.';

        this.currentPlayer = beginningPlayer;
    }

void printBoard()
    { 
write(" ");
for(int row = 1; row < this.size + 1; row++){
write(" ", row);
}
writeln;
foreach(numrow, row; this.board[0..$]){
write(numrow+1, " ");
foreach(numcol, col; this.board[numrow][0..$]){
write(this.board[numrow][numcol]);
write(" ");
}
write("\n");
}

    }
 
 
    bool checkPosition(int row, int col)
    {
        if (row >= this.size || row<0 || col >= this.size || col <0)
            return false;
        if (this.board[row][col] == '.')
            return true;
        else
            return false;
    }
 
    bool updateBoard(int r, int c)
    {
        if (checkPosition(r, c))
            this.board[r][c] = this.currentPlayer.getMark();
        else
            return false;
        return true;
    }
 
 
    bool checkWinner()
    {
        int playerCount, r, c, x, y;
        // горизонталь
        for (r = 0; r < this.size; r++)
        {
            playerCount = 0;
            for (c = 0; c < this.size; c++)
            {
                if (this.board[r][c] == this.currentPlayer.getMark())
                    playerCount += 1; 
                else
                    playerCount = 0;

                if (playerCount >= nWin)
                    return true;
            }
}
 
        // вертикаль
        for (c = 0; c<this.size; c++)
        {
            playerCount = 0;
            for (r = 0; r < this.size; r++)
             {
                if (this.board[r][c] == this.currentPlayer.getMark())
                    playerCount += 1; 
                else
                    playerCount = 0;

                if (playerCount >= nWin)
                    return true;
            }
        }
 
        //диагональ 1
        for (y = this.size, x = 0; y>0; x++, y--)
        {
            playerCount = 0;
            for (r = y, c = 0; r<x; r++, c++)
            {
                if (this.board[r][c] == this.currentPlayer.getMark())
                    playerCount += 1; 
                else
                    playerCount = 0;

                if (playerCount >= nWin)
                    return true;
            }
        }
        // диагональ 2
        for (x = this.size, y = 0; x>0; x--, y++)
        {
            playerCount = 0;
            for (r = 0, c = y; c<x; r++, c++)
             {
                if (this.board[r][c] == this.currentPlayer.getMark())
                    playerCount += 1; 
                else
                    playerCount = 0;

                if (playerCount >= nWin)
                    return true;
            }
        }
        // If nobody won
        return false;
 
    }
 
 
 
};
 
int main()
{
    int row, column;
    int b;
    write("Enter size of board: ");
    readf("%d", &b);
    writeln;
    bool control = true;
    bool winner = false;
    Player human = new Player("PLAYER1", 'X');
    Player computer = new Player("PLAYER2", 'O');
    Board board =  new Board(b, human);
 

    getchar();
    //END WELCOME PAGE
 
    do
    {
        do
        {
            board.printBoard();
        writeln;
            write("Player:  ", board.currentPlayer.getName()); 
        write("\n");
            write("Row:     ");
            readf("%s\n", &row);
            write("Column:  ");
            readf("%s\n", &column);
//return 0;
            control = board.updateBoard(row - 1, column - 1);
        } while (!control);
        winner = board.checkWinner();
        if (!winner)
        {
            if (board.currentPlayer == human)
                board.currentPlayer = computer;
            else
                board.currentPlayer = human;
        }
    } while (!winner);
    board.printBoard();
    write("\n\n GAME OVER! The winner is: ", board.currentPlayer.getName());
    readf("%s\n", &row);
return 0;
}