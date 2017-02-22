import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Konwerter_XML_JSON {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws FileNotFoundException {
        try {
            String tekstPlik = "src/dane/dokumentXML.xml";
            parser parser_obj = new parser(new MyLexer(new FileReader(tekstPlik)));
            Object result = parser_obj.parse().value;
            System.out.println(result.toString());
            
        } catch (Exception ex) {
            Logger.getLogger(Konwerter_XML_JSON.class.getName()).log(Level.SEVERE, null, ex);
        }
        

    }

}
