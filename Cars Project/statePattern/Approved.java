package statePattern;

import ReadWriteLock.Moked;

import javax.swing.*;

public class Approved implements State{
    /**
     * Method tells if all reports are approved
     */
    @Override
    public void doAction() {
        JOptionPane.showMessageDialog(new JFrame(), "All Reports Approved , can Exit");
        Moked.getInstance().clearReport();
        System.exit(0);
    }

}
