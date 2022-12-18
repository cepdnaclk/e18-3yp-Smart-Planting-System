import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class plant {
    public static void main(String[] args) {
        String line = "";
        String splitBy = ",";
        try {
            try (// parsing a CSV file into BufferedReader class constructor
            BufferedReader br = new BufferedReader(new FileReader("plants.csv"))) {
                while ((line = br.readLine()) != null) // returns a Boolean value
                {
                    String[] plants = line.split(splitBy); // use comma as separator
                    System.out.println("CALL AddPlantToDB(\"" + plants[0] + "\", \"" + plants[1] + "\", " + plants[2] + ", \"" + plants[3] + "\", \"" + plants[4] + "\", \"" + plants[5] + "\", \"" + plants[6] + "\", \"" + plants[7] 
                    + "\", " + plants[8] + ", " + plants[9] + ", " + plants[10] + ", " + plants[11] + ", " + plants[12] + ");");
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
// CREATE PROCEDURE AddPlantToDB(IN cName VARCHAR(150), IN sciName VARCHAR(200), IN pHeight INT,
// IN pHabit VARCHAR(20), IN pGrowth VARCHAR(1), IN pShade VARCHAR(3), IN pSoil VARCHAR(3), IN pSoilMoist VARCHAR(4),
// IN pMinTemp INT, IN pMaxTemp INT, IN pMinPH DECIMAL(2, 1), IN pMaxPH DECIMAL(2, 1), IN pEdible BOOLEAN)

// CALL AddPlantToDB("cName", "sciName", height, "habit", "growth", "shade", "pSoil", "pSoilMoist", "pMintemp", );