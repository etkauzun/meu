
import java.util.*;
public class Exercise {
    public static void main(String args[]) {
        Scanner scan = new Scanner(System.in); 
        //Ask for user input
        System.out.println("Enter in a number to be multiplied by 2");
        
        //Process the input by multiplyinh user input by 2
        int input = scan.nextInt();
        int input_times_two = input*2;

        //Output the result
        System.out.println("The number: "+input+" multiplied by 2 is "+input_times_two);

        // To run this file in terminal, run “javac Exercise.java” first
        // then run “java Exercise” 
    }
}