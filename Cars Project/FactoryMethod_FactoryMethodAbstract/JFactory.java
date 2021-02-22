package FactoryMethod_FactoryMethodAbstract;
import components.Junction;
import components.LightedJunction;

import java.util.Random;
public class JFactory {
    private static Junction junc = null;

    /**
     * Get junction/LightedJunction instance
     * @param type
     * @return
     */
    public static Junction getJunction(String type){
        if ("CITY".equalsIgnoreCase(type)) junc = new LightedJunction();

        else if("COUNTRY".equalsIgnoreCase(type)) junc= (new Random().nextBoolean()) ? new LightedJunction() : new Junction();

        return junc;
    }
}

