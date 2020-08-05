import Analizadores.*;
import java_cup.runtime.Symbol;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.LinkedList;

public class main {
    public static void accessToken(Lexer lexico) {
        System.out.println("--------------------------- Tokens correctos ---------------------------");
        for (Token t : Lexer.tokens) {
            t.print();
        }

        System.out.println("--------------------------- Tokens incorrectos ---------------------------");
        System.out.println("\nErrores\n");
        for (Token t : Lexer.errores) {
            t.print();
        }
    }

    public static void accessErrors(analisis_sintactico parser) {
        for (TError t : analisis_sintactico.TablaES) {
            t.print();
        }
    }

    public static void main(String[] args) {
        try {
            File file = new File(
                    "C:\\Users\\alfon\\Documents\\compiladores-parser\\src\\Analizadores\\ejecutableSolidity.txt");
            Lexer lexico = new Lexer(new BufferedReader(new FileReader(file)));
            analisis_sintactico sintactico = new analisis_sintactico(lexico);
            System.out.println("--------------------------- Parseando... ---------------------------");
            sintactico.parse();
            System.out.println("------------------------ Datos de ejecucion ---------------------------");
            accessToken(lexico);
            System.out.println("--------------------------- Errores sintacticos ---------------------------");
            accessErrors(sintactico);
            LinkedList<RegistroSemantico> pilaSemantica = sintactico.pilaSemantica;
            System.out.println("F");
            // System.out.println(sintactico.resultado);
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}