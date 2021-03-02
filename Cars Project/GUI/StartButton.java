/**
 * @author Tomer Revah 205775083, Ilia Kulmin 320722184
 *
 */
package GUI;
import components.Driving;
import components.TrafficLights;
import components.Vehicle;
import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;


public class StartButton extends JButton implements ActionListener {
    private mainFrame mainFrame;

    /**
     * Start Button constructor
     * @param mainFrame
     */
    public StartButton(mainFrame mainFrame) {
        super("Start");
        this.mainFrame = mainFrame;
        addActionListener(this);
    }

    /**
     * Reaction to performed action on button
     * @param e
     */
    @Override
    public void actionPerformed(ActionEvent e) {
        Vehicle.setStop(false);
        TrafficLights.setStop(false);
        Driving.setStop(true);
        new Thread(mainFrame.getDriving()).start();
    }
}
