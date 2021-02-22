package Prototype;

import components.Vehicle;

public class WorkSpace {
    /**
     * Method receive vehicle and upgrade it by makeAdvanced method
     * @param v
     * @return Vehicle (updated)
     */
    public Vehicle updateCar(Vehicle v) {
        v.makeAdvanced();
        return v;
    }
}
