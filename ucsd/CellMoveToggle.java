/**
 * Project Assignment 7: CellMoveToggle.java
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
import java.util.Arrays; //FIXME DELETE


/**
 * This class extends CellMoveUp class and has
 * four methods, two of which are ctors and
 * the rest being overriding methods.
 * Instance Variable
 * toggled - if the cell is toggled
 */

public class CellMoveToggle extends CellMoveUp{ 

    /* Instance Variable */
    public boolean toggled;
    /**
     * This method is a constructor to initialize 
     * the instance variables of the Cell class.
     * @param currRow stores the row value of cell
     * @param currCol stores the column value of cell
     * @param mass stores the mass of the cell
     */
    public CellMoveToggle(int currRow, int currCol, int mass){
        super(currRow, currCol, mass); //calls the Cell
        this.toggled = true;
    }
    /**
     * This method is a copy ctor to initialize 
     * the instance variables of the Cell class
     * @param otherCellMoveToggle is an object 
     * passed in as an argument
     */
    public CellMoveToggle(CellMoveToggle otherCellMoveToggle){
        super(otherCellMoveToggle);
        this.toggled = otherCellMoveToggle.toggled; 
    }
    /**
     * This method overrides and returns a string
     * representation of the current class.
     * @return string representation
     */
    public String toString(){
        if(toggled){
            return "T";
        }
        else{return "t";}
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
        if(countCells < 2 || countCells > 5){
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
        Cell deepCopied = new CellMoveToggle(this);
        return deepCopied;
    }

    /**
     * This method returns where the cells 
     * will move to.
     * @return the new position
     */
    public int[] getMove(){
        if(toggled){
            int[] newPosition = new int[] {currRow - 1, currCol};
            this.toggled = !(toggled);
            return newPosition;
        }
        else{
            this.toggled = !(toggled);
            int[] stationary = new int[] {currRow, currCol};
            return stationary;
        }
    }
}