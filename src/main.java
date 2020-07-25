import Analizadores.*;
import java_cup.runtime.Symbol;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.StringReader;
import java.util.ArrayList;

public class main {
    public static void accessToken(Lexer lexico) {
        for (Token t : Lexer.tokens) {
            t.print();
        }

        System.out.println("\nErrores\n");
        for (Token t : Lexer.errores) {
            t.print();
        }
    }

    public static void main(String[] args) {
        try {
            File file = new File(
                    "/media/bryan/Disco 1/Documentos/Ingeniería en computación/Semestre V/Compiladores/Proyectos/Proyecto 2/Codigo/compiladores-parser/src/Analizadores/ejecutableSolidity.txt");
            Lexer lexico = new Lexer(new BufferedReader(new FileReader(file)));
            analisis_sintactico sintactico = new analisis_sintactico(lexico);
            System.out.println("---- Inicio ----");
            sintactico.parse();
            System.out.println("---- Final ----");
            System.out.println("---- Tokens ----");
            accessToken(lexico);
            // System.out.println(sintactico.resultado);
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}