package Builder;
import Prototype.WorkSpace;
import utilities.*;
import FactoryMethod_FactoryMethodAbstract.JFactory;
import FactoryMethod_FactoryMethodAbstract.VehicleFactory;
import components.*;
import java.util.ArrayList;

public class CityBuilder implements MapBuilder,Utilities {
    private ArrayList<Road> roads;
    private ArrayList <Junction> junctions;
    private Map map;
    private int num;

    /**
     * Default constructor for building city
     * @param x
     */
    public CityBuilder(int x){
        roads=new ArrayList<>();
        junctions=new ArrayList<>();
        map=new Map();
        num=x;
    }

    /**
     * Build roads for city
     */
    @Override
    public void buildRoads() {
        System.out.println("\n================= CREATING ROADS=================");

        for (int i=0; i<junctions.size();i++) {

            for (int j=0; j<junctions.size();j++) {

                if(i==j) {
                    continue;
                }

                roads.add(new Road(junctions.get(i), junctions.get(j)));
            }
        }
        map.setRoads(roads);
        map.turnLightsOn();
    }

    /**
     * Build junctions for city
     */
    @Override
    public void buildJunctions() {
        for(int i=0;i<12;i++) {
            LightedJunction x= (LightedJunction) JFactory.getJunction("City");
            junctions.add(x);
            map.getLights().add(x.getLights());
        }
        map.setJunctions(junctions);
    }

    /**
     * Build vehicle for city
     */
    @Override
    public void bulidVehicles() {
        System.out.println("\n================= CREATING VEHICLES=================");
        ArrayList <Vehicle> Type=new ArrayList<>();
        Type.add((Vehicle) VehicleFactory.getFactory(2).getVehicle("FAST"));
        Type.add((Vehicle) VehicleFactory.getFactory(2).getVehicle("SLOW"));
        Type.add((Vehicle) VehicleFactory.getFactory(4).getVehicle("PRIVATE"));
        Type.add((Vehicle) VehicleFactory.getFactory(4).getVehicle("PUBLIC"));
        Type.add((Vehicle) VehicleFactory.getFactory(10).getVehicle("PUBLIC"));
        Vehicle.setObjectsCount(1);
        for(int i=0;i<num;i++){
            Vehicle basicVehicle=Type.get(getRandomInt(0,Type.size())).clone();
            basicVehicle.setSpeed("City");
            WorkSpace WorkPlace=new WorkSpace();
            Driving.getVehicles().add(WorkPlace.updateCar(basicVehicle));
        }
    }

    /**
     * Get map
     * @return Map
     */
    @Override
    public Map getMap() {
        return map;
    }
}
