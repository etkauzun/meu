/**
 * Project Assignment 6 - Student.java
 * Etka Uzun
 * A15956274
 * muzun@ucsd.edu
 * Sources: Tutors, Zybooks, Lectures
 * 
 * This file facilititates updating each object  
 * for doing some computations based on the current 
 * state of each object. It has six intance vars
 * and eight methods. 
*/

import java.util.Random;
import java.util.ArrayList;

/**
 * This class stores six instance variables and
 * eight methods to handle ID exchanges and statuses.
 * 
 * Instace Variables:
 * id - the (random) current ID of the student
 * location - the current location of the student
 * covidPositive - an indicator for if the student 
 * has tested positive
 * inQuarantine - an indicator for if the student
 * is in quarantine 
 * usedIds - all of the random IDs that the student 
 * has used so far
 * contactHistory - the ContactInfo objects that
 * were sent to this student 
 */
public class Student{

    /** Instance Variables */
    public int id;
    public int location;
    public boolean covidPositive;
    public boolean inQuarantine;
    public ArrayList<Integer> usedIds;
    public ArrayList<ContactInfo> contactHistory;

    /**
     * This method initializes the instance variables.
     */
    public Student(){
        this.id = -1;
        this.location = -1;
        covidPositive = false;
        inQuarantine = false;
        this.usedIds = new ArrayList<Integer>();
        this.contactHistory = new 
            ArrayList<ContactInfo>();
    }
    /**
     * This method updates the location 
     * with the argument.
     * @param newLocation is new location
     * @return true for new location
     */
    public boolean setLocation(int newLocation){
        if(newLocation >= 0 && (!inQuarantine)){
            this.location = newLocation;
            return true;
        }
        else{return false;}
    }
    /**
     * This method updates IDs with random numbers.
     */
    public void updateId(){
        Random randGen = new Random();//gets random values
        this.id = randGen.nextInt(Integer.MAX_VALUE);
        usedIds.add(id);
    }
    /**
     * This method add contact info to the 
     * contactHistory.
     * @param info is a new object
     * @return true for adding correctly
     */
    public boolean addContactInfo(ContactInfo info){
        if(info != null && info.isValid() ){
            contactHistory.add(info);
            return true;
        }
        else{return false;}
    }
    /**
     * This method uploads all IDs to server.
     * @param server is a new object
     * @return true for correctly uploading
     */
    public boolean uploadAllUsedIds(Server server){
        if(server != null){
            server.addInfectedIds(usedIds);
            return true;
        }
        else{ return false; }
    }
    /**
     * This method sets values to true and
     * uploads IDs to server.
     * @param server a new object
     * @return true for correctly uploading
     */
    public boolean testPositive(Server server){
        covidPositive = true;
        inQuarantine = true;
        if(server == null){
            return false;
        }
        uploadAllUsedIds(server);
        return true;
    }
    /**
     * This method gets all infected IDs.
     * @param server a new object from Server
     * @param fromTime time value 
     * @return positiveContacts - a new array list
     * containing recent students w/ positive tests
     */
    public ArrayList<ContactInfo> getRecentPositiveContacts
        (Server server, int fromTime){
        if(server == null){return null;}
        if(fromTime < 0){return null;}
        if(server.getInfectedIds() == null){
            return null;
        }
        ArrayList<Integer> infectedIDs = 
            server.getInfectedIds();
        ArrayList<ContactInfo> positiveContacts =
            new ArrayList();
        for(ContactInfo contact: contactHistory){
            if(contact.used == false && 
                infectedIDs.contains(contact.id)
                && contact.time >= fromTime){
                positiveContacts.add(contact);
            }
        }
        return positiveContacts;
    }
    /**
     * This method assesses a student's risk of
     * having Covid-19.
     * @param server a new Server object
     * @param fromTime time value
     * @param quarantineChoice is true for choosing to
     * be quaranteed
     * @return 1 if infected
     */
    public int riskCheck(Server server, int fromTime,
        boolean quarantineChoice){ 
        if(getRecentPositiveContacts(server, fromTime)
            == null){
            return -1;
        }
        /* This code chunk below establishes 
        a new array list that is the getRecentPositive
        Contacts method. Then, if a student contacted 
        an infected person from a distance of or less than
        1, he is infected. */
        ArrayList<ContactInfo> recentContacts 
            = getRecentPositiveContacts(server, fromTime);
        for(ContactInfo contact: recentContacts){
            if(testPositive(server) && contact.distance <= 1){
                contact.used = true;
                if(quarantineChoice){
                    inQuarantine = true;
                    return 1;
                }
            }
            int countRecCont = 0;
            for(int i = 0; i < recentContacts.size(); i++){
                if(testPositive(server)){
                    countRecCont += 1;
                }       
            }
            if(countRecCont >= 3){
                contact.used = true;
                if(quarantineChoice){
                    inQuarantine = true;
                    return 1;
                }
            }
        }
        return 0;
    }
}