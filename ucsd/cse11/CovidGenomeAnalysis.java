/**
 * Project Assignment 2: CovidGenomeAnalysis.java
 * M.Etka Uzun
 * A15956274
 * muzun@ucsd.edu
 * 
 * This code is designed to count the number of
 * letter A's in the input. Also, the code pairs
 * the letters in the input with corresponding
 * letters according to DNA's bonds.
 */
 import java.util.Scanner;

 public class CovidGenomeAnalysis {
     // This class counts A's and matches the letters in the input.
    public static void main(String[] args) {
       Scanner keyboard = new Scanner (System.in);
       String genomeSeq;
       StringBuilder matchedSeq = new StringBuilder("");
       int countA = 0;
       genomeSeq = keyboard.nextLine();
       
       for(int i = 0; i < (genomeSeq.length() ); i++){
            if(genomeSeq.charAt(i) == 65){ //finding letter A 
               countA += 1;
               matchedSeq.append("T");
            }     
            if(genomeSeq.charAt(i) == 84){ //finding letter T
               matchedSeq.append("A");
            }
            if(genomeSeq.charAt(i) == 71){ //finding letter G
               matchedSeq.append("C");
            }
            if(genomeSeq.charAt(i) == 67){ //finding letter C
               matchedSeq.append("G");
            }
        }
        System.out.println(countA + " " + matchedSeq);
    }
}