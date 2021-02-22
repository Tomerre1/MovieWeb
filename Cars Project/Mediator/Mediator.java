package Mediator;
import components.Vehicle;

public interface Mediator {
    /**
     * Interface method of reading report
     * @param veh
     * @param Report
     */
    public void ReadReport(Vehicle veh, String Report);
}
