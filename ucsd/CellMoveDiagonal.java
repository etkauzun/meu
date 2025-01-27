/**
 * Project Assignment 7: CellMoveDiagonal.java
 * Etka Uzun
 * A15956274
 * muzun@ucsd.edu
 * 
 * Sources: Zybooks, Lectures, Tutors
 * This file extends Cell class. It is for 
 * a stationary cell. It returns the string 
 * representation of the cell and checks 
 * to see if the cell should initialize 
 * apoptosis. 
 */

import java.util.List; 
import java.util.ArrayList;

/**
 * This class extends CellMoveUp class and has
 * four methods, two of which are ctors and
 * the rest being overriding methods.
 * Instance Variable
 * orientedRight - if the cell is oriented right
 * diagonalMoves - counts the number of moves
 */
public class CellMoveDiagonal extends CellMoveUp{
    /*Instance Variables*/
    public boolean orientedRight;
    public int diagonalMoves;
    /**
     * This method is a constructor to initialize 
     * the instance variables of the Cell class.
     * @param currRow stores the row value of cell
     * @param currCol stores the column value of cell
     * @param mass stores the mass of the cell
     */
    public CellMoveDiagonal(int currRow, int currCol, int mass){
        super(currRow, currCol, mass); //calls the Cell
        this.orientedRight = true;
        this.diagonalMoves = 0;
    }
    /**
     * This method is a copy ctor to initialize 
     * the instance variables of the Cell class
     * @param otherCellMoveDiagonal is an object 
     * passed in as an argument
     */
    public CellMoveDiagonal(CellMoveDiagonal otherCellMoveDiagonal){
        super(otherCellMoveDiagonal); 
    }
    /**
     * This method overrides and returns a string
     * representation of the current class.
     * @return string representation
     */
    public String toString(){
        if(orientedRight){
            return "/";
        }
        else{return "\\";} 
    }
    /**
     * This method overrides and checks the size of
     * neighbors to see if the cell should initialize 
     * apoptosis.
     * @param - a list of Cell type that has the
     * information of other cells
     * @return true for initiliazing 
     */
    public boolean checkApoptosis(List<Cell> neighbors){
        int countCells = neighbors.size();
        if(countCells > 3){
            return true; 
        }
        else {return false;}
    } 

    /**
     * This method returns the deep copy of the
     * calling object.
     * @return is the deep copy
     */
    public Cell newCellCopy(){
        Cell deepCopied = new CellMoveDiagonal(this);
        return deepCopied;
    }

    /**
     * This method returns where the cells 
     * will move to.
     * @return the new position
     */
    public int[] getMove(){
        if(orientedRight){
            int[] newPosition = new int[] {currRow - 1, currCol + 1};
            diagonalMoves++; 
            if(diagonalMoves % 4 == 0){
                orientedRight = !orientedRight;
            }
            return newPosition; 
        }
        else{
            int[] newPosition = new int[] {currRow - 1, currCol - 1};
            diagonalMoves++; 
            if(diagonalMoves % 4 == 0){
                orientedRight = !orientedRight;
            }
            return newPosition; 
        }
    }
}    