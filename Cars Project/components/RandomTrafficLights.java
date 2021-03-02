/**
 * @author Tomer Revah 205775083, Ilia Kulmin 320722184
 *
 */
package components;
import java.util.ArrayList;

/**Represents the traffic lights with random choice of road that receives a green light
 * @author Sophie Krimberg
 *
 */
public class RandomTrafficLights extends TrafficLights {
	
	/**Constructor
	 * @param roads
	 */
	public RandomTrafficLights(ArrayList<Road> roads) {
		super(roads);
	}

	/**
	 * Change Random Traffic Lights green road light index
	 */
	@Override
	public void changeIndex() {this.setGreenLightIndex((getRandomInt(1,200))%this.getRoads().size());}
	/**
	 * Prints Random traffic lights object
	 * @return string
	 */
	@Override
	public String toString() {
		return new String("Random "+super.toString());
	}
}
