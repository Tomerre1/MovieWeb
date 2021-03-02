/**
 * @author Tomer Revah 205775083, Ilia Kulmin 320722184
 *
 */
package components;
import Builder.Map;
import FactoryMethod_FactoryMethodAbstract.Wheels;
import GUI.myPanel;
import Mediator.Mediator;
import ObserverObservable.BigBrother;
import ReadWriteLock.Moked;
import utilities.Timer;
import utilities.Utilities;
import utilities.VehicleType;
import java.awt.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Observable;
import java.util.concurrent.ThreadLocalRandom;
/**
 * @author Sophie Krimberg
 *
 */
/**
 * @author krsof
 *
 */
public class Vehicle extends Observable implements Wheels,Utilities, Timer,Runnable,Cloneable {
	private int id;
	private VehicleType vehicleType;
	private Route currentRoute;
	private RouteParts currentRoutePart;
	private int timeFromRouteStart;
	private static int objectsCount=1;
	private int timeOnCurrentPart;
	private Road lastRoad;
	private String status;
	private Color vehicleColor;
	private static myPanel drawPanel;
	private static boolean stop=false;
	private double SpeedMultiply;
	private double ActualSpeed;
	private Moked moked=Moked.getInstance();
	private ArrayList<String> ReportsDriver;

	/**
	 * Constructor
	 * @param currentLocation
	 */
	public Vehicle (Road currentLocation) {
		ReportsDriver=new ArrayList<>();
		vehicleColor=Color.BLUE;
		id=objectsCount++;
		vehicleType=currentLocation.getVehicleTypes()[getRandomInt(0,currentLocation.getVehicleTypes().length-1)];
		System.out.println();
		successMessage(this.toString());
		currentRoute=new Route(currentLocation, this); //creates a new route for the vehicle and checks it in
		lastRoad=currentLocation;
		status=null;
	}

	/**
	 * Constructor
	 * @param type
	 */
	public Vehicle (VehicleType type) {
		ReportsDriver=new ArrayList<>();
		vehicleColor=Color.BLUE;
		id=objectsCount++;
		vehicleType=type;
		SpeedMultiply= ThreadLocalRandom.current().nextDouble(1,1.5);
		ActualSpeed=this.vehicleType.getAverageSpeed()*SpeedMultiply*10;
		System.out.println();
		successMessage(toString());
		Road currentLocation;
		while(true) {
			currentLocation = Map.getRoads().get(getRandomInt(0, Map.getRoads().size()));
			if (currentLocation.getEnabled()) break;
		}
		currentRoute=new Route(currentLocation, this); //creates a new route for the vehicle and checks it in
		lastRoad=currentLocation;
		status=null;
		addObserver(BigBrother.getInstance());
	}

	/**
	 * Constructor
	 * @param other
	 */
	public Vehicle(Vehicle other){
		ReportsDriver=new ArrayList<>();
		vehicleColor=other.getVehicleColor();
		id=other.id;
		vehicleType=other.getVehicleType();
		System.out.println();
		successMessage(this.toString());
		currentRoute=other.currentRoute;
		lastRoad=other.lastRoad;
		status=null;
		SpeedMultiply = other.SpeedMultiply;
		ActualSpeed = other.getActualSpeed();
		addObserver(BigBrother.getInstance());
	}

	/**
	 * Add new report to vehicle
	 * @param Report
	 */
	public void addReport(String Report) {
		ReportsDriver.add(Report);
		Moked.getTotalReports().add(Report);
	}

	/**
	 * Remove report from vehicle
	 * @param Report
	 */
	public void removeReport(String Report){
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		Date date = new Date();
		ReportsDriver.remove(Report);
		System.out.println(Report+ " Report Payed by Vehicle #" + getId() + " Time Payed: "+ formatter.format(date));
	}

	/**
	 * Approve given report in Moked
	 */
	public void ApproveReadReport() {
		if(ReportsDriver.size()>0) {
			for (int i = 0; i < ReportsDriver.size(); i++)
				moked.ReadReport(this, ReportsDriver.get(i));
			}
	}

	/**
	 * Set vehicle speed
	 * @param mode
	 */
	public void setSpeed(String mode){
		if("CITY".equalsIgnoreCase(mode)) {
			SpeedMultiply=ThreadLocalRandom.current().nextDouble(1, 1.3);
			ActualSpeed = this.vehicleType.getAverageSpeed() * SpeedMultiply * 10;
		}
		else if("COUNTRY".equalsIgnoreCase(mode)){
			SpeedMultiply=ThreadLocalRandom.current().nextDouble(1, 1.5);
			ActualSpeed = this.vehicleType.getAverageSpeed() * SpeedMultiply * 10;
		}
	}

	/**
	 * Method that upgrade the vehicle with new ID and new route
	 */
	public void makeAdvanced() {
		id=objectsCount++;
		Road currentLocation;
		while (true) {
			currentLocation = Map.getRoads().get(getRandomInt(0, Map.getRoads().size()));
			if (currentLocation.getEnabled()) break;
		}
		currentRoute = new Route(currentLocation, this);
	}

	/**
	 * Method using copy constructor on vehicle
	 * @return Vehicle
	 */
	public Vehicle clone() { return new Vehicle(this); }

	/**
	 * Get speed multiply parameter
	 * @return double
	 */
	public double getSpeedMultiply() {
		return SpeedMultiply;
	}

	/**
	 * Set speed multiply parameter
	 * @param speedMultiply
	 */
	public void setSpeedMultiply(double speedMultiply) {
		SpeedMultiply = speedMultiply;
	}

	/**
	 * Set actual car speed
	 * @param actualSpeed
	 */
	public void setActualSpeed(double actualSpeed) {
		ActualSpeed = actualSpeed;
	}

	/**
	 * Stops vehicles' thread operation
	 * @param stop
	 */
	public static void setStop(boolean stop) {Vehicle.stop = stop;}

	/**
	 * Runs Vehicle threads
	 */
	@Override
	public void run() {
		while(true) {
			incrementDrivingTime();
			try {
				Thread.sleep(100);
			}
			catch(InterruptedException e){e.printStackTrace();}
			if(getRandomBoolean())
				ApproveReadReport();
			if (stop){
					synchronized (this)
					{
						try {
							this.wait();
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
					}
				}
		}
	}

	/**
	 * Get vehicles' color
	 * @return color
	 */
	public Color getVehicleColor() {return vehicleColor;}

	public void setVehicleColor(Color vehicleColor) {
		this.vehicleColor = vehicleColor;
	}

	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(int id) {this.id = id;}



	/**
	 * @return the vehicleType
	 */
	public VehicleType getVehicleType() {
		return vehicleType;
	}




	/**
	 * @param vehicleType the vehicleType to set
	 */
	public void setVehicleType(VehicleType vehicleType) {
		this.vehicleType = vehicleType;
	}




	/**
	 * @return the currentRoute
	 */
	public Route getCurrentRoute() {
		return currentRoute;
	}




	/**
	 * @param currentRoute the currentRoute to set
	 */
	public void setCurrentRoute(Route currentRoute) {
		this.currentRoute = currentRoute;
	}




	/**
	 * @return the currentRoutePart
	 */
	public RouteParts getCurrentRoutePart() {
		return currentRoutePart;
	}




	/**
	 * @param currentRoutePart the currentRoutePart to set
	 */
	public void setCurrentRoutePart(RouteParts currentRoutePart) {
		this.currentRoutePart = currentRoutePart;
	}




	/**
	 * @return the timeFromRouteStart
	 */
	public int getTimeFromRouteStart() {
		return timeFromRouteStart;
	}




	/**
	 * @param timeFromRouteStart the timeFromRouteStart to set
	 */
	public void setTimeFromRouteStart(int timeFromRouteStart) {
		this.timeFromRouteStart = timeFromRouteStart;
	}




	/**
	 * @return the timeOnCurrentPart
	 */
	public int getTimeOnCurrentPart() {
		return timeOnCurrentPart;
	}




	/**
	 * @param timeOnCurrentPart the timeOnCurrentPart to set
	 */
	public void setTimeOnCurrentPart(int timeOnCurrentPart) {
		this.timeOnCurrentPart = timeOnCurrentPart;
	}




	/**
	 * @return the lastRoad
	 */
	public Road getLastRoad() {
		return lastRoad;
	}




	/**
	 * @param lastRoad the lastRoad to set
	 */
	public void setLastRoad(Road lastRoad) {
		this.lastRoad = lastRoad;
	}




	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}




	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}




	/**
	 * @return the objectsCount
	 */
	public static int getObjectsCount() {
		return objectsCount;
	}


	/**
	 * Increment the driving time
	 */
	@Override
	public void incrementDrivingTime() {
		timeFromRouteStart++;
		timeOnCurrentPart++;
		move();
	}
	
	/**controls the vehicle moving from one route part to the next one
	 * 
	 */
	public void move() {
		if (currentRoutePart.canLeave(this)) {
			currentRoutePart.checkOut(this);
			currentRoute.findNextPart(this).checkIn(this);
				if (currentRoutePart instanceof Junction) {
					setChanged();
					notifyObservers();
				}
		}
		else {
			currentRoutePart.stayOnCurrentPart(this);
		}
	}

	public double getActualSpeed() {
		return ActualSpeed;
	}

	/**
	 * Return objects' string
	 * @return String
	 */
	@Override
	public String toString() {
		return new String("Vehicle "+id+": "+ getVehicleType().name()+", average speed: "+ ActualSpeed);
	}
	
	@Override
	public boolean equals(Object obj) {
		if (obj == null) return false; 
	    if (getClass() != obj.getClass()) return false; 
	    if (! super.equals(obj)) return false;
		Vehicle other=(Vehicle)obj;
		if (this.currentRoute!=other.currentRoute||
			this.currentRoutePart!=other.currentRoutePart||
			this.id!=other.id||
			this.lastRoad!=other.lastRoad||
			this.status!=other.status||
			this.timeFromRouteStart!=other.timeFromRouteStart||
			this.timeOnCurrentPart!=other.timeOnCurrentPart||
			this.vehicleType!=other.vehicleType)
				return false;
		return true;
	}

	/**
	 * @param objectsCount the objectsCount to set
	 */
	public static void setObjectsCount(int objectsCount) { Vehicle.objectsCount = objectsCount;}

	/**
	 * Set the draw panel on which the vehicles are drawn
	 * @param draw
	 */
	public static void setDrawPanel(myPanel draw) {
		Vehicle.drawPanel=draw;
	}
}
