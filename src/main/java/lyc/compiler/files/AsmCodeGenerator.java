package lyc.compiler.files;

import java.io.FileWriter;
import java.io.IOException;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

public class AsmCodeGenerator implements FileGenerator {
    private static List<TripleManager.Triple> triples;
    private static Hashtable<String, SymbolTableGenerator.SymbolT> symbolTable;

    public void generate(List<TripleManager.Triple> triples, Hashtable<String, SymbolTableGenerator.SymbolT> symbolTable) {
        AsmCodeGenerator.triples = triples;
        AsmCodeGenerator.symbolTable = symbolTable;

        try (FileWriter fileWriter = new FileWriter("final.asm")) {
            generate(fileWriter);
        } catch (IOException e) {
            throw new RuntimeException("Error al generar el ASM", e);
        }
    }

    @Override
    public void generate(FileWriter fileWriter) throws IOException {
        fileWriter.write(generateHeader());
        fileWriter.write(generateDataSection());
        fileWriter.write(generateCode());
        fileWriter.write(generateFooter());
    }

    private String generateHeader() {
        return "include number.asm\n"
                + "include macros2.asm\n\n"
                + ".MODEL LARGE\n"
                + ".386\n"
                + ".STACK 200h\n\n"
                + "MAXTEXTSIZE equ 50\n\n";
    }

    private String generateDataSection() {
        StringBuilder sb = new StringBuilder();
        sb.append(".DATA\n");

        for (Map.Entry<String, SymbolTableGenerator.SymbolT> entry : symbolTable.entrySet()) {
            SymbolTableGenerator.SymbolT symbol = entry.getValue();
            String name = symbol.getName();
            String type = symbol.getType();
            String value = symbol.getValue();
            int size = symbol.getSymbolSize();

            if (type.equals("string")) {
                if (value == null){
                    sb.append(String.format("\t%s\tdb\tMAXTEXTSIZE dup (?), '$'\n", name));
                }
                else{
                    sb.append(String.format("\t%s\tdb\t%s, '$', %d dup (?)\n", name, value, 50-size));
                }
            } else if (type.equals("float")) {
                if (value != null) {
                    sb.append(String.format("\t%s\tdd\t%s\n", name, value));
                } else {
                    sb.append(String.format("\t%s\tdd\t?\n", name));
                }
            } else if (type.equals("int")) {
                if (value != null) {
                    sb.append(String.format("\t%s\tdd\t%s\n", name, value));
                } else {
                    sb.append(String.format("\t%s\tdd\t?\n", name));
                }
            }
        }

        return sb.toString();
    }

    private String generateCode() {
        StringBuilder code = new StringBuilder();

        code.append(".CODE\n\n")
                .append("start:\n")
                .append("\tMOV EAX,@DATA\n")
                .append("\tMOV DS,EAX\n")
                .append("\tMOV ES,EAX\n\n");

        for (TripleManager.Triple triple : triples) {
            String operator = triple.getOperator();
            String operand1 = triple.getOperand1();
            String operand2 = triple.getOperand2();

            switch (operator) {
                case "+":
                    code.append(handleArithmetic(operand1, operand2));
                    code.append("\tFADD\n");
                    break;
                case "-":
                    code.append(handleArithmetic(operand1, operand2));
                    if (!operand2.equals("_"))
                        code.append("\tFSUB\n");
                    break;
                case "*":
                    code.append(handleArithmetic(operand1, operand2));
                    code.append("\tFMUL\n");
                    break;
                case "/":
                    code.append(handleArithmetic(operand1, operand2));
                    code.append("\tFDIV\n");
                    break;
                case "=":
                    code.append(handleAssignment(operand1, operand2));
                    break;
                case "CMP":
                    code.append(handleComparison(operand1, operand2));
                    break;
                case "BGE":
                    code.append("\tJAE");
                    code.append(handleJump(operand1));
                    break;
                case "BLE":
                    code.append("\tJBE");
                    code.append(handleJump(operand1));
                    break;
                case "BGT":
                    code.append("\tJA");
                    code.append(handleJump(operand1));
                    break;
                case "BLT":
                    code.append("\tJB");
                    code.append(handleJump(operand1));
                    break;
                case "BNE":
                    code.append("\tJNE");
                    code.append(handleJump(operand1));
                    break;
                case "BEQ":
                    code.append("\tJE");
                    code.append(handleJump(operand1));
                    break;
                case "BI":
                    code.append("\tJMP");
                    code.append(handleJump(operand1));
                    break;
                case "ET":
                    code.append(handleET(operand1, triples.indexOf(triple)));
                    break;
                case "WRITE":
                    code.append(handleWrite(operand1));
                    break;
                case "READ":
                    code.append(handleRead(operand1));
                    break;
                case ",":
                    code.append(handleReorder(operand1));
                    break;
                default:
                    break;
            }
        }

        return code.toString();
    }


    private String handleArithmetic(String operand1, String operand2) {
        return loadOperand(operand1) + loadOperand(operand2);
    }

    private String loadOperand(String operand) {
        StringBuilder sb = new StringBuilder();

        if (operand.startsWith("[")) {
            int index = Integer.parseInt(operand.replaceAll("[\\[\\]]", ""));
            TripleManager.Triple t = triples.get(index);
            String op = t.getOperator();
            // Si el operador no es  es una variable o constante
            if (symbolTable.get(op) != null) {
                String type = symbolTable.get(op).getType();
                sb.append(type.equals("int") ? "\tFILD\t" : "\tFLD\t").append(op).append("\n");
            }
        } else if (operand.startsWith("@")) {
            // Lógica para operandos como @sum y @mult
            sb.append(String.format("\tFLD\t%s\n", operand));
        } else if (operand.startsWith("_") && operand.length() > 1) {
            // Este puede pasar cuando hay un numero negativo, ej: [16] = (-, _99999.99, _)
            sb.append(String.format("\tFLD\t_menosUno\n\tFLD\t%s\n\tFMUL\n", operand, operand));
        }

        return sb.toString();
    }

    private String handleAssignment(String operand1, String operand2) {
        StringBuilder sb = new StringBuilder();

        if (operand2.startsWith("[")) {
            int index = Integer.parseInt(operand2.replaceAll("[\\[\\]]", ""));
            TripleManager.Triple t = triples.get(index);
            String op = t.getOperator();
            // Si el operador no es una variable o constante
            if (symbolTable.get(op) != null) {
                String type = symbolTable.get(op).getType();

                if (type.equals("int")) {
                    sb.append("\tFILD\t").append(op).append("\n");
                } else if (type.equals("float")) {
                    sb.append("\tFLD\t").append(op).append("\n");
                } else {
                    sb.append(String.format("\tMOV\tSI,\tOFFSET\t%s\n", op));
                    sb.append(String.format("\tMOV\tSI,\tOFFSET\t%s\n", operand1));
                    sb.append("\tSTRCPY\n");
                    return sb.toString();
                }
            }

            sb.append(String.format("\tFSTP\t%s\n", operand1));
        }
        else if (operand2.startsWith("_")){ // Asignaciones String tipo a = "perro"
            sb.append(String.format("\tMOV\tSI,\tOFFSET\t%s\n", operand2));
            sb.append(String.format("\tMOV\tSI,\tOFFSET\t%s\n", operand1));
            sb.append("\tSTRCPY\n");
        }
        else if (operand2.startsWith("@") || operand2.equals("0") || operand2.equals("1")) { // Los casos @x = @y
            sb.append(String.format("\tFLD\t%s\n", operand2));
            sb.append(String.format("\tFSTP\t%s\n", operand1));
        }

        return sb.toString();
    }

    private String handleComparison(String operand1, String operand2) {
        return loadOperand(operand1) +
                (operand2.equals("0")? "\tFLDZ\n": loadOperand(operand2)) +
                "\tFXCH\n\tFCOMP\n\tFSTSW\tAX\n\tSAHF\n\tFFREE\n";

    }

    private String handleJump(String operand) {
        int id = Integer.parseInt(operand.replaceAll("[\\[\\]]", ""));
        return "\t" + triples.get(id).getOperand1() + id + "\n";
    }

    private String handleET(String operand, int id) {
        return operand + id + ":\n";
    }

    private String handleRead(String operand1) {
        StringBuilder sb = new StringBuilder();

        String type = symbolTable.get(operand1).getType();

        switch (type) {
            case "string" -> sb.append(String.format("\tGetString\t%s\n", operand1));
            case "int" -> sb.append(String.format("\tGetInt\t%s\n", operand1));
            case "float" -> sb.append(String.format("\tGetFloat\t%s\t, 2\n", operand1));
        }

        return sb.toString();

    }

    private String handleWrite(String operand) {
        StringBuilder sb = new StringBuilder();

        String type = symbolTable.get(operand).getType();

        switch (type) {
            case "string" -> sb.append(String.format("\tDisplayString\t%s\n", operand));
            case "int" -> sb.append(String.format("\tDisplayInt\t%s\n", operand));
            case "float" -> sb.append(String.format("\tDisplayFloat\t%s\t, 2\n", operand));
        }
        sb.append("\tnewline 1\n");
        return sb.toString();

    }

    private String handleReorder(String operand){
        return String.format("\tDisplayFloat\t%s\t, 2\n", operand);
    }

    private String generateFooter() {
        return "\tMOV EAX, 4C00h\n"
                + "\tINT 21h\n\n"
                + "\tEND start";
    }
}