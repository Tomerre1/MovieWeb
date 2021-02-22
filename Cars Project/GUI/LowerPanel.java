/**
 * @author Tomer Revah 205775083, Ilia Kulmin 320722184
 *
 */
package GUI;
import javax.swing.*;
import java.awt.*;

public class LowerPanel extends JPanel{
    private  CreateRoadsButton SystemRoads;
    private StartButton StartButton1;
    private StopButton StopButton1;
    private ResumeButton ResumeButton1;
    private InfoButton InfoButton1;

    /**
     * Lower Panel (buttons panel) constructor
     * @param x
     */
    public LowerPanel(mainFrame x){
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~JPanel Init~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
        super();
        setLayout(new GridLayout(0,5));

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Buttons Init~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

        SystemRoads=new CreateRoadsButton(x);
        StartButton1 = new StartButton(x);
        StopButton1 = new StopButton(x);
        ResumeButton1 = new ResumeButton(x);
        InfoButton1 = new InfoButton(x);

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~JPanel add buttons~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

        add(SystemRoads);
        add(StartButton1);
        add(StopButton1);
        add(ResumeButton1);
        add(InfoButton1);

    }
}
