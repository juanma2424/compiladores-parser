import Analizadores.*;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.StringReader;

public class main {
    public static void main(String[] args) {
        try {
            File file = new File("C:\\Users\\alfon\\Documents\\compiladores-parser\\src\\Analizadores\\ejecutableSolidity.txt"); 
            Lexer lexico = new Lexer (new BufferedReader(new FileReader(file)));
            analisis_sintactico sintactico = new analisis_sintactico(lexico);
            System.out.println("---- Inicio ----");
            sintactico.parse();
            System.out.println("---- Final ----");
            // System.out.println(sintactico.resultado);
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}