package lyc.compiler.files;

import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

public class IntermediateCodeGenerator implements FileGenerator {

    @Override
    public void generate(FileWriter fileWriter) throws IOException {
        List<TripleManager.Triple> triples = TripleManager.getTriples();
        for (int i = 0; i < triples.size(); i++) {
            TripleManager.Triple triple = triples.get(i);

            String line = String.format("[%d] = (%s, %s, %s)\n",
                    i,
                    triple.getOperator(),
                    triple.getOperand1(),
                    triple.getOperand2());
            fileWriter.write(line);
        }
        TripleManager.reset(); // Clear for next compilation
    }
}