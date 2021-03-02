package Builder;

public interface MapBuilder {
    /**
     * Interface method for building junctions
     */
    public void buildJunctions();
    /**
     * Interface method for building roads
     */
    public void buildRoads();
    /**
     * Interface method for building vehicles
     */
    public void bulidVehicles();
    /**
     * Interface method for getting map
     */
    public Map getMap();
}
