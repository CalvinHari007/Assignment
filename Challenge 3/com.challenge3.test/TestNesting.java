import static org.junit.Assert.*;
import org.junit.Test;
public class TestNesting {

  @Test
  public void testNestingObject(){
    assertEquals('{"y":{"z":"d"}}',Main.main('{"a":{"x":{"y":{"z":"d"}}}}','a/x'));
    assertEquals('"d"',Main.main('{"a":{"x":{"y":{"z":"d"}}}}','a/x/y/z'));
    assertEquals('"No data"',Main.main('{"a":{"x":{"y":{"z":"d"}}}}','a/x/y/a'));
    
  }

}