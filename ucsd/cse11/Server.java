/**
 * Project Assignment 6 - Server.java
 * Etka Uzun
 * A15956274
 * muzun@ucsd.edu
 * 
 * Sources: Tutors, Zybooks, Lectures
 * This file is used to represent the the server
 * that stores all IDs from covid infected students.
 * It has one instance variable and three methods. 
 * It adds new IDs and gets all stored IDs.
*/

import java.util.Random;
import java.util.ArrayList;

/**
 * This class has one instance variable and
 * three methods to store the IDs.
 * 
 * Instance Variable:
 * infectedIds - the list of infected students' ids
 */
public class Server {
    /** Instance Variable */
    public ArrayList<Integer>infectedIds;
    /**
     * This method initializes the instance var
     * with an empty list. 
     */
    public Server(){
        this.infectedIds = new ArrayList<Integer>(); 
    }
    /**
     * This method copies ids values to the instance var
     * 
     * @param ids is a list of ids
     * @return true for correct copying
     * and false for null ids
     */
    public boolean addInfectedIds(ArrayList<Integer> ids){
        if(ids == null){return false;}
        /* This code chunk copies the parameter */
        for(int i = 0; i < ids.size(); i++){
            infectedIds.add(ids.get(i));
        }
        return true;
    }
    /**
     * This method deep copies the infectedIds
     * to a new list.
     * 
     * @return copiedInfectedIds is the deep copied list
     */
    public ArrayList<Integer> getInfectedIds(){
        ArrayList<Integer> copiedInfectedIDs 
            = new ArrayList<Integer>();
        /* This code chunk deep copies the infectedIds*/
        for(int i = 0; i < infectedIds.size(); i ++){
            copiedInfectedIDs.add(infectedIds.get(i));
        }
        return copiedInfectedIDs;
    } 
}