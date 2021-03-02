package FactoryMethod_FactoryMethodAbstract;

import components.Vehicle;
import utilities.VehicleType;

public class TenWheels implements abstractFactory {
    private Wheels newVehicle=null;

    /**
     * Return vehicle object that match entered string
     * @param type
     * @return Vehicle
     */
    public Wheels getVehicle(String type) {
        if("WORK".equalsIgnoreCase(type)) newVehicle=new Vehicle(VehicleType.semitrailer);

        else if("PUBLIC".equalsIgnoreCase(type)) newVehicle=new Vehicle(VehicleType.tram);

        return newVehicle;
    }
}
