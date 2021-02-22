package Builder;
import components.Junction;
import components.Road;
import components.Vehicle;
import java.util.ArrayList;

public interface MapPlan {
    /**
     * Interface method for setting junctions
     * @param junctions
     */
    public void setJunctions(ArrayList<Junction> junctions);

    /**
     * Interface method for setting roads
     * @param roads
     */
    public void setRoads(ArrayList<Road> roads);

    /**
     * Interface method for setting vehicles
     * @param vehicles
     */
    public void setVehicles(ArrayList <Vehicle> vehicles);
}
