/**
 * Project Assignment 8: Movable.java
 * Etka Uzun
 * A15956274
 * muzun@ucsd.edu
 * 
 * Sources: none
 * This file is an interface to determine where
 * Movable objects should move to.
 * It has a method to do so. 
 */

/**
 * This interface has a single method
 * to determine where Movable objects
 * should move to.
 */
public interface Movable{
    /**
     * This method is an abstract to
     * determine where Movable objects
     * should move to.
     * @return an integer for the direction
     */
    public abstract int[] getMove();
}