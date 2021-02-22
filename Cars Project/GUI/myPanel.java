/**
 * @author Tomer Revah 205775083, Ilia Kulmin 320722184
 *
 */
package GUI;
import components.*;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.util.Random;
import java.util.Vector;

public class myPanel extends JPanel {
    private Driving driving;
    private JScrollPane ScrollPanel;
    private Graphics g = getGraphics();

    /**
     * My Panel (Drawing and info panel) constructor
     * @param x
     */
    public myPanel(Driving x){
        super();
        setBackground(Color.WHITE);
        setSize(950,750);
        this.driving=x;
    }

    /**
     * Draw vehicle movement on road system
     * @param g
     * @param v
     */
    public void VehicleDrawing(Graphics g, Vehicle v) {
        int x1=(int) v.getLastRoad().getStartJunction().getX();
        int y1=(int) v.getLastRoad().getStartJunction().getY();
        int x2=(int) v.getLastRoad().getEndJunction().getX();
        int y2=(int) v.getLastRoad().getEndJunction().getY();
        if(v.getCurrentRoutePart() instanceof Road){
            int K=v.getVehicleType().getAverageSpeed()*v.getTimeOnCurrentPart();
            int L= (int) ((Road) v.getCurrentRoutePart()).calcLength()-K;
            int xp=((x1*L)+(x2*K))/(L+K);
            int yp=((y1*L)+(y2*K))/(L+K);
            getGraphics().setColor(v.getVehicleColor());
            drawRotetedVehicle(g, xp, yp, x2, y2, 10, 4);
        }
        else{
            g.setColor(v.getVehicleColor());
            int[] xpoints = {(int) x2 - 5, (int) x2 + 5, (int) x2 + 5, (int) x2 - 5};
            int[] ypoints = {(int) y2 + 2, (int) y2 + 2, (int) y2 - 2, (int) y2 - 2};
            g.fillPolygon(xpoints, ypoints, 4);
            g.setColor(v.getVehicleColor());
            g.fillOval((int) x2 - 5 - 2, (int) y2, 4, 4);
            g.fillOval((int) x2 + 5 - 2, (int) y2, 4, 4);
            g.fillOval((int) x2 - 5 - 2, (int) y2 - 2 - 2, 4, 4);
            g.fillOval((int) x2 + 5 - 2, (int) y2 - 2 - 2, 4, 4);
        }
            repaint();
    }

    /**
     * Set Driving object
     * @param driving
     */
    public void setDriving(Driving driving) {
        this.driving = driving;
        Vehicle.setDrawPanel(this);
        driving.setDrawPanel(this);
    }

    /**
     * Draw triangles to working traffic light junction representing which road is now green
     * @param g
     * @param x1
     * @param y1
     * @param x2
     * @param y2
     * @param d
     * @param h
     */
    private void drawPolygon(Graphics g, int x1, int y1, int x2, int y2, int d, int h) {
        int dx = x2 - x1, dy = y2- y1;
        double D = Math.sqrt(dx*dx +dy*dy);
        double xm = D - d, xn = xm,ym = h,yn = -h,x;
        double sin = dy / D, cos = dx / D;
        x = xm*cos - ym*sin + x1;
        ym = xm*sin + ym*cos + y1;
        xm = x;
        x = xn*cos - yn*sin + x1;
        yn = xn*sin + yn*cos + y1;
        xn = x;
        int[] xpoints = {x2,(int)xm,(int)xn};
        int[] ypoints = {y2,(int)ym,(int)yn};
        g.setColor(Color.GREEN);
        g.fillPolygon(xpoints,ypoints,3);
    }

    /**
     * Draw road system on panel
     * @param g
     */
    @Override
    public void paintComponent(Graphics g) {
        super.paintComponent(g);
        if (driving == null) return;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Roads drawing~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
        for (Road d : driving.getMap().getRoads()) {
            if (d.getEnabled()) {
                g.setColor(Color.black);
                g.drawLine(((int) d.getStartJunction().getX()), (int) d.getStartJunction().getY(), ((int) d.getEndJunction().getX()), (int) d.getEndJunction().getY());
            }
        }

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Traffic Lights Arrows drawing~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
        for (Road d : driving.getMap().getRoads()) {
            if (d.getEndJunction() instanceof LightedJunction) {
                if (((LightedJunction) d.getEndJunction()).getLights().getTrafficLightsOn()) {
                    if (d.getGreenLight()) {
                        drawPolygon(g, (int) d.getStartJunction().getX(), (int) d.getStartJunction().getY(), (int) d.getEndJunction().getX(), (int) d.getEndJunction().getY(), 20, 5);
                    }
                }
            }
        }
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Junctions drawing~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

            for (Junction x : driving.getMap().getJunctions()) {
                if (x instanceof LightedJunction) {
                    if (((LightedJunction) x).getLights().getTrafficLightsOn()) {
                        g.setColor(Color.RED);
                        g.fillOval(((int) x.getX()) - 10, (int) (x.getY()) - 10, 20, 20);
                    } else {
                        g.setColor(Color.GREEN);
                        g.fillOval(((int) x.getX()) - 10, (int) (x.getY()) - 10, 20, 20);
                    }
                } else {
                    g.setColor(Color.BLACK);
                    g.fillOval(((int) x.getX()) - 10, (int) (x.getY()) - 10, 20, 20);
                }
            }


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Vehicle drawing~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
            for (Vehicle z : driving.getVehicles()) {
                g.setColor(z.getVehicleColor());
                VehicleDrawing(g, z);
            }
        }

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Draw Vehicle~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

    /**
     * Draw vehicle
     * @param g
     * @param x1
     * @param y1
     * @param x2
     * @param y2
     * @param d
     * @param h
     */
    private void drawRotetedVehicle(Graphics g, int x1, int y1, int x2, int y2, int d, int h) {
        int dx = x2 - x1, dy = y2 - y1, delta = 10;
        double D = Math.sqrt(dx*dx + dy*dy);
        double xm = delta, xn = xm, ym = h, yn = -h, x;
        double xm1 = delta + d, xn1 = xm1, ym1 = h, yn1 = -h, xx;
        double sin = dy / D, cos = dx / D;
        x = xm*cos - ym*sin + x1;
        xx = xm1*cos - ym1*sin + x1;
        ym = xm*sin + ym*cos + y1;
        ym1 = xm1*sin + ym1*cos + y1;
        xm = x;
        xm1 = xx;
        x = xn*cos - yn*sin + x1;
        xx = xn1*cos - yn1*sin + x1;
        yn = xn*sin + yn*cos + y1;
        yn1 = xn1*sin + yn1*cos + y1;
        xn = x;
        xn1 = xx;
        int[] xpoints = {(int) xm1, (int) xn1,  (int) xn, (int) xm};
        int[] ypoints = {(int) ym1, (int) yn1, (int) yn, (int) ym};
        Polygon p = new Polygon(xpoints, ypoints, 4);
        g.fillPolygon(p);
        g.setColor(Color.BLACK);
        g.fillOval((int) xm1-2,(int) ym1-2,4,4);
        g.fillOval((int) xn1-2,(int) yn1-2,4,4);
        g.fillOval((int) xm-2,(int) ym-2,4,4);
        g.fillOval((int) xn-2,(int) yn-2,4,4);
    }


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~JTable Build of Vehicles~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

    /**
     * Build Info table which contains information about every vehicle
     * @param k
     */
    public void tableBuild(boolean k) {
        //------------Minimize table-----------------------------//
        if(!k) ScrollPanel.setVisible(false);

        //------------Build table-----------------------------//
        DefaultTableModel model = new DefaultTableModel();
        JTable table = new JTable(model);
        ScrollPanel = new JScrollPane(table);
        ScrollPanel.setBounds(0, 0, 400, 100);


        //------------draw table-----------------------------//
        try {
            if (k) {
                //------------------Columns add to table--------------//
                model.addColumn("Vehicle #");
                model.addColumn("Type");
                model.addColumn("Location");
                model.addColumn("Time on loc");
                model.addColumn("Speed");


                //------------------Build Vector of strings with details of the car--------------//
                Vector<String> rec = new Vector<String>();
                for (Vehicle veh : Driving.getVehicles()) {
                    rec.add("" + veh.getId());
                    rec.add("" + veh.getVehicleType());
                    if (veh.getCurrentRoutePart() instanceof Junction) {
                        rec.add("Junction "+((Junction) veh.getCurrentRoutePart()).getJunctionName());
                    }
                    else
                        {
                        rec.add("Road " + ((Road) veh.getCurrentRoutePart()).getStartJunction().getJunctionName() + " - " + ((Road) veh.getCurrentRoutePart()).getEndJunction().getJunctionName());
                    }
                    rec.add("" + veh.getTimeOnCurrentPart());
                    rec.add("" + veh.getActualSpeed());
                }

                //------------------Rows add to table--------------//
                for (int i = 0; i < rec.size(); i += 5) {
                    model.addRow(new Object[]{rec.get(i), rec.get(i + 1), rec.get(i + 2), rec.get(i + 3), rec.get(i + 4)});
                }

                //------------------Insert table in drawPanel--------------//
                add(ScrollPanel);

                ScrollPanel.setVisible(true);
            }
        }
        catch (NullPointerException x){};
    }
}
