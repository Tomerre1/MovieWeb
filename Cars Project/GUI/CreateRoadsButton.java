/**
 * @author Tomer Revah 205775083, Ilia Kulmin 320722184
 *
 */
package GUI;
import components.Junction;
import components.Vehicle;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class CreateRoadsButton extends JButton implements ActionListener {
    private okButton OK;
    private JSlider slider,slider2;
    private JDialog tickFrame;
    private mainFrame x;

    /**
     * Create Roads Button constructor
     * @param x
     */
    public CreateRoadsButton(mainFrame x){
        super("Create Road System");
        this.x=x;
        addActionListener(this);
    }

    /**
     * Reaction to performed action on button
     * @param e
     */
    @Override
    public void actionPerformed(ActionEvent e) {
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~JDialog init~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
        tickFrame=new JDialog();
        tickFrame.setTitle("Create Road System");
        tickFrame.setSize(600,300);

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~JSlider1 init~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
        slider=new JSlider(JSlider.HORIZONTAL,3, 20,10);
        slider.setMajorTickSpacing(1);
        slider.setPaintLabels(true);
        slider.setPaintTicks(true);

        JPanel SlidersPanel=new JPanel(new GridLayout(5,0, 4, 4));
        JLabel numOfJunctions=new JLabel("Number of junctions");
        numOfJunctions.setHorizontalAlignment(JLabel.CENTER);
        SlidersPanel.add(numOfJunctions);
        SlidersPanel.add(slider);

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~JSlider2 init~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

        slider2=new JSlider(JSlider.HORIZONTAL,0, 50,10);
        slider2.setMajorTickSpacing(5);
        slider2.setPaintLabels(true);
        slider2.setPaintTicks(true);

        JLabel numOfVehicles=new JLabel("Number of vehicles");
        numOfVehicles.setHorizontalAlignment(JLabel.CENTER);
        SlidersPanel.add(numOfVehicles);
        SlidersPanel.add(slider2);

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~JPanel init~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
        JPanel buttonsPanel=new JPanel(new GridLayout(0,2));

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Buttons init~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

        JButton Cancel=new JButton("Cancel");
        class cancelDispose implements ActionListener{
            @Override
            public void actionPerformed(ActionEvent e) {
                tickFrame.dispose();
            }
        }
        Cancel.addActionListener(new cancelDispose());

        tickFrame.add(SlidersPanel);
        tickFrame.add(buttonsPanel,"South");
        OK=new okButton(this,tickFrame,x);
        buttonsPanel.add(OK);
        buttonsPanel.add(Cancel);
        Vehicle.setObjectsCount(1);
        Junction.setObjectsCount(1);
        tickFrame.setVisible(true);
    }

    /**
     * Return "Number of junctions" slider
     * @return
     */
    public JSlider getSlider() {
        return slider;
    }

    /**
     * Return "Number of vehicles" slider
     * @return
     */
    public JSlider getSlider2() {
        return slider2;
    }
}
