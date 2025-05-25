package lyc.compiler.files;

public class Terceto {
    private String operador;
    private Terceto operando_izquierdo;
    private Terceto operando_derecho;

    public Terceto(String operador) {
        this.operador = operador;
        this.operando_izquierdo = null;
        this.operando_derecho = null;
    }

    public String getOperador() {
        return operador;
    }

    public Terceto(String operador, Terceto operando_izquierdo, Terceto operando_derecho) {
        this.operador = operador;
        this.operando_izquierdo = operando_izquierdo;
        this.operando_derecho = operando_derecho;
    }

    @Override
    public String toString() {
        return "(" + operador + " [" + operando_izquierdo + "]" +" ["+ operando_derecho +"] "+ " )";
    }
}
