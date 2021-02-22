package statePattern;

import javax.swing.*;


public class NotApproved implements State {
    /**
     * Method tells if all reports are approved
     */
    @Override
    public void doAction() {
        JOptionPane.showMessageDialog(new JFrame(), "Not All Reports Approved , cant Exit");
    }
}
