import java.util.*;
public class ObjectParse {

  private String objDict;
  private String[] keyArray;
  
  public ObjectParse (String oD, String kA){
    objDict = oD;
    keyArray = kA.split("/");
  }
  
  public String valueReturner(){
    String innerDict = objDict;
    for( String _key : keyArray ){
      if (innerDict.contains(_key)){
        //System.out.println("key -> " + _key);
        innerDict = innerDict.substring(5,innerDict.length()-1);
      }else {
        return "No data";
      }

    }
    return innerDict.toString();
  }

}