package lyc.compiler.model;

public class DuplicatedVariableDefinitionException extends CompilerException {
    public DuplicatedVariableDefinitionException(String message) {
        super(message);
    }
}
