/**
 * Project Assignment 6 - ContactInfo.java
 * Etka Uzun
 * A15956274
 * muzun@ucsd.edu
 * 
 * Sources: Tutors, Zybooks, Lectures
 * This file is used to store contact information
 * when two phones exchange information. It stores
 * the IDs, distance, and time. It has two methods.
*/

import java.util.Random;
import java.util.ArrayList;

/**
 * This class stores two instances and two methods. 
 * The first method is the constructor that initializes 
 * the instance variables. The second method checks if
 * the instance variables are valid.
 * 
 * Instance variables:
 * id - stores the ID that is sent
 * distance - stores the distance b/w two students
 * time - stores the time contact happens
 * used - stores whether the information is sent out
 */
public class ContactInfo {
    
    /** Instance variables */
    public int id;
    public int distance; 
    public int time; 
    public boolean used;

    /**
     * This is the constructor to initialize the 
     * instance variables.
     * 
     * @param id is the IDs of students
     * @param distance is the distance b/w students
     * @param time is when the contact occurs
     */
    public ContactInfo(int id, int distance, int time){
        used = false;
        this.id = id;
        this.distance = distance;
        this.time = time;
    }

    /**
     * This method checks the validity of the 
     * instance variables, which need to be
     * non-negative. 
     *  
     * @return true for valid and
     * false for invalid
     */
    public boolean isValid(){
        if(id >= 0 && distance >= 0 && time >= 0){
            return true;
        }
        else{ return false; }
    }
}    