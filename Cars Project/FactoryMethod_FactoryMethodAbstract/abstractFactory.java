package FactoryMethod_FactoryMethodAbstract;

public interface abstractFactory {
       /**
        * Interface method for getting vehicles
        * @param type
        * @return
        */
       public Wheels getVehicle(String type);
}
