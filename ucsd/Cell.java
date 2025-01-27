/**
 * Project Assignment 8: Cell.java
 * Etka Uzun
 * A15956274
 * muzun@ucsd.edu
 * 
 * Sources: Zybooks, Lectures
 * This file is an abstract class that will
 * extend to six subclasses. It has three instance
 * variables and seven methods. 
 */

import java.util.List; 
import java.util.ArrayList;
 
/**
  * This class is an abstract class that stores
  * three instance variables and seven methods.
  * It initializes the instance variables and
  * copies them. 
  *
  * Instance Variables
  * currRow - stores the row value of cell
  * currCol - stores the column value of cell
  * mass - stores the mass of the cell
  */
  public abstract class Cell implements Comparable<Cell>{

    /* Instance Variables */
    public int currRow; 
    public int currCol; 
    public int mass;

    /**
     * This method is a constructor that initializes 
     * the instance variables to the parameters. 
     * @param currRow is row value
     * @param currCol is column value
     * @param mass is the mass of the cell
     */
    public Cell(int currRow, int currCol, int mass){
        this.currRow = currRow;
        this.currCol = currCol;
        this.mass = mass;
        /* This code below checks for validity */
        if(this.currRow < 0){
            this.currRow = 0;
        }
        if(this.currCol < 0){
            this.currCol = 0;
        }
        if(this.mass < 0){
            this.mass = 0;
        }
    }

    /**
     * This method is a copy ctor of the
     * above method
     * @param otherCell is another object of Cell
     */
    public Cell(Cell otherCell){
        this.currRow = otherCell.currRow; 
        this.currCol = otherCell.currCol;
        this.mass = otherCell.mass;
    }

    /**
     * This method sets the instance variables to -1
     */
    public void apoptosis(){
        this.currCol = -1;
        this.currRow = -1;
        this.mass = -1;
    }

    /**
     * This method is a getter.
     * @return the value of currRow
     */
    public int getCurrRow(){
        return this.currRow;
    }

    /**
     * This method is a getter.
     * @return the value of currCol
     */
    public int getCurrCol(){
        return this.currCol;
    }

    /**
     * This method is a getter.
     * @return the value of mass
     */
    public int getMass(){
        return this.mass;
    }

    /**
     * This method is an abstract that determines 
     * if the cell should initiate apoptosis.
     * @param neighbors is a name of the list of cell
     * @return true or false
     */
    public abstract boolean checkApoptosis(List<Cell> neighbors); 

    /**
     * This method returns whether this Cell has a 
     * bigger mass than the parameter
     * @param otherCell is another object of Cell
     * @return an integer depending on the
     * outcome of compareTo
     */
    public int compareTo(Cell otherCell){
        Integer massIntCell = this.mass;
        Integer massIntOtherCell = otherCell.mass;
        return massIntCell.compareTo(massIntOtherCell);
    }
    
    /**
     * This method returns a deep copy of the 
     * calling object.
     * @return the deep copy of the calling 
     * object
     */
    public abstract Cell newCellCopy();
}