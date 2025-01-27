/**
 * Project Assignment 8: Divisible.java
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
 * to determine where Divisible objects
 * should divide to.
 */
public interface Divisible{
    /**
     * This method is an abstract to
     * determine where Divisible objects
     * should divide to.
     * @return an integer where objects should
     * divide to
     */
    public abstract int[] getDivision();
}