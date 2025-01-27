class Author{
    //instance varaibles
    private String lname;
    private String fname;
    private int age;

    //ctors
    public Author(){
    }

    public Author(String lnameVal, String fnameVal, int ageVal){
        this.lname = lnameVal;
        this.fname = fnameVal;
        this.age = ageVal;
    }
    public Author(Author other){
        this.lname = new String(other.lname);//deep copy
        this.fname = new String(other.fname);//deep copy
        this.age = other.age;
    }
    //getters
    public String getLname(){
        return this.lname;
    }
    //setters
    public void setLname(String lnameVal){
        this.lname = new String(lnameVal); //deep copy
    }
}
public class Book{
    //instance variables
    private Author author;
    private String title;
    private int year;

    //ctors
    public Book(){
    }
    public Book(Author authorVal, String titleVal, int yearVal){
        this.author = new Author(authorVal);
        this.title = new String(titleVal);
        this.year = yearVal;
    }
    public static void main(String[] args){
        Author paul = new Author("Cao", "Paul", 41);
        Book java = new Book(paul, "Intro to CSE 11", 2020);
        System.out.println(java.author.getLname());
        System.out.println(java.year);
    }
}









