/**
 * @author Tomer Revah 205775083, Ilia Kulmin 320722184
 *
 */
package GUI;

import components.Driving;
import components.LightedJunction;
import components.TrafficLights;
import components.Vehicle;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class StopButton extends JButton implements ActionListener {
    private mainFrame mainFrame;

    /**
     * Stop Button constructor
     * @param mainFrame
     */
    public StopButton(mainFrame mainFrame){
        super("Stop");
        this.mainFrame=mainFrame;
        addActionListener(this);
    }

    /**
     * Reaction to performed action on button
     * @param e
     */
    @Override
    public void actionPerformed(ActionEvent e) {
        Vehicle.setStop(true);
        TrafficLights.setStop(true);
        Driving.setStop(false);
    }
}
