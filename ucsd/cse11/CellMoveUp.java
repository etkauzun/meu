/**
 * Project Assignment 7: CellMoveUp.java
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
 * This class extends Cell class and has
 * four methods, two of which are ctors and
 * the rest being overriding methods. 
 */
public class CellMoveUp extends Cell implements Movable{
    /**
     * This method is a constructor to initialize 
     * the instance variables of the Cell class.
     * @param currRow stores the row value of cell
     * @param currCol stores the column value of cell
     * @param mass stores the mass of the cell
     */
    public CellMoveUp(int currRow, int currCol, int mass){
        super(currRow, currCol, mass); //calls the Cell
    }
    /**
     * This method is a copy ctor to initialize 
     * the instance variables of the Cell class
     * @param otherCellMoveUp is an object 
     * passed in as an argument
     */
    public CellMoveUp(CellMoveUp otherCellMoveUp){
        super(otherCellMoveUp); 
    }
    /**
     * This method overrides and returns a string
     * representation of the current class.
     * @return string representation
     */
    public String toString(){
        return "^";
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
        if(countCells == 4){
            return false;
        }
        else {return true;}
    }    

    /**
     * This method returns the deep copy of the
     * calling object.
     * @return is the deep copy
     */
    public Cell newCellCopy(){
        Cell deepCopied = new CellMoveUp(this);
        return deepCopied;
    }

    /**
     * This method returns where the cells 
     * will move to.
     * @return the new position
     */
    public int[] getMove(){
        int [] newPosition = new int [] {currRow - 1, currCol};
        return newPosition;
    }
}