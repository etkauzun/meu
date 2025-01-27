/**
 * Project Assignment 2: CovidMutation.java
 * M.Etka Uzun
 * A15956274
 * muzun@ucsd.edu
 * 
 * This code is designed to take any integer 
 * k and reverse the input by every k size chunk. 
 */
import java.util.Scanner;

public class CovidMutation{
    // This class reverses the input by every k size chunk.
    public static void main(String[] args){
        Scanner keyboard = new Scanner (System.in);
        String genomeSeq;
        StringBuilder mutatedSeq = new StringBuilder("");
        int k;
        genomeSeq = keyboard.nextLine();
        k = keyboard.nextInt();

        // input is printed if the k is 0 or less.
        if(k <= 0){
            System.out.println(genomeSeq);
        }
        // input is reversed if k is greater.
        else if(k > genomeSeq.length() ){ 
            for(int i = genomeSeq.length(); i > 0; i--){
                mutatedSeq.append(genomeSeq.charAt(i - 1));
            }         
        } 
        // input is reversed according to the k chunks.
        else if(genomeSeq.length() % k == 0){
            for(int i = 0; i < genomeSeq.length(); i += k){
                String chunk = genomeSeq.substring(i, (i + k) );
                for(int j = chunk.length(); j > 0; j--){
                    mutatedSeq.append(chunk.charAt(j - 1));
                }                            
            }
        }
        // input is reversed according to the k chunks
        // and remainder. 
        else if(genomeSeq.length() % k != 0){
            int remainder = (genomeSeq.length() % k);
            for(int i = 0; i < (genomeSeq.length() - remainder); i += k){
                String chunk = genomeSeq.substring(i, (i + k) );
                for(int j = chunk.length(); j > 0; j--){
                    mutatedSeq.append(chunk.charAt(j - 1));
                }                            
            }
            String remainderLetters = genomeSeq.substring(genomeSeq.length() - remainder, genomeSeq.length());
                for(int j = remainderLetters.length(); j > 0; j--){
                    mutatedSeq.append(remainderLetters.charAt(j - 1));
                }
        }
        System.out.println(mutatedSeq);
    }
}