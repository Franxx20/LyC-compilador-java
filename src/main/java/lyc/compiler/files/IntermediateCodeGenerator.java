package lyc.compiler.files;

import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Stack;

public class IntermediateCodeGenerator implements FileGenerator {
    private int lastIndex=0;
    private ArrayList<Terceto> tercetos;
    private Stack<Terceto> tercetoStack;

    @Override
    public void generate(FileWriter fileWriter) throws IOException {
        fileWriter.write("TODO");
    }

}
