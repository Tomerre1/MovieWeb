package ObserverObservable;
import ReadWriteLock.Moked;
import components.Vehicle;
import java.util.Observable;
import java.util.Observer;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;


public class BigBrother implements Observer {
    private static volatile BigBrother instance = null;
    private static int num_of_report;
    private Moked My_Moked=Moked.getInstance();

    private BigBrother(){}

    /**
     * Returns single instance of big brother
     * @return BigBrother
     */
    public static BigBrother getInstance(){
        if (instance == null)
            synchronized(BigBrother.class){
                if (instance == null)
                    instance = new BigBrother();
            }
        return instance;
    }

    /**
     * Method used to update the Moked of new report
     * @param o
     * @param arg
     */
    @Override
    public void update(Observable o, Object arg) {
        Vehicle Veh=(Vehicle)o;
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Date date = new Date();
        double AvgSpeed = (Veh.getLastRoad().calcLength()/Veh.getLastRoad().calcEstimatedTime(Veh));
        if(AvgSpeed<Veh.getActualSpeed()){
            num_of_report++;
            try {
                My_Moked.setReport(("Vehicle #"+Veh.getId()+" Report number: "+num_of_report + " Time: "+formatter.format(date)));
                Veh.addReport(("Vehicle #"+Veh.getId()+" Report number: "+num_of_report + " Time: "+formatter.format(date)));
            }
            catch (IOException e) {}
            System.out.println("The report sent to the car #"+Veh.getId()+" at "+formatter.format(date)+", please check it out at " + My_Moked.getPath()+" and confirm.");
        }
    }
}
