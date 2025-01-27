/**
 * Project Assignment 7: PetriDish.java
 * Etka Uzun
 * A15956274
 * muzun@ucsd.edu
 * 
 * Sources: Zybooks, Lectures, Tutors
 * This file extends Cell class. It is for 
 * a stationary cell. It returns the string 
 * representation of the cell. 
 */

import java.util.List; 
import java.util.ArrayList;
import java.util.Arrays;
/**
 * This class has three instance variable
 * and one method. It returns the string 
 * representation of the cell in a cell
 * type 2d array from the input.
 * Instance Variables
 * dish - a Cell type 2D array to
 * movales - a list of all movable cells
 * divisibles - a list of all divisible cells
 */
public class PetriDish{
    /* Instance Variables */
    public Cell[][] dish;
    public List<Movable> movables; 
    public List<Divisible> divisibles;

    /**
     * This method (ctor) populates the instance variable
     * with the input board.
     * @param board is a 2d array of strings
     * containing cells' information
     */
    public PetriDish(String[][] board){
        /* The code chunk below first initializes the
        dish to an array of board size. Then, each 
        input of board is split into two strings if
        it is not null. These split strings are checked
        to populate the dish accordingly. */
        movables = new ArrayList();
        divisibles = new ArrayList();
        dish = new Cell[board.length][board[0].length];
        for(int i = 0; i < board.length; i++){
            for(int j = 0; j < board[i].length; j++){
                String boardInput = board[i][j];
                String[] boardInputParts = boardInput.split(" ");
                if(board[i][j] == "null"){ 
                }
                else if(boardInputParts.length == 2){
                    String inputPart1 = boardInputParts[0];
                    String inputPart2 = boardInputParts[1];
                    int intInputPart2 = Integer.parseInt(inputPart2);
                    if(inputPart1.equals("CellMoveUp")){
                        dish[i][j] = new CellMoveUp(i,j, intInputPart2);
                        movables.add((Movable)dish[i][j]);
                    }
                    if(inputPart1.equals("CellStationary")){
                        dish[i][j] = new CellStationary(i,j, intInputPart2); 
                    }
                    if(inputPart1.equals("CellDivide")){
                        dish[i][j] = new CellDivide(i,j, intInputPart2);
                        divisibles.add((Divisible)dish[i][j]);
                    }
                    if(inputPart1.equals("CellMoveToggle")){
                        dish[i][j] = new CellMoveToggle(i,j, intInputPart2); 
                        movables.add((Movable)dish[i][j]);
                    }
                    if(inputPart1.equals("CellMoveDiagonal")){
                        dish[i][j] = new CellMoveDiagonal(i,j, intInputPart2);
                        movables.add((Movable)dish[i][j]);
                    }
                    if(inputPart1.equals("CellMoveToggleChild")){
                        dish[i][j] = new CellMoveToggleChild(i,j,
                            intInputPart2);
                        movables.add((Movable)dish[i][j]);    
                    }
                }
            }
        }
    }
    /**
     * This method returns a list of cell
     * neighboring input location.
     * @param row location
     * @param col location
     * @return the list of neighbors
     */
    public List<Cell> getNeighborsOf(int row, int col){
        List<Cell> neighbors = new ArrayList();
        if(row < 0 || row >= dish.length){
            return null;
        }
        else if(col < 0 || col >= dish[0].length){
            return null;
        }
        else{
            if(row - 1 >= 0){ //checking for northeast w/row
                if((col-1) < 0){//no colmn to left
                    if(dish[row-1][dish[0].length-1] != null){
                        neighbors.add(dish[row-1][dish[0].length-1]);
                    }
                }
                if((col-1)>=0){//colmn to left
                    if(dish[row-1][col-1] != null){
                        neighbors.add(dish[row-1][col-1]);
                    }
                }
            }
            if(row - 1 < 0){//checking for northeast w/out row above
                if(col - 1 < 0){//w/out col to the left
                    if(dish[dish.length - 1][dish[0].length - 1] != null){
                        neighbors.add(dish[dish.length - 1][dish[0].length 
                            - 1]);
                    }
                }
                if(col - 1 >= 0){ //w/ col to left
                    if(dish[dish.length-1][col-1] != null){
                        neighbors.add(dish[dish.length-1][col-1]);
                    }
                }
            }
            if(row - 1 >= 0){//checking for north w/row
                if(dish[row-1][col] != null){
                    neighbors.add(dish[row-1][col]);
                }
            }
            if(row - 1 < 0){//checking for north w/out row above
                if(dish[dish.length-1][col] != null){
                    neighbors.add(dish[dish.length-1][col]);
                }
            }
            if(row - 1 < 0){//checking for northwest w/out row above
                if(col + 1 >= dish[0].length){//for no col to right
                    if(dish[dish.length-1][0] != null){
                        neighbors.add(dish[dish.length-1][0]);
                    }
                }
                if(col + 1 < dish[0].length){//for col to right
                    if(dish[dish.length-1][col+1] != null){
                        neighbors.add(dish[dish.length-1][col+1]);
                    }
                }
            }
            if(row - 1 >= 0){ //checking for northwest w/row
                if((col + 1) < dish[row - 1].length){//column to right
                    if(dish[row - 1][col + 1] != null){
                        neighbors.add(dish[row - 1][col + 1]);
                    }
                }
                if((col + 1) >= dish[row-1].length){ //no column to right
                    if(dish[row-1][0] != null){
                        neighbors.add(dish[row-1][0]);
                    }
                }
            }
            if(col - 1 >= 0){//checking for east w/col to left
                if(dish[row][col-1] != null){
                    neighbors.add(dish[row][col-1]);
                }
            }
            if(col - 1 < 0){//for east w/out col to left
                if(dish[row][dish[0].length-1] != null){
                    neighbors.add(dish[row][dish[0].length-1]);
                }
            }
            if(col + 1 < dish[0].length){//for west w/col to right
                if(dish[row][col+1] != null){
                    neighbors.add(dish[row][col+1]);
                }
            }
            if(col + 1 >= dish[0].length){//for west w/out col
                if(dish[row][0] != null){
                    neighbors.add(dish[row][0]);
                }
            }
            if(row + 1 >= dish.length){//for southeast w/out row below
                if(col - 1 < 0){//for no col to left
                    if(dish[0][dish[0].length-1] != null){
                        neighbors.add(dish[0][dish[0].length-1]);
                    }
                }
                if(col - 1 >= 0){//for col to left
                    if(dish[0][col-1] != null){
                        neighbors.add(dish[0][col-1]);
                    }
                }
            }
            if(row+1 < dish.length){//for southeast w/row below
                if(col-1 < 0){//no col to left
                    if(dish[row+1][dish[0].length-1] != null){
                        neighbors.add(dish[row+1][dish[0].length-1]);
                    }
                }
                if(col-1 >= 0){//col to left
                    if(dish[row+1][col-1] != null){
                        neighbors.add(dish[row+1][col-1]);
                    }
                }
            }
            if(row+1 >= dish.length){//for south w/no row below
                if(dish[0][col] != null){
                    neighbors.add(dish[0][col]);
                }
            }
            if(row+1 < dish.length){//for south w/row below
                if(dish[row+1][col] != null){
                    neighbors.add(dish[row+1][col]);
                }
            }
            if(row+1 >= dish.length){//for southwest w/no row
                if(col+1 >= dish[0].length){//no col to right
                    if(dish[0][0] != null){
                        neighbors.add(dish[0][0]);
                    }
                }
                if(col+1 < dish[0].length){//col to right
                    if(dish[0][col+1] != null){
                        neighbors.add(dish[0][col+1]);
                    }
                }
            }
            if(row+1 < dish.length){//southwest w/row below
                if(col+1 < dish[0].length){//col to right
                    if(dish[row+1][col+1] != null){
                        neighbors.add(dish[row+1][col+1]);
                    }
                }
                if(col+1 >= dish[0].length){//no col to right
                    if(dish[row+1][0] != null){
                        neighbors.add(dish[row+1][0]);
                    }
                }
            }
            return neighbors;
        }
    }

    /**
     * This method moves the cells respective
     * to their new locations. If the new
     * locations contain other cell(s), some 
     * killing occurs.
     */
    public void move(){
        for(Movable movableCells: movables){
            int[] newPosition = movableCells.getMove();
            Cell movingCell = (Cell) movableCells;
            int oldRow = movingCell.getCurrRow();
            int oldCol = movingCell.getCurrCol();
            if(newPosition[0] >= dish.length){//wrapping
                newPosition[0] = newPosition[0] - dish.length;
            }
            else if(newPosition[0] < 0){
                newPosition[0] = newPosition[0] + dish.length;
            }
            if(newPosition[1] >= dish[0].length){
                newPosition[1] = newPosition[1] - dish[0].length;
            }
            else if(newPosition[1] < 0){//still wrapping
                newPosition[1] = newPosition[1] + dish[0].length;
            }
            dish[oldRow][oldCol] = null;//vacating old spot
            if(dish[newPosition[0]][newPosition[1]] != null){//killing cells
                if(dish[newPosition[0]][newPosition[1]].toString().equals(".")){
                    dish[newPosition[0]][newPosition[1]] = movingCell;
                }
                else if(dish[newPosition[0]][newPosition[1]].toString().equals
                        ("+")){
                    dish[newPosition[0]][newPosition[1]] = movingCell;
                }
                else{
                    if(movingCell.compareTo(dish[newPosition[0]][newPosition[1]
                            ])== 1){
                        dish[newPosition[0]][newPosition[1]].apoptosis();
                        dish[newPosition[0]][newPosition[1]] = movingCell;
                    }
                    else if(movingCell.compareTo(dish[newPosition[0]]
                            [newPosition[1]])== 0){
                        movingCell.apoptosis();
                        dish[newPosition[0]][newPosition[1]].apoptosis();
                        dish[newPosition[0]][newPosition[1]] = null;
                    }
                    else{
                       movingCell.apoptosis();
                    }
                }
            }
            else{
                dish[newPosition[0]][newPosition[1]] = movingCell;
            }
        }
    }

    /**
     * This method divides the cell in the 
     * divisible list and kills cells 
     * accordingly.
     */
    public void divide(){
        for(Divisible divisibleCells: divisibles){
            int[] division = divisibleCells.getDivision();
            Cell dividingCell = (Cell) divisibleCells;
            int oldRow = dividingCell.getCurrRow();
            int oldCol = dividingCell.getCurrCol();
            if(division[0] >= dish.length){//wrapping
                division[0] = division[0] - dish.length;
            }
            else if(division[0] < 0){
                division[0] = division[0] + dish.length;
            }
            if(division[1] >= dish[0].length){
                division[1] = division[1] - dish[0].length;
            }
            else if(division[1] < 0){//still wrapping
                division[1] = division[1] + dish[0].length;
            }
            Cell newDivCell = dividingCell.newCellCopy();
            if(dish[division[0]][division[1]] != null){//killing of the cells
                if(newDivCell.compareTo(dish[division[0]][division[1]]) == 1){
                    dish[division[0]][division[1]].apoptosis();
                    dish[division[0]][division[1]] = newDivCell;
                }
                else if(newDivCell.compareTo(dish[division[0]][division[1]])
                        == 0){
                    newDivCell.apoptosis();
                    dish[division[0]][division[1]].apoptosis();
                    dish[division[0]][division[1]] = null;
                }
                else{
                    newDivCell.apoptosis();
                }
            }
            else{
                dish[division[0]][division[1]] = newDivCell;
            }
        }
    }

    /**
     * This method updates the petri dish.
     */
    public void update(){
        for(int i = 0; i < dish.length; i++){
            for(int j = 0; j< dish[0].length; j++){
                if(dish[i][j] != null){
                    List<Cell> neighbors = getNeighborsOf(i, j);
                    if(dish[i][j].checkApoptosis(neighbors)){
                        dish[i][j].apoptosis();
                        dish[i][j] = null;
                    }
                }
            }
        }
    }
    
    /**
     * This method iterates the 
     * methods. 
     */
    public void iterate(){
        this.move();
        this.divide();
        this.update();
    }
}