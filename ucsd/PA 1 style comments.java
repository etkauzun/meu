/* Project Assignment 1: CovidTransmission.java 
   M.Etka Uzun
   A15956274
   muzun@ucsd.edu
*/
import java.util.Scanner;

public class CovidTransmission {
    public static void main(String [] args) { 
        Scanner keyboard = new Scanner (System.in);
        int d1;
        int h1;
        int m1;
        int d2;
        int h2;
        int m2;
        int totalMin;
        String riskLevel;

        // System.out.println("Enter your contact time in the following format: D1 H1 M1 D2 H2 M2.");     
        d1 = keyboard.nextInt();                                                                       
        h1 = keyboard.nextInt();
        m1 = keyboard.nextInt();
        d2 = keyboard.nextInt();
        h2 = keyboard.nextInt();
        m2 = keyboard.nextInt();

        if (!((d1 >= 1) && (d1 <= 31))){    //edge case: range for day 1
            totalMin = -1;
            riskLevel = "-1";
            System.out.println(totalMin + " " + riskLevel);
        }
        else if (!((d2 >= 1) && (d2 <= 31))){   //edge case: range for day 2
            totalMin = -1;
            riskLevel = "-1";
            System.out.println(totalMin + " " + riskLevel);
        }        
        else if (!((h1 >= 0) && (h1 <= 23))){   //edge case: range for hour 1
            totalMin = -1;
            riskLevel = "-1";
            System.out.println(totalMin + " " + riskLevel);
        }
        else if (!((h2 >= 0) && (h2 <= 23))){   //edge case: range for hour 2
            totalMin = -1;
            riskLevel = "-1";
            System.out.println(totalMin + " " + riskLevel);
        }
        else if (!((m1 >= 0) && (m1 <= 59))){   //edge case: range for minute 1
            totalMin = -1;
            riskLevel = "-1";
            System.out.println(totalMin + " " + riskLevel);
        }
        else if (!((m2 >= 0) && (m2 <= 59))){   //edge case: range for minute 2
            totalMin = -1;
            riskLevel = "-1";
            System.out.println(totalMin + " " + riskLevel);
        }
        else if ((d1 == d2) && (h1 == h2) && (m2 < m1)){    // edge case: negative number for minute
            totalMin = -1;
            riskLevel = "-1";
            System.out.println(totalMin + " " + riskLevel);
        }
        else if ((d1 == d2) && (h2 < h1)) {     //edge case: negative number for hour
            totalMin = -1;
            riskLevel = "-1";
            System.out.println(totalMin + " " + riskLevel);
        }
        else if (d1 > d2){      //edge case: negative number for day
            totalMin = -1;
            riskLevel = "-1";
            System.out.println(totalMin + " " + riskLevel);
        }
        else if ((d1 == d2) && (h1 == h2) && (m2 >= m1)) {        // contact within the same day and same hour
           totalMin = m2 - m1;
                if ( (totalMin >= 0) && (totalMin <= 60) ){       // contact duration is assessed to indicate the risk level
                    riskLevel = "low";
                    System.out.println(totalMin + " " + riskLevel);     
                }
                else if ( (totalMin > 60) && (totalMin <= 180)){ 
                    riskLevel = "medium";
                    System.out.println(totalMin + " " + riskLevel);
                }
                else if ( (totalMin > 180) && (totalMin <= 360)){
                    riskLevel = "high";
                    System.out.println(totalMin + " " + riskLevel);
                }
                else if (totalMin > 360 ){
                    riskLevel = "extremely high";
                    System.out.println(totalMin + " " + riskLevel);
                }
        }
        else if ((d1 == d2) && (h2 > h1)) {                       //contact within the same day but different hours
           totalMin = (60 - m1) + m2 + ((h2 - h1 - 1) * 60);
                if ( (totalMin >= 0) && (totalMin <= 60) ){       // contact duration is assessed to indicate the risk level
                    riskLevel = "low";
                    System.out.println(totalMin + " " + riskLevel);     
                }
                else if ( (totalMin > 60) && (totalMin <= 180)){
                    riskLevel = "medium";
                    System.out.println(totalMin + " " + riskLevel);
                }
                else if ( (totalMin > 180) && (totalMin <= 360)){
                    riskLevel = "high";
                    System.out.println(totalMin + " " + riskLevel);
                }
                else if (totalMin > 360 ){
                    riskLevel = "extremely high";
                    System.out.println(totalMin + " " + riskLevel);
                }
        }    
        else if (d1 != d2){                                     //contact on different days
            totalMin = (60 - m1) + ( (24 - h1 - 1) * 60) + ( (d2 - d1 - 1) * 1440) + ( (h2 - 0) * 60) + m2;
                if ( (totalMin >= 0) && (totalMin <= 60) ){     // contact duration is assessed to indicate the risk level
                    riskLevel = "low";
                    System.out.println(totalMin + " " + riskLevel);     
                }
                else if ( (totalMin > 60) && (totalMin <= 180)){
                    riskLevel = "medium";
                    System.out.println(totalMin + " " + riskLevel);
                }
                else if ( (totalMin > 180) && (totalMin <= 360)){
                    riskLevel = "high";
                    System.out.println(totalMin + " " + riskLevel);
                }
                else if (totalMin > 360 ){
                    riskLevel = "extremely high";
                    System.out.println(totalMin + " " + riskLevel);
                }
        }
    }
}