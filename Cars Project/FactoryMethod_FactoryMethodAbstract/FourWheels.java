package FactoryMethod_FactoryMethodAbstract;

import components.Vehicle;
import utilities.VehicleType;

public class FourWheels implements abstractFactory {
    private Wheels newVehicle=null;

    /**
     * Return vehicle object that match entered string
     * @param type
     * @return Vehicle
     */
    public Wheels getVehicle(String type) {
        if("PRIVATE".equalsIgnoreCase(type)) newVehicle=new Vehicle(VehicleType.car);

        else if("WORK".equalsIgnoreCase(type)) newVehicle=new Vehicle(VehicleType.truck);

        else if("PUBLIC".equalsIgnoreCase(type)) newVehicle=new Vehicle(VehicleType.bus);

        return newVehicle;
    }
}

