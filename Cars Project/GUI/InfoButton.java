/**
 * @author Tomer Revah 205775083, Ilia Kulmin 320722184
 *
 */
package GUI;
import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class InfoButton extends JButton implements ActionListener {
    mainFrame myMainFrame;
    boolean flag=false;

    /**
     * Info Button constructor
     * @param myMainFrame
     */
    public InfoButton(mainFrame myMainFrame){
        super("Info");
        this.myMainFrame=myMainFrame;
        addActionListener(this);
    }

    /**
     * Reaction to performed action on button
     * @param e
     */
    @Override
    public void actionPerformed(ActionEvent e) {
        flag=!flag;
        myMainFrame.getDrawPanel().tableBuild(flag);

    }
}
