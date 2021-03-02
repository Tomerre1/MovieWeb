package FactoryMethod_FactoryMethodAbstract;

public class VehicleFactory{
    /**
     * Return which factory should be operating now
     * @param numberOfWheels
     * @return Factory
     */
    public static abstractFactory getFactory(int numberOfWheels) {
        if (numberOfWheels==2) return new TwoWheels();

        else if(numberOfWheels==4) return new FourWheels();

        else if (numberOfWheels==10) return new TenWheels();

        return null;
    }
}