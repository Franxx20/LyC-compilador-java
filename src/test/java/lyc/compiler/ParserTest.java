package lyc.compiler;

import java_cup.runtime.Symbol;
import lyc.compiler.factories.ParserFactory;
import org.apache.commons.io.IOUtils;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import static com.google.common.truth.Truth.assertThat;
import static lyc.compiler.Constants.EXAMPLES_ROOT_DIRECTORY;
import static org.junit.jupiter.api.Assertions.assertThrows;

public class ParserTest {

    @Test
    public void testAll() throws Exception {
        compilationSuccessful(readFromFile("test.txt"));
    }

    @Disabled
    @Test
    public void reorderTest() throws Exception {
        compilationSuccessful(readFromFile("reorder.txt"));
    }

    @Disabled
    @Test
    public void negativeCalculationTest() throws Exception {
        compilationSuccessful(readFromFile("negativeCalculation.txt"));
    }

    @Disabled
    @Test
    public void assignmentWithExpression() throws Exception {
        compilationSuccessful("c=d*(e-21)/4");
    }

    @Disabled
    @Test
    public void syntaxError() {
        compilationError("1234");
    }

    @Disabled
    @Test
    void assignments() throws Exception {
        compilationSuccessful(readFromFile("assignments.txt"));
    }

    @Disabled
    @Test
    void write() throws Exception {
        compilationSuccessful(readFromFile("write.txt"));
    }

    @Disabled
    @Test
    void read() throws Exception {
        compilationSuccessful(readFromFile("read.txt"));
    }

    @Disabled
    @Test
    void comment() throws Exception {
        compilationSuccessful(readFromFile("comment.txt"));
    }

    @Disabled
    @Test
    void init() throws Exception {
        compilationSuccessful(readFromFile("init.txt"));
    }

    @Disabled
    @Test
    void and() throws Exception {
        compilationSuccessful(readFromFile("and.txt"));
    }

    @Disabled
    @Test
    void or() throws Exception {
        compilationSuccessful(readFromFile("or.txt"));
    }

    @Disabled
    @Test
    void not() throws Exception {
        compilationSuccessful(readFromFile("not.txt"));
    }

    @Disabled
    @Test
    void ifStatement() throws Exception {
        compilationSuccessful(readFromFile("if.txt"));
    }

    @Disabled
    @Test
    void whileStatement() throws Exception {
        compilationSuccessful(readFromFile("while.txt"));
    }

    private void compilationSuccessful(String input) throws Exception {
        assertThat(scan(input).sym).isEqualTo(ParserSym.EOF);
    }

    private void compilationError(String input){
        assertThrows(Exception.class, () -> scan(input));
    }

    private Symbol scan(String input) throws Exception {
        return ParserFactory.create(input).parse();
    }

    private String readFromFile(String fileName) throws IOException {
        InputStream inputStream = new FileInputStream(EXAMPLES_ROOT_DIRECTORY + "%s".formatted(fileName));
        return IOUtils.toString(inputStream, StandardCharsets.UTF_8);
    }
}
