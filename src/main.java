import Analizadores.*;
import java.io.BufferedReader;
import java.io.StringReader;

public class main {
    public static void main(String[] args) {
        Analizador_Lexico lexico = new Analizador_Lexico(new BufferedReader(new StringReader("2,")));
        analisis_sintactico sintactico = new analisis_sintactico(lexico);

        try {
            sintactico.parse();
            System.out.println(sintactico.resultado);
        } catch (Exception e) {
            System.out.println("Se caga");
        }
    }
}