/**
 * @author Tomer Revah 205775083, Ilia Kulmin 320722184
 *
 */
package components;
import java.util.ArrayList;
import Builder.Map;
import GUI.mainFrame;
import GUI.myPanel;
import ReadWriteLock.Moked;
import statePattern.State;
import utilities.Timer;
import utilities.Utilities;
import statePattern.Approved;
import statePattern.NotApproved;

/**Traffic control game
 * @author Sophie Krimberg
 *
 */
public class Driving extends Thread implements Utilities, Timer {
	private Map map;
	private static ArrayList<Vehicle> vehicles;
	private int drivingTime;
	private static ArrayList<Timer> allTimedElements;
	private myPanel drawPanel;
	private static boolean stop;
	private statePattern.State myState;
	private Moked moked=Moked.getInstance();

	/**
	 * Constructor
	 */
	public Driving() {
		vehicles = new ArrayList<Vehicle>();
		allTimedElements = new ArrayList<Timer>();
		drivingTime = 0;
		map = new Map();
		Junction.setObjectsCount(1);
		myState=null;
	}

	/**
	 * Constructor
	 * @param junctionsNum
	 * @param numOfVehicles
	 */
	public Driving(int junctionsNum, int numOfVehicles) {
		vehicles=new ArrayList<Vehicle>();
		allTimedElements=new ArrayList<Timer>();
		drivingTime=0;
		map=new Map(junctionsNum);

		System.out.println("\n================= CREATING VEHICLES =================");

		while(vehicles.size()<numOfVehicles) {
			Road temp=map.getRoads().get(getRandomInt(0,map.getRoads().size()));//random road from the map
			if( temp.getEnabled())
				vehicles.add(new Vehicle(temp));
		}

		allTimedElements.addAll(vehicles);

		for (TrafficLights light: map.getLights()) {
			if (light.getTrafficLightsOn()) {
				allTimedElements.add(light);
			}
		}
	}

	/**
	 * Set stop
	 * @param b
	 */
	public static void setStop(boolean b) {stop=b;}

	/**
	 * Is driving stopped
	 * @return boolean
	 */
	public static boolean isStop() { return stop; }

	/**
	 * Set draw panel
	 * @param drawPanel
	 */
	public void setDrawPanel(myPanel drawPanel) {
		this.drawPanel = drawPanel;
	}

	/**
	 * @return the map
	 */
	public Map getMap() {
		return map;
	}

	/**
	 * @param map the map to set
	 */
	public void setMap(Map map) {
		this.map = map;
		allTimedElements.addAll(vehicles);
		for (TrafficLights light : map.getLights()) {
			if (light.getTrafficLightsOn()) {
				allTimedElements.add(light);
			}
		}
	}

	/**
	 * @return the vehicles
	 */
	public static ArrayList<Vehicle> getVehicles() {
		return vehicles;
	}

	/**
	 * @param vehicles the vehicles to set
	 */
	public void setVehicles(ArrayList<Vehicle> vehicles) {
		this.vehicles = vehicles;
	}

	/**
	 * @return the drivingTime
	 */
	public int getDrivingTime() {
		return drivingTime;
	}

	/**
	 * @param drivingTime the drivingTime to set
	 */
	public void setDrivingTime(int drivingTime) {
		this.drivingTime = drivingTime;
	}

	/**
	 * @return the allTimedElements
	 */
	public static ArrayList<Timer> getAllTimedElements() {
		return allTimedElements;
	}

	/**
	 * @param allTimedElements the allTimedElements to set
	 */
	public void setAllTimedElements(ArrayList<Timer> allTimedElements) {
		this.allTimedElements = allTimedElements;
	}

	/**
	 * method runs the game for given quantity of turns
	 *
	 * @param turns
	 */
	public void drive(int turns) {
		System.out.println("\n================= START DRIVING=================");
		drivingTime = 0;
		for (int i = 0; i < turns; i++) {
			incrementDrivingTime();
		}
	}

	/**
	 * Creates Approved/NotApproved instance
	 */
	public void CheckState(){ myState = (Moked.getTotalReports().size() == 0) ? new Approved() : new NotApproved(); }

	/**
	 * Increments the driving time
	 */
	@Override
	public void incrementDrivingTime() {
		int i = 0;
		System.out.println("\n***************TURN " + drivingTime++ + "***************");
		System.out.println(allTimedElements);
		for (Timer element : allTimedElements) {
			System.out.println(element);
			new Thread((Runnable) element).start();
			System.out.println();
		}
	}

	/**
	 * Resume the stopped vehicles and traffic lights
	 */
	public synchronized void setResume() {
		TrafficLights.setStop(false);
		Vehicle.setStop(false);
		Driving.setStop(true);
		notify();
		for (Timer t : getAllTimedElements()) {
			synchronized (t){
				t.notify();
			}
		}
	}

	/**
	 * Return objects' string
	 * @return String
	 */
	@Override
	public String toString() {
		return "Driving [map=" + map + ", vehicles=" + vehicles + ", drivingTime=" + drivingTime + ", allTimedElements="
				+ allTimedElements + "]";
	}

	/**
	 * Return drivings' state
	 * @return state
	 */
	public statePattern.State getMyState() {
		return myState;
	}

	/**
	 * Run driving threads
	 */
	@Override
	public void run() {
		incrementDrivingTime();
		while (true) {
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			CheckState();
			drawPanel.repaint();
			if(!isStop()){
				synchronized (this){
					try {
						this.wait();
					}
					catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
}
