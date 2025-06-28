package lyc.compiler.files;

import java.util.ArrayList;
import java.util.List;

public class TripleManager {
    private static List<Triple> triples = new ArrayList();

    public TripleManager() {
    }

    public static int addTriple(String operator, Object operand1, Object operand2) {
        triples.add(new Triple(
                operator,
                operand1 != null ? operand1.toString() : "_",
                operand2 != null ? operand2.toString() : "_"));
        return triples.size() - 1;
    }

    public static void patchTriple(int index, int jump) {
        if (index >= 0 && index < triples.size()) {
            Triple t = (Triple)triples.get(index);
            String jumpStr = Integer.toString(jump);
            t.setOperand1("[" + jumpStr + "]");
        } else {
            throw new IndexOutOfBoundsException("Índice de triple inválido: " + index);
        }
    }

    public static int getLastIndex() {
        return triples.isEmpty() ? -1 : triples.size() - 1;
    }

    public static List<Triple> getTriples() {
        return new ArrayList<>(triples);
    }

    public static void reset() {
        triples.clear();
    }

    public static class Triple {
        private String operator;
        private String operand1;
        private String operand2;

        public Triple(String operator, String operand1, String operand2) {
            this.operator = operator;
            this.operand1 = operand1;
            this.operand2 = operand2;
        }

        public String getOperator() {
            return this.operator;
        }

        public String getOperand1() {
            return this.operand1;
        }

        public String getOperand2() {
            return this.operand2;
        }

        private void setOperand1(String operand1) {
            this.operand1 = operand1;
        }
    }
}