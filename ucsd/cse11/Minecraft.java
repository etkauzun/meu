/**
 * Project Assignment 5: Minecraft.java
 * M.Etka Uzun
 * A15956274
 * muzun@ucsd.edu
 * Sources: Tutors, Zybooks, Lectures
 * 
 * This file has two purposes: rotating an array
 * and determining mob(s) who need to be
 * tested for Covid-19. An array's size is 
 * changed and rotated. An array of strings
 * is evaluated to output string(s) of mob(s)
 * who need to be tested.
 */
import java.util.ArrayList;
 /**
  * This class has two methods to complete
  * the file's purposes. Each method returns
  * the wanted arrays.
  */
public class Minecraft {
    /**
     * This method is designed to rotate the
     * array and to change its size. 
     * 
     * @param originalFloorPlan is the array input
     * @return rotatedFloorPlan is the rotated array
     */
    public static int[][] rotateFloorPlan(int[][] originalFloorPlan){
        /*
        The code chunk below first returns null
        if the parameter is null. If not, it counts 
        the rows and columns of the parameter to assign
        to the rotatedFloorPlan. Then, rotatedFloorPlan is
        filled with values from the parameter. */
        if(originalFloorPlan == null){
            return null;
        }
        int countRows = 0;
        for(int i = 0; i < originalFloorPlan.length; i++){
            countRows += 1;
        }
        int countColumns = 0;
        for(int i = 0; i < originalFloorPlan[0].length; i++){
            countColumns += 1;
        }
        int[][] rotatedFloorPlan = new int[countColumns][countRows];
        for(int i = 0; i < countColumns; i++){
            for(int j = 0; j <  countRows; j++){
                rotatedFloorPlan[i][j] =  
                    originalFloorPlan[countRows - 1 - j][i];
            }
        }
        return rotatedFloorPlan;
    }
    /**
     * This method determines the mobs who
     * need to get tested for Covid-19.
     * 
     * @param groups is the input array containing mobs' names
     * @param infected is the input string containing the 
     * infected mob's name.
     * @return mobsToTest is the names of mobs' who need to 
     * get tested. 
     */
    public static ArrayList<String> getMobsToTest(String[][]
        groups, String infected){
        /*
        The code chunk below first returns null if
        the parameters are null. If not, an array list
        mobsToTest is filled with mobs that need testing. */
        if(groups == null){
            return null;
        }
        if(infected == null){
            return null;
        }
        ArrayList<String> mobsToTest = new ArrayList<String>();
        for(int i = 0; i < groups.length; i++){
            for(int j = 0; j < groups[i].length; j++){
                if(groups[i][j] == infected){
                    for(int k = 0; k < groups[i].length; k++){
                        if(groups[i][k] != infected &&
                            (!mobsToTest.contains(groups[i][k]))){
                            mobsToTest.add(
                                groups[i][k]);                        
                        }  
                    }
                }
            }
        }
        return mobsToTest;    
    }
    /**
     * This is the main mehtod, established to
     * test the above methods.
     * @param args is an array of strings
     */
    public static void main(String[] args){
    /**
     * int[][] arr = { 
        *    {1,2,3,4},
        *    {5,6,7,8},
        *    {9,10,11,12}
     * };
     * int [][] arr = null;
     * rotateFloorPlan(arr);
     * String [][] test = {
     *    {"Sheep", "Cow", "Pig"},
     *    {"Skeleton"},
     *    {"Zombie","Sheep","Cow","Pig"},
     *    {"Zombie", "Cow", "Creeper", "Guardian", null, "Slime"},
     *    {"Sheep", "Iron Golem", "Cow"}, 
     *    {"Sheep"},
     *    {"Cow", "Pufferfish", "Squid", "Sheep"}
     * };
     * String testname = "Sheep";
     * getMobsToTest(test, testname);
     * Above are test cases 
     */
    }
}