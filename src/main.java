import Analizadores.*;
import java.io.BufferedReader;
import java.io.StringReader;

public class main {
    public static void main(String[] args) {
        Analizador_Lexico lexico = new Analizador_Lexico(new BufferedReader(new StringReader("+ + +")));
        analisis_sintactico sintactico = new analisis_sintactico(lexico);

        try {
            sintactico.parse();
            System.out.println("4 + 3");
            System.out.println(sintactico.resultado);
        } catch (Exception e) {
            System.out.println("Se caga");
        }
    }
}