/**
* Project Assignment 4: InfectionTracking.java
* Etka Uzun
* A15956274
* muzun@ucsd.edu
* Sources: Tutors, Zybooks
*
* This file is used to track the locations, movements,
* and Covid-infection statuses of students. Students' 
* locations, movements, and statuses are tracked to
* determine if they get infected or infect others 
* with Covid. 
*/

import java.io.File; 
import java.util.Scanner;
import java.io.IOException;
import java.util.Arrays;
import java.lang.Math;

/**
 * This class stores six methods to perform as
 * mentioned in the file header. Each method 
 * is responsible to return different values.
 */
public class InfectionTracking {

    /**
     * This class is designed to read inputs
     * from a file.
     * 
     * @return the largest location value plus one
     */
    public static int populateArrays(String pathToFile, String[] names, int[]
        locations, int[] movements, int[] infections) throws IOException {
        /**
         * The code chunk below checks for the
         * validity of inputs. Similar chunk of
         * codes will repeat throughout in each 
         * method.
         */
        if (pathToFile == null){
            return -1;
        }
        if (names == null || locations == null ||
            movements == null || infections == null){
            return -1;
        }
        if (names.length != locations.length ||
            names.length != movements.length ||    
            names.length != infections.length || 
            locations.length != movements.length || 
            locations.length != infections.length || 
            movements.length != infections.length){
            return -1;
        }
        File file = new File (pathToFile);
        Scanner input = new Scanner (file);
        input.useDelimiter("\\s*[,\\n]\\s*");
        int count = 0;
        /**
         * The code below reads and parses
         * data from a file to the arrays.
         */
        while (input.hasNext() && count < names.length){
            names[count] = input.next();
            locations[count] = input.nextInt();
            movements[count] = input.nextInt();
            infections[count] = input.nextInt();
            count++;
        }
        for (int i = 0; i < infections.length; i++){
            if(infections[i] != 0 && infections[i] != 1){
                return -1;
            }    
        }
        // System.out.println("names = " + Arrays.toString(names) );
        // System.out.println("locations = " + Arrays.toString(locations));
        // System.out.println("infections = " + Arrays.toString(infections));
        // System.out.println("movements = " + Arrays.toString(movements));
        /**
         * largestLocVal and code below is
         * used to return the largest location value
         * from the location array + 1
         */
        int largestLocVal = -1;
        for (int i = 0; i < locations.length; i++){
            if (i == 0){
                largestLocVal = locations[i];
            }
            else if (largestLocVal < locations[i]){
                largestLocVal = locations[i];
            }
        }
        largestLocVal++;
        return largestLocVal;
    }
    /**
     * This method is used to update the locations 
     * of students.
     * @param worldSize represents the length 
     * of the 1d world
     * @param locations represents the students' 
     * locations
     * @param movements represents the movement 
     * amounts
     */
    public static void updateLocations(int worldSize, int[] 
        locations, int[]movements){
        if (locations == null || movements == null){
            return;
        }
        if(locations.length != movements.length){
            return;
        }
        if (worldSize <= 0){ 
            return;
        }
        for (int i = 0; i < locations.length; i++){
            if(locations[i] < 0 || locations[i] >= worldSize){
                return;
            }
        }
        /**
         * This chunk of code updates the locations 
         * of students within the world size according
         * to their movements.
         */
        for (int i = 0; i < locations.length; i++){
            if((locations[i] + movements[i]) >= 0 
            && (locations[i] + movements[i]) < worldSize){
                locations[i] = locations[i] + movements[i];
            }
            else if(locations[i] + movements[i] >= worldSize){
                locations[i] = locations[i] + movements[i];
                locations[i] = locations[i] % worldSize;
            }
            else if(locations[i] + movements[i] < 0){
                locations[i] = locations[i] + movements[i];
                locations[i] = locations[i] % worldSize;
                locations[i] = worldSize + locations[i];
            }
            else if((-1 * (locations[i] + 
                movements[i])) > worldSize){
                locations[i] = locations[i] + movements[i];
                locations[i] = locations[i] % worldSize;
                locations[i] = worldSize + locations[i];
            }
        }
    }
    /**
     * This method is used to update the infection 
     * statuses of students.
     * 
     * @return numStudentsInfected which stores the 
     * number of infections caused by each student
     */
    public static int[] updateInfections(int worldSize, 
        int[] infections, int[]locations){
        if (locations == null || infections == null){
            return null;
        }
        if (worldSize <= 0){ 
            return null;
        }
        if(locations.length != infections.length){
            return null;
        }
        for (int i = 0; i < locations.length; i++){
            if(locations[i] < 0 || locations[i] >= worldSize){
                return null;
            }
        }
        for (int i = 0; i < infections.length; i++){
            if(infections[i] != 0 && infections[i] != 1){
                return null;
            }    
        }
        /**
         * This chunk of code is used to determine 
         * which students infected others. The number of 
         * infections is stored in numStudentsInfected. 
         */
        int[] numStudentsInfected = new int[infections.length];
        for(int i = 0; i < infections.length; i++){
            if(infections[i] == 0){
                numStudentsInfected[i] = 0;
            }
            else if(infections[i] == 1){
                int j = 0;
                while(j < locations.length){
                    if(locations[j] == locations[i] && 
                        infections[j] == 0){
                        numStudentsInfected[i] = numStudentsInfected[i]+ 1;
                    }
                    j += 1;
                }
            }
        }
        for(int i = 0; i < infections.length; i++){
            if(infections[i] == 0){
                int j = 0;
                while(j < locations.length){
                    if(locations[j] == locations[i] && 
                        infections[j] == 1){
                        infections[i] = 1;
                    }
                    j += 1; 
                }
            }    
        }
        return numStudentsInfected; 
    }
    /**
     * This method simulates student movements 
     * and infections. 
     * @param days represents the amount of
     * simulation.
     * 
     * @return infectionRecord which shows the
     * number of infections each student causes
     */
    public static int[] countInfectionsByStudent(int days, 
        int worldSize, int[]locations, int[] movements, 
        int[] infections){
        if (worldSize <= 0){ 
            return null;
        }
        if (days <= 0){ 
            return null;
        }
        if (locations == null || infections == null || 
            movements == null){
            return null;
        }
        if (locations.length != movements.length || 
        locations.length != infections.length ||
        movements.length != infections.length){
            return null;
        }
        for (int i = 0; i < locations.length; i++){
            if(locations[i] < 0 || locations[i] >= worldSize){
                return null;
            }
        }
        for (int i = 0; i < infections.length; i++){
            if(infections[i] != 0 && infections[i] != 1){
                return null;
            }
        }
        /**
         * This cunk of code simulates the movements 
         * and infections by calling the updateLocations
         * and updateInfectoins methods. 
         */
        int[] infectionRecord = new int [infections.length];
        for(int i = 0; i < days; i++){
            updateLocations(worldSize, locations, movements);
            int[] numInfectedByStudent = updateInfections(worldSize,
                infections, locations);
            int j = 0;
            while(j < numInfectedByStudent.length){
                infectionRecord[j] = infectionRecord[j] 
                + numInfectedByStudent[j];
                j += 1;
            }
        }   
        return infectionRecord;
    }
    /**
     * This method gives the average number
     * of people who will get infected.
     * @return that average value
     */
    public static int findRNaught(int[] infectionRecord){
        if(infectionRecord == null){
            return -1;
        }
        if(infectionRecord.length == 0){
            return -1;
        }
        for(int i = 0; i < infectionRecord.length; i++){
            if(infectionRecord[i] < 0){
                return -1;
            }
        }
        /**
         * This chunk of code calculates the
         * average number of infections by
         * dividing sum of infections by 
         * numStudents. 
         */
        double sum = 0;
        for(int i = 0; i < infectionRecord.length; i++){
            sum = sum + infectionRecord[i];
        }
        double numStudents = infectionRecord.length;
        double reValue = Math.ceil(sum / numStudents);
        int returnValue = (int) reValue;
        return returnValue;
    }
    /**
     * This method tells who infected the
     * most. 
     * 
     * @return the name of that person
     */
    public static String findSuperSpreader(int[] infectionRecord,
        String[] names){
        if(infectionRecord == null){
            return null;
        }
        if(names == null){
            return null;
        }
        if(infectionRecord.length != names.length){
            return null;
        }
        for(int i = 0; i < infectionRecord.length; i++){
            if(infectionRecord[i] < 0){
                return null;
            }
        }

        /**
         * This chunk of code compares the values
         * of infectionRecord and assigns the names
         * to the superReader.
         */
        String superSpreader = "";
        for(int i = 0; i < infectionRecord.length; i++){
            if (i == 0){
                superSpreader = names[i];
            }
            if(infectionRecord[i] > infectionRecord[i+1]){
                superSpreader = names[i];
            }
        }
        // System.out.println(superSpreader);
        return superSpreader;
    }
    public static void main(String[]args) throws IOException {
        // String[] names = new String [4];
        // int[] locations = new int [4];
        // int[] movements = new int [4];
        // int[] infections = new int[4];
        // System.out.println(populateArrays("Students.csv",
        // names, locations, movements, infections));
        // above is for Part 1
        
        // int[] locations = {3,2,1,0};
        // int[] movements = {2,-3,1,-2};
        // updateLocations(4, locations, movements);
        // above is for Part 2 locations
        
        // int[] locations = {2, 1, 4, 3, 3, 5, 1, 1, 3};
        // int[] infections = {0, 0, 1, 1, 0, 0, 1, 0, 1};
        // updateInfections(6, infections, locations);
        // above is for Part 2 infections
        
        // int[] locations = {3, 2, 1, 0, 5, 2, 9};
        // int[] movements = {2, -3, 1, -2, 3, 2, 5};
        // int[] infections = {0, 1, 0, 0, 0, 0, 1};
        // countInfectionsByStudent(3, 10, locations, 
        // movements, infections);
        // above is for Part 3

        // int[] infectionRecord = {2,1,0,4,7,3,1};
        // findRNaught(infectionRecord);
        // above is for Part 4 Rnaught

        int[] infectionRecord = {8,4,1,0,7,4,1};
        String[] names = {"Isaac", "Kevin", "Mary", "Sally", "Miranda", "Bob", "Charles"};
        findSuperSpreader(infectionRecord, names);
    }
}