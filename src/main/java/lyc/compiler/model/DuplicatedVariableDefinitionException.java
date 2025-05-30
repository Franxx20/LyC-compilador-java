package lyc.compiler.model;

public class DuplicatedVariableDefinitionException extends RuntimeException {
  public DuplicatedVariableDefinitionException(String message) {
    super(message);
  }
}
