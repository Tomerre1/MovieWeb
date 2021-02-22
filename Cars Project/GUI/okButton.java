/**
 * @author Tomer Revah 205775083, Ilia Kulmin 320722184
 *
 */
package GUI;
import components.*;
import javax.swing.*;
import java.awt.event.*;

public class okButton extends JButton implements ActionListener {
    private int x,y;
    private CreateRoadsButton r;
    private JDialog tickFrame;
    private mainFrame k;

    /**
     * Ok Button constructor
     * @param r
     * @param tickFrame
     * @param k
     */
    public okButton(CreateRoadsButton r,JDialog tickFrame,mainFrame k){
        super("Ok");
        this.k=k;
        this.r=r;
        this.tickFrame=tickFrame;
        addActionListener(this);
    }

    /**
     * Reaction to performed action on button
     * @param e
     */
    @Override
    public void actionPerformed(ActionEvent e) {
        setX(r.getSlider().getValue());
        setY(r.getSlider2().getValue());
        k.setDriving(new Driving(x,y));
        Vehicle.setObjectsCount(1);
        Junction.setObjectsCount(1);
        tickFrame.dispose();
        k.draw();
    }

    /**
     * Set y
     * @param y
     */
    public void setY(int y) {
        this.y = y;
    }

    /**
     * Set x
     * @param x
     */
    public void setX(int x) {
        this.x = x;
    }

    /**
     * Return x
     * @return x
     */
    @Override
    public int getX() {
        return x;
    }

    /**
     * Return Y
     * @return y
     */
    @Override
    public int getY() {
        return y;
    }
}
