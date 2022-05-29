import java.util.*;
import java.io.*;

public class Main {
    public static void main(String[] args) {
        
        Scanner in = new Scanner(System.in);
        
        String object=in.nextLine();
        String key = in.nextLine();
        
        ObjectParse op = new ObjectParse(object,key);
        System.out.println( "Output Value = "+ op.valueReturner());
    }
}