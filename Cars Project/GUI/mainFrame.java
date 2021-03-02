/**
 * @author Tomer Revah 205775083, Ilia Kulmin 320722184
 *
 */
package GUI;
import Builder.*;
import Prototype.WorkSpace;
import ReadWriteLock.Moked;
import components.*;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Random;


public class mainFrame extends JFrame {
    private JDialog cloneCarFrame;
    private JMenuBar menubar;
    private JFrame myframe;
    private JMenu File, backGround, Help, VehicleColor, Build_a_Map, Clone_a_car, Reports;
    private JMenuItem Exit, MenuBlue, MenuNone, GameHelp, VehicleBlue, VehicleMagenta, VehicleOrange, VehicleRandom, City, Country, chooseCar,readAllReports;
    private LowerPanel LowerPanel;
    private myPanel drawPanel;
    private Driving driving;
    private static boolean flag = false;
    private int num;
    private JScrollPane scrollPanel;
    private boolean k=true;
    private JTable table;
    /**
     * Main Frame constructor
     */
    public mainFrame() {
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Frame Init~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
        super("Road System");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocation(500, 100);
        setBackground(Color.WHITE);
        setSize(950, 950);

        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~JMenu Init~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
        menubar = new JMenuBar();
        File = new JMenu("File");
        Exit = new JMenuItem("Exit");
        File.add(Exit);
        class exitaction  implements ActionListener {
            @Override
            public void actionPerformed(ActionEvent e) {
                if(getDriving()==null){
                    Moked.getInstance().clearReport();
                    System.exit(0);
                }
                getDriving().getMyState().doAction();
            }
        }
        Exit.addActionListener(new exitaction());

        backGround = new JMenu("Background");
        MenuBlue = new JMenuItem("Blue");
        MenuNone = new JMenuItem("None");
        backGround.add(MenuBlue);
        backGround.add(MenuNone);
        class changeColor implements ActionListener {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (e.getSource() == MenuBlue) drawPanel.setBackground(new Color(0, 100, 255));
                else drawPanel.setBackground(Color.WHITE);
            }
        }
        MenuBlue.addActionListener(new changeColor());
        MenuNone.addActionListener(new changeColor());

        Help = new JMenu("Help");
        GameHelp = new JMenuItem("Help");
        Help.add(GameHelp);
        class popUpMessage implements ActionListener {
            @Override
            public void actionPerformed(ActionEvent e) {
                JOptionPane.showMessageDialog(myframe, "Home Work 3\n" + "GUI @ Threads");
            }
        }
        GameHelp.addActionListener(new popUpMessage());

        VehicleColor = new JMenu("Vehicle color");
        VehicleBlue = new JMenuItem("Blue");
        VehicleMagenta = new JMenuItem("Magenta");
        VehicleOrange = new JMenuItem("Orange");
        VehicleRandom = new JMenuItem("Random");


        class blueColor implements ActionListener {
            @Override
            public void actionPerformed(ActionEvent e) {
                for (Vehicle v : driving.getVehicles())
                    v.setVehicleColor(Color.BLUE);
                drawPanel.repaint();
            }
        }
        VehicleBlue.addActionListener(new blueColor());
        VehicleColor.add(VehicleBlue);


        class magentaColor implements ActionListener {
            @Override
            public void actionPerformed(ActionEvent e) {
                for (Vehicle v : driving.getVehicles())
                    v.setVehicleColor(Color.MAGENTA);
                drawPanel.repaint();
            }
        }
        VehicleMagenta.addActionListener(new magentaColor());
        VehicleColor.add(VehicleMagenta);

        class orangeColor implements ActionListener {
            @Override
            public void actionPerformed(ActionEvent e) {
                for (Vehicle v : driving.getVehicles())
                    v.setVehicleColor(Color.ORANGE);
                drawPanel.repaint();
            }
        }
        VehicleOrange.addActionListener(new orangeColor());
        VehicleColor.add(VehicleOrange);


        class randomColor implements ActionListener {
            @Override
            public void actionPerformed(ActionEvent e) {
                Color color;
                for (Vehicle v : driving.getVehicles()) {
                    color = new Color(new Random().nextInt(255), new Random().nextInt(255), new Random().nextInt(255));
                    v.setVehicleColor(color);
                }
                drawPanel.repaint();
            }

            ;
        }
        VehicleRandom.addActionListener(new randomColor());
        VehicleColor.add(VehicleRandom);

        Build_a_Map = new JMenu("Build a map");
        City = new JMenuItem("City");
        Country = new JMenuItem("Country");
        Build_a_Map.add(City);
        Build_a_Map.add(Country);
        class chooseMap implements ActionListener {
            /**
             * Choose a kind of map
             * @param e
             */
            @Override
            public void actionPerformed(ActionEvent e) {
                if (e.getSource() == City) {
                    Moked.getInstance().clearReport();
                    setVehiclesFrame("City");
                }
                else {
                    Moked.getInstance().clearReport();
                    setVehiclesFrame("Country");
                }
            }
        }
        City.addActionListener(new chooseMap());
        Country.addActionListener(new chooseMap());


        Clone_a_car = new JMenu("Clone a car");
        chooseCar = new JMenuItem("Choose car id");
        Clone_a_car.add(chooseCar);
        class CloneCars implements ActionListener {
            /**
             * Clone selected car and place it on the created map
             * @param e
             */
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~JDialog init~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                    cloneCarFrame = new JDialog();
                    cloneCarFrame.setLocation(500, 100);
                    cloneCarFrame.setTitle("Clone a Car");
                    cloneCarFrame.setSize(300, 300);
                    JPanel SlidersPanel = new JPanel(new GridLayout(2, 0, 4, 4));
                    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~JSlider1 init~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
                    JSlider slider = new JSlider(JSlider.HORIZONTAL, 1, Driving.getVehicles().size(), 1);
                    slider.setMajorTickSpacing(1);
                    slider.setPaintLabels(true);
                    slider.setPaintTicks(true);
                    JLabel Choose = new JLabel("Choose car to clone by Car ID: ");
                    Choose.setHorizontalAlignment(JLabel.CENTER);
                    SlidersPanel.add(Choose);
                    SlidersPanel.add(slider);
                    JPanel buttonsPanel = new JPanel(new GridLayout(0, 2));
                    JButton Cancel = new JButton("Cancel");
                    class cancelDispose implements ActionListener {
                        @Override
                        public void actionPerformed(ActionEvent e) {
                            cloneCarFrame.dispose();
                        }
                    }
                    Cancel.addActionListener(new cancelDispose());

                    JButton OK = new JButton("Ok");
                    class OKPress implements ActionListener {
                        @Override
                        public void actionPerformed(ActionEvent e) {
                            Vehicle copied = Driving.getVehicles().get(slider.getValue() - 1).clone();
                            WorkSpace WorkPlace = new WorkSpace();
                            Vehicle x = WorkPlace.updateCar(copied);
                            Driving.getVehicles().add(x);
                            Driving.getAllTimedElements().add(x);
                            cloneCarFrame.dispose();
                            drawPanel.repaint();
                        }
                    }
                    OK.addActionListener(new OKPress());
                    cloneCarFrame.add(SlidersPanel);
                    cloneCarFrame.add(buttonsPanel, "South");
                    buttonsPanel.add(OK);
                    buttonsPanel.add(Cancel);
                    cloneCarFrame.setVisible(true);
                } catch (NullPointerException x) {
                    JOptionPane.showMessageDialog(myframe, "There is not cars to clone, You need to choose map");
                }
            }

        }
        chooseCar.addActionListener(new CloneCars());


        Reports = new JMenu("Reports");
        readAllReports=new JMenuItem("Read all reports");
        Reports.add(readAllReports);
        class readAll implements ActionListener {
            /**
             * Read all written reports
             * @param e
             */
            @Override
            public void actionPerformed(ActionEvent e) {
                buildReportTable(k);
                k=!k;
            }
        }
        readAllReports.addActionListener(new readAll());


        menubar.add(File);
        menubar.add(backGround);
        menubar.add(VehicleColor);
        menubar.add(Build_a_Map);
        menubar.add(Clone_a_car);
        menubar.add(Reports);
        menubar.add(Help);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Panel Init~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
        LowerPanel = new LowerPanel(this);
        drawPanel = new myPanel(driving);

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Frame add~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
        add(drawPanel, BorderLayout.CENTER);
        add(LowerPanel, BorderLayout.SOUTH);
        add(menubar, BorderLayout.NORTH);
        setJMenuBar(menubar);
        setVisible(true);
    }

    /**
     * Builds a table that displays reports
     * @param k
     */
    public void buildReportTable(boolean k){
        if(!k) scrollPanel.setVisible(false);

        //------------Build table-----------------------------//
        DefaultTableModel model = new DefaultTableModel();
        table = new JTable(model);
        scrollPanel = new JScrollPane(table);
        scrollPanel.setBounds(0, 0, 950, 1000);


        //------------draw table-----------------------------//
        try {
            if (k) {
                //------------------Columns add to table--------------//
                model.addColumn("Vehicle id");
                model.addColumn("Report Number");
                model.addColumn("Date");
                model.addColumn("Time");
                model.addColumn("Approved or Not Approved");


                //------------------Build Vector of strings with details of the car--------------//
                for (int i=0;i<Moked.ReadReportsButton.size();i++) {
                    String[] r = Moked.ReadReportsButton.get(i).split(" ");
                    if(Moked.getTotalReports().contains(Moked.ReadReportsButton.get(i)))
                        model.addRow(new Object[]{r[1], r[4], r[6], r[7], "Not Approved"});
                    else
                        model.addRow(new Object[]{r[1], r[4], r[6], r[7], "Approved"});
                }
                //------------------Insert table in drawPanel--------------//
                drawPanel.add(scrollPanel);
                scrollPanel.setVisible(true);
            }
        }
        catch (NullPointerException x){};
        table.repaint();
    }

    /**
     * Set map from city type
     */
    public void setCityMap(){
        Vehicle.setStop(true);
        TrafficLights.setStop(true);
        Driving.setStop(false);
        setDriving(new Driving());
        MapBuilder city = new CityBuilder(num);
        MapEngineer engineer = new MapEngineer(city);
        engineer.constructMap();
        Map City_Map = engineer.getMap();
        driving.setMap(City_Map);
        draw();
    }

    /**
     * Set number of vehicles
     * @param mode
     */
    public void setVehiclesFrame(String mode) {
        JDialog VehiclesNumber = new JDialog();
        VehiclesNumber.setTitle("Choose num of vehicles");
        VehiclesNumber.setSize(450, 200);
        JSlider slider2 = new JSlider(JSlider.HORIZONTAL, 1, 20, 1);
        slider2.setMajorTickSpacing(1);
        slider2.setPaintLabels(true);
        slider2.setPaintTicks(true);
        JLabel numOfVehicles = new JLabel("Number of vehicles");
        numOfVehicles.setHorizontalAlignment(JLabel.CENTER);
        JPanel SlidersPanel = new JPanel(new GridLayout(2, 0, 4, 4));
        SlidersPanel.add(numOfVehicles);
        SlidersPanel.add(slider2);
        JPanel buttonsPanel = new JPanel(new GridLayout(0, 2));
        JButton Cancel = new JButton("Cancel");
        class cancelDispose implements ActionListener {
            @Override
            public void actionPerformed(ActionEvent e) {
                VehiclesNumber.dispose();
            }
        }
        Cancel.addActionListener(new cancelDispose());

        JButton OK = new JButton("Ok");
        class OKPress implements ActionListener {
            @Override
            public void actionPerformed(ActionEvent e) {
                setNum(slider2.getValue());
                VehiclesNumber.dispose();
                if(mode=="City") setCityMap();
                else setCountryMap();


            }
        }
        OK.addActionListener(new OKPress());
        buttonsPanel.add(OK);
        buttonsPanel.add(Cancel);
        VehiclesNumber.add(SlidersPanel);
        VehiclesNumber.add(buttonsPanel, "South");
        VehiclesNumber.setVisible(true);
        flag=true;
    }

    /**
     * Set map from country type
     */
    private void setCountryMap() {
        Vehicle.setStop(true);
        TrafficLights.setStop(true);
        Driving.setStop(false);
        setDriving(new Driving());
        MapBuilder country = new CountryBuilder(num);
        MapEngineer engineer = new MapEngineer(country);
        engineer.constructMap();
        Map Country_Map = engineer.getMap();
        driving.setMap(Country_Map);
        draw();
    }

    public JTable getTable() {
        return table;
    }

    public void setNum(int num) { this.num = num; }

    /**
     * Starts drawing the game
     */
    public void draw(){
        drawPanel.setDriving(driving);
        drawPanel.repaint();
    }

    /**
     * Get the draw panel
     * @return draw panel
     */
    public myPanel getDrawPanel() {return drawPanel;}

    /**
     * Set driving
     * @param driving
     */
    public void setDriving(Driving driving) {this.driving = driving;}

    /**
     * Get driving
     * @return driving
     */
    public Driving getDriving() {return driving;}
}
