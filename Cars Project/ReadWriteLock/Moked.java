package ReadWriteLock;
import Mediator.Mediator;
import statePattern.*;
import components.Vehicle;
import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;


public class Moked implements Mediator {
    private  File txt;
    private static final ReadWriteLock readWriteLock = new ReentrantReadWriteLock(true);
    private final Lock readLock = readWriteLock.readLock();
    private final Lock writeLock = readWriteLock.writeLock();
    private FileWriter fileWriter;
    private BufferedWriter bufferedWriter;
    private String line=null;
    private String path;
    private static Moked instance = null;
    private static ArrayList<String> TotalReports;
    public static ArrayList <String> ReadReportsButton;

    /**
     * Private Moked constructor
     */
    private Moked() {
        ReadReportsButton=new ArrayList<>();
        TotalReports=new ArrayList<>();
        txt=new File("reports.txt");
        if(!txt.exists())
            try{txt.createNewFile();}
            catch (IOException e){}
        path=txt.getAbsolutePath();
    }

    /**
     * Return single instance of Moked
     * @return Moked
     */
    public static Moked getInstance(){
        if(instance==null){
            instance=new Moked();
        }
        return instance;
    }

    /**
     * Returns path where the report file is stored
     * @return path
     */
    public String getPath() {return path;}

    /**
     * Set new report to file
     * @param Report
     * @throws IOException
     */
    public void setReport(String Report) throws IOException {
        writeLock.lock();
        try {
            fileWriter = new FileWriter(txt,true);
            bufferedWriter = new BufferedWriter(fileWriter);
            bufferedWriter.write(Report);
            ReadReportsButton.add(Report);
            bufferedWriter.newLine();
        }
        catch (FileNotFoundException x) { System.out.println("-----------File not found---------------"); }
        catch (IOException e) { System.out.println("-----------Error to open file---------------"); }
        finally {
            writeLock.unlock();
            bufferedWriter.close();
            fileWriter.close();
        }
    }

    /**
     * Remove given report from given vehicle and from all report list
     * @param veh
     * @param Report
     */
    public void ReadReport(Vehicle veh,String Report)  {
        readLock.lock();
        try
        {
            Scanner scanner = new Scanner(txt);
            while(scanner.hasNextLine()) {
                line = scanner.nextLine();
                if(line.equalsIgnoreCase(Report)){
                    veh.removeReport(line);
                    getTotalReports().remove(Report);
                    break;
                }
            }
        }
        catch (FileNotFoundException e) { System.out.println("-----------Error to open file---------------"); }
        finally {
            readLock.unlock();
        }
    }

    /**
     * Fully clear report file
     */
    public void clearReport(){
        txt.delete();
        txt=new File("reports.txt");
            try{
                txt.createNewFile();
            } catch (IOException e){}
        path=txt.getAbsolutePath();
    }

    /**
     * Return list of all reports
     * @return TotalReports
     */
    public static ArrayList<String> getTotalReports() { return TotalReports; }

}
