/**
* Project Assignment: 3
* M.Etka Uzun
* A15956274
* muzun@ucsd.edu
* 
*This code is designed to encode 
*and decode messages. There are
*two different ciphers, first one 
*encyrpting a single letter and
*second one encyrpting words.
*/

public class Cipher {
// This class houses six methods for encrption and decryption.
    private static final String alphabet = "abcdefghijklmnopqrstuvwxyz";
    private static final int modulo = alphabet.length();


    public static boolean isLowerCase(char letter){
        return (letter >= 97 && letter <= 122);
    }
    //The method above checks if the input (char) is lower case.
    public static boolean isLowerCase(String str){
        if (str == "" ){
            return true;
        }    
        if (str == null){
            return false;
        }
        Boolean flag = true;
        for (int i = 0; i < str.length(); i++ ){
            if (isLowerCase(str.charAt(i)) == false) {
                flag = false;
            }
        }
        //this loop returns false for not lower case
        return flag;
    }
    //The method above checks if the input (string) is lower case.
    public static char caesarShiftEncode(char plaintext, char key) {
        if (!isLowerCase(plaintext) || !isLowerCase(key)) {
            return plaintext;
        }
        int letterAssign = (alphabet.indexOf(plaintext) + key) % modulo;
        //this var is assigned the number of input from alphabet 
        if (letterAssign < 0) {
            letterAssign += modulo;
        }
        char encryptedLetter  = alphabet.charAt(letterAssign);
        return encryptedLetter;
    }
    //The method above encyrpts a single letter (char).
    public static char caesarShiftDecode(char ciphertext, char key){
        if (isLowerCase(ciphertext) == false || isLowerCase(key) == false) {
            return ciphertext;
        }
        int letterAssign = (alphabet.indexOf(ciphertext) - key) % modulo;
        if (letterAssign < 0) {
            letterAssign += modulo;
        }
        char decryptedLetter  = alphabet.charAt(letterAssign);
        return decryptedLetter;
    }
    //The method above decyrpts a single letter (char).
    public static String vigenereEncode(String plaintext, String key){
        if (!isLowerCase(plaintext) || !isLowerCase(key)) {
            return null;
        }    
        if (key == ""){
            return null;
        } 
        if (plaintext == null || key == null){
            return null;
        }
        String encryptedCipher = "";
        if (key.length() >= plaintext.length()){
            for (int i = 0; i < plaintext.length(); i++){
                int letterAssign = ( alphabet.indexOf(plaintext.charAt(i)) 
                + alphabet.indexOf(key.charAt(i)) % modulo);
                if (letterAssign < 0){
                    letterAssign += modulo;
                }
                if (letterAssign >= modulo){
                    letterAssign -= modulo;
                }
                encryptedCipher += alphabet.charAt(letterAssign);
            }
        }
        //this if assigns input's number in the alphabet
        else {
            for (int i = 0; i < plaintext.length(); i++){
                int letterAssign = ( alphabet.indexOf(plaintext.charAt(i))
                + alphabet.indexOf(key.charAt(plaintext.length() % key.length()) ) ) 
                % modulo; //
                if (letterAssign < 0){
                    letterAssign += modulo;
                }
                if (letterAssign >= modulo){
                    letterAssign -= modulo;
                }
                encryptedCipher += alphabet.charAt(letterAssign);
            }
        }
        return encryptedCipher;
    }
    //The method above encrypts a letter or word (string).
    public static String vigenereDecode(String ciphertext, String key){
        if (!isLowerCase(ciphertext) || !isLowerCase(key)) {
            return null;
        }    
        if (key == ""){
            return null;
        } 
        if (ciphertext == null || key == null){
            return null;
        }
        String decryptedCipher = "";
        if (key.length() >= ciphertext.length()){
            for (int i = 0; i < ciphertext.length(); i++){
                int letterAssign = ( alphabet.indexOf(ciphertext.charAt(i)) 
                - alphabet.indexOf(key.charAt(i)) % modulo);
                if (letterAssign < 0){
                    letterAssign += modulo;
                }
                if (letterAssign >= modulo){
                    letterAssign -= modulo;
                }
                decryptedCipher += alphabet.charAt(letterAssign);
            }
        }
        else {
            for (int i = 0; i < ciphertext.length(); i++){
                int letterAssign = ( alphabet.indexOf(ciphertext.charAt(i))
                - alphabet.indexOf(key.charAt(ciphertext.length() % key.length()) ) ) 
                % modulo;
                if (letterAssign < 0){
                    letterAssign += modulo;
                }
                if (letterAssign >= modulo){
                    letterAssign -= modulo;
                }
                decryptedCipher += alphabet.charAt(letterAssign);
            }
        }
        return decryptedCipher;
    }  
    //The method above decrypts a letter or word (string).
}