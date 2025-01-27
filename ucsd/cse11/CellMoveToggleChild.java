/**
 * Project Assignment 7: CellMoveToggleChild.java
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
 * This class extends CellMoveToggle class and has
 * three methods, two of which are ctors and
 * the rest being overriding methods.
 * Instance Variable
 * numAlive - numner of types the cell is alive
 */
public class CellMoveToggleChild extends CellMoveToggle{
    /*Instance Variable*/
    public static int numAlive;
    /**
     * This method is a constructor to initialize 
     * the instance variables of the Cell class.
     * @param currRow stores the row value of cell
     * @param currCol stores the column value of cell
     * @param mass stores the mass of the cell
     */
    public CellMoveToggleChild(int currRow, int currCol, int mass){
        super(currRow, currCol, mass); //calls the Cell
        numAlive++;//increment numAlive
    }
    /**
     * This method is a copy ctor to initialize 
     * the instance variables of the Cell class
     * @param otherCellMoveToggleChild is an object 
     * passed in as an argument
     */
    public CellMoveToggleChild(CellMoveToggleChild otherCellMoveToggleChild){
        super(otherCellMoveToggleChild);
        numAlive++;
    }
    /**
     * This method calls apoptosis method from
     * Cell and decrements numAlive.
     */
    public void apoptosis(){
        super.apoptosis();
        numAlive--;
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
        if(super.checkApoptosis(neighbors) && numAlive < 10){ 
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
        Cell deepCopied = new CellMoveToggleChild(this);
        return deepCopied;
    }

    /* 
     * This method returns where the cells 
     * will move to.
     * @return the new position  
    public int[] getMove(){
        return super.getMove(); 
    }
    */
}