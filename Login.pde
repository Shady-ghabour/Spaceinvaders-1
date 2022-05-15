//LOGIN
import de.bezier.data.sql.*;
import de.bezier.data.sql.mapper.*;
import static javax.swing.JOptionPane.*;
import javax.swing.JPasswordField;

SQLite db;

String initUser = showInputDialog("Opret username:");
String initPass = showInputDialog("Opret password:");
String insert = "INSERT INTO players (Username,Password) VALUES ('" + initUser + "', '" + initPass + "');";
String input = showInputDialog("Indtast dit brugernavn:");
String pwinput = showInputDialog("Indtast dit password:");
String check = "SELECT * FROM players WHERE Username='" + input + "' AND Password='" + pwinput + "';";
boolean isLogged = false;
