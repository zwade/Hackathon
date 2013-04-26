import java.io.Console;
import java.io.PrintStream;

class Authenticator
{

    public Authenticator()
    {
    }

    public static void main(String args[])
    {
        key = new char[10];
        key[0] = 'c';
        key[1] = 'g';
        key[2] = 'k';
        key[3] = 'h';
        key[4] = 'u';
        key[5] = 'u';
        key[6] = 'w';
        key[7] = 'g';
        key[8] = 'h';
        key[9] = 'd';
        Console console = System.console();
        for(String s = ""; !s.equals("ThisistheMag1calstring"); s = console.readLine("Enter password:", new Object[0]));
        for(int i = 0; i < key.length; i++)
            System.out.print(key[i]);

        System.out.println("");
    }

    public static char key[];
}