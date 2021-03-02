package Builder;
import FactoryMethod_FactoryMethodAbstract.JFactory;
import FactoryMethod_FactoryMethodAbstract.VehicleFactory;
import Prototype.WorkSpace;
import components.*;
import utilities.Utilities;

import java.util.ArrayList;

public class CountryBuilder implements MapBuilder, Utilities {
    private ArrayList<Road> roads;
    private ArrayList <Junction> junctions;
    private Map map;
    private int num;

    /**
     * Default constructor for building country
     * @param num
     */
    public CountryBuilder(int num){
        roads=new ArrayList<>();
        junctions=new ArrayList<>();
        map=new Map();
        this.num=num;
    }

    /**
     * Build roads for country
     */
    @Override
    public void buildRoads() {
        System.out.println("\n================= CREATING ROADS=================");
        for (int i=0; i<junctions.size();i+=2) {

            for (int j=0; j<junctions.size();j+=2) {
                if(i==j) { continue; }
                roads.add(new Road(junctions.get(i), junctions.get(j)));
            }
        }
        map.setRoads(roads);
        map.turnLightsOn();
    }

    /**
     * Build junctions for country
     */
    @Override
    public void buildJunctions() {
        System.out.println("\n================= CREATING JUNCTIONS=================");
        for(int i=0;i<6;i++) {
            Junction x= JFactory.getJunction("Country");
            junctions.add(x);
            if(x instanceof LightedJunction)
                map.getLights().add(((LightedJunction) x).getLights());
        }
        map.setJunctions(junctions);
    }

    /**
     * Build vehicle for country
     */
    @Override
    public void bulidVehicles() {
        System.out.println("\n================= CREATING VEHICLES=================");
        ArrayList <Vehicle> Type=new ArrayList<>();
        Type.add((Vehicle) VehicleFactory.getFactory(2).getVehicle("FAST"));
        Type.add((Vehicle) VehicleFactory.getFactory(10).getVehicle("WORK"));
        Type.add((Vehicle) VehicleFactory.getFactory(4).getVehicle("PRIVATE"));
        Type.add((Vehicle) VehicleFactory.getFactory(4).getVehicle("PUBLIC"));
        Type.add((Vehicle) VehicleFactory.getFactory(4).getVehicle("WORK"));
        Vehicle.setObjectsCount(1);
        for(int i=0;i<num;i++){
            Vehicle basicVehicle=Type.get(getRandomInt(0,Type.size())).clone();
            basicVehicle.setSpeed("Country");
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



