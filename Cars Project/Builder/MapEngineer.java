package Builder;

public class MapEngineer {
    private MapBuilder mapBuilder;

    /**
     * Constructor for map engineer
     * @param mapBuilder
     */
    public MapEngineer(MapBuilder mapBuilder){
        this.mapBuilder =  mapBuilder;
    }

    /**
     *
     * @return Map
     */
    public Map getMap() {return this.mapBuilder.getMap();}

    /**
     * Default constructor for map engineer
     */
    public void constructMap() {
        this.mapBuilder.buildJunctions();
        this.mapBuilder.buildRoads();
        this.mapBuilder.bulidVehicles();
    }
}
