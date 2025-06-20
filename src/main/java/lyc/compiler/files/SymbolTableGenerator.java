package lyc.compiler.files;

import lyc.compiler.model.DuplicatedVariableDefinitionException;

import java.io.FileWriter;
import java.io.IOException;
import java.util.Hashtable;
import java.util.Objects;

public class SymbolTableGenerator implements FileGenerator{
    private static Hashtable<String, SymbolT> symbolTable = new Hashtable<String, SymbolT>(100);

    public static class SymbolT {
        private String name;
        private String type;
        private String value;
        private int symbolSize;

        // string constants
        public SymbolT(String name, String type, String value, int symbolSize) {
            this.name = name;
            this.type = type;
            this.value = value;
            this.symbolSize = symbolSize;
        }

        // float and integer constant
        public SymbolT(String name, String type, String value) {
            this.name = name;
            this.type = type;
            this.value = value;
        }

        // variables
        public SymbolT(String name, String type) {
            this.name = name;
            this.type = type;
        }

        @Override
        public int hashCode() {
            return Objects.hash(name, type, value, symbolSize);
        }

        @Override
        public String toString() {
            return  "name='" + name + '\'' +
                    ", type='" + type + '\'' +
                    ", value='" + value + '\'' +
                    ", symbolSize=" + symbolSize +
                    "\n";
        }

        public String getName() {
            return name;
        }

        public String getType(){
            return this.type;
        }

        public String getValue() { return value; }

        public int getSymbolSize() { return symbolSize; }


        @Override
        public boolean equals(Object o) {
            if (!(o instanceof SymbolT symbolT)) return false;
            return symbolSize == symbolT.symbolSize && Objects.equals(name, symbolT.name) && Objects.equals(type, symbolT.type) && Objects.equals(value, symbolT.value);
        }
    }

    @Override
    public void generate(FileWriter fileWriter) throws IOException {
        fileWriter.write("name | type | value | symbolSize\n");

        for (SymbolT symbolT : symbolTable.values()) {
            fileWriter.write(symbolT.toString());
        }
    }

    static public void insertNonStringConstant(String name, String type) {
        symbolTable.put(name, new SymbolT(name, type, name.replace("_","")));
    }

    static public void insertStringConstant(String name, String type, String value, int symbolSize) {
        symbolTable.put(name, new SymbolT(name, type, value, symbolSize));
    }

    static public void insertVariable(String name, String type) throws DuplicatedVariableDefinitionException {
        _insertVariable(name, type);
    }

    static private void _insertVariable(String name, String type) throws DuplicatedVariableDefinitionException {
        if (symbolTable.containsKey(name)) {
            throw new DuplicatedVariableDefinitionException("Variable = " + name + " was already defined.");
        }
        symbolTable.put(name, new SymbolT(name, type));
    }

    static public SymbolT getSymbol(String name){
        return symbolTable.get(name);
    }

    public static Hashtable<String, SymbolT> getTable() {
        return symbolTable;
    }
}


