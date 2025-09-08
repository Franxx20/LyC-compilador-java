package lyc.compiler.files;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateValidator {
    public static Boolean isValidDate(String day, String month, String year) {
        String date = day + "-" + month + "-" + year;

        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
        dateFormat.setLenient(false);

        try {
            Date parsedDate = dateFormat.parse(date);
            System.out.println(
                    "Valid date format: "
                            + dateFormat.format(parsedDate));
            return true;
        }
        catch (ParseException e){
            System.out.println("Invalid date format.");
            return false;
        }
    }
}
