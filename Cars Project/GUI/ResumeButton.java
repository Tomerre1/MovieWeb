/**
 * @author Tomer Revah 205775083, Ilia Kulmin 320722184
 *
 */
package GUI;
import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ResumeButton extends JButton implements ActionListener {
    private mainFrame mainFrame;

    /**
     * Resume Button constructor
     * @param mainFrame
     */
    public ResumeButton(mainFrame mainFrame) {
        super("Resume");
        this.mainFrame = mainFrame;
        addActionListener(this);
    }

    /**
     * Reaction to performed action on button
     * @param e
     */
    @Override
    public void actionPerformed(ActionEvent e) {
        mainFrame.getDriving().setResume();
    }
}