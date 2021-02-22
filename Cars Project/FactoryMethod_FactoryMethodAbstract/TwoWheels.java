package FactoryMethod_FactoryMethodAbstract;
import components.Vehicle;
import utilities.VehicleType;

public class TwoWheels implements abstractFactory {
    private Wheels newVehicle=null;

    /**
     * Return vehicle object that match entered string
     * @param type
     * @return Vehicle
     */
    public Wheels getVehicle(String type) {
        if("FAST".equalsIgnoreCase(type)) newVehicle=new Vehicle(VehicleType.motorcycle);

        else if("SLOW".equalsIgnoreCase(type)) newVehicle=new Vehicle(VehicleType.bicycle);

        return newVehicle;
    }
}
