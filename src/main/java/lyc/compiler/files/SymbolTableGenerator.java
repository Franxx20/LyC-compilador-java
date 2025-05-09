package lyc.compiler.files;

import java.io.FileWriter;
import java.io.IOException;
import java.util.Hashtable;
import java.util.Objects;

public class SymbolTableGenerator implements FileGenerator{
    public static Hashtable<String, SymbolT> symbolTable = new Hashtable<String, SymbolT>(100);

    public static class SymbolT {
        public String name;
        public String type;
        public String value;
        public int symbolSize;


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

        public void setName(String name) {
            this.name = name;
        }

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

    static public void insertSymbol(String name, SymbolT symbolT) {
        symbolTable.put(name, symbolT);
    }

    static public void insertConstant(String name, String type) {
        symbolTable.put(name, new SymbolT(name, type, name.replace("_","")));
    }

    static public void insertVariable(String name, String type) {
        symbolTable.put(name, new SymbolT(name, type));
    }

    static public SymbolT getSymbol(String name){
        return symbolTable.get(name);
    }
}
