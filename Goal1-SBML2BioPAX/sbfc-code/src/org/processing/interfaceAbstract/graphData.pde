/*
  PROCESSINGJS.COM HEADER ANIMATION
  MIT License - Hyper-Metrix.com/F1LT3R
  Native Processing compatible
 */ 

// Defining and limiting the number of nodes
Shape[] SHAPES = {
new Compartment(new String[] {"synaptic cleft"},487.0,478.5,126.0,23.0,50.0,320.0,1000.0,340.0,""),
new Compartment(new String[] {"synaptic button"},478.0,58.0,144.0,23.0,90.0,50.0,920.0,320.0,""),
new Compartment(new String[] {"muscle cytosol"},479.0,1299.0,142.0,23.0,90.0,610.0,920.0,720.0,""),
new Compartment(new String[] {"synaptic vesicle"},674.5,188.0,151.0,23.0,650.0,180.0,200.0,120.0,""),
new Compartment(new String[] {"ER"},923.0,628.0,34.0,23.0,840.0,620.0,200.0,120.0,""),
new Rectangle(4,0,0,0,new String[] {"CHT1"},120.0,290.0,120.0,60.0,""),
new SimpleChemical(0,0,new String[] {"Ach"},490.0,220.0,60.0,60.0,""),
new Rectangle(4,0,0,0,new String[] {"vAChT"},540.0,100.0,120.0,60.0,""),
new SquareNode(0,590.0,240.0,20.0,20.0,580.0,250.0,620.0,250.0,""),
new Rectangle(4,0,0,0,new String[] {"ChAT"},380.0,100.0,120.0,60.0,""),
new Rectangle(4,0,0,0,new String[] {"AChE"},390.0,395.0,120.0,60.0,""),
new SquareNode(0,440.0,530.0,20.0,20.0,430.0,540.0,470.0,540.0,""),
new SimpleChemical(0,0,new String[] {"acetate"},310.0,405.0,60.0,60.0,""),
new Rectangle(4,0,0,0,new String[] {"SNARE"},860.0,290.0,120.0,60.0,""),
new SimpleChemical(0,0,new String[] {"ACh"},690.0,220.0,60.0,60.0,""),
new SquareNode(0,660.0,440.0,20.0,20.0,670.0,430.0,670.0,470.0,""),
new SimpleChemical(0,0,new String[] {"ACh"},590.0,510.0,60.0,60.0,""),
new Rectangle(4,0,0,0,new String[] {"nAChR"},350.0,670.0,120.0,60.0,""),
new StateVariable(new String[] {"closed"},380.0,715.0,60.0,30.0,""),
new SquareNode(0,610.0,690.0,20.0,20.0,600.0,700.0,640.0,700.0,""),
new SimpleChemical(0,0,new String[] {"Ca2+"},860.0,860.0,60.0,60.0,""),
new CircularNode(0,750.0,1010.0,20.0,20.0,760.0,1000.0,760.0,1040.0,""),
new Rectangle(5,0,0,0,new String[] {""},630.0,1080.0,260.0,160.0,""),
new StateVariable(new String[] {"relaxed"},726.5,1225.0,67.0,30.0,""),
new Rectangle(4,0,0,0,new String[] {"myosin"},760.0,1100.0,120.0,60.0,""),
new Rectangle(4,0,0,0,new String[] {"actin"},640.0,1100.0,120.0,60.0,""),
new SimpleChemical(0,0,new String[] {"ATP"},790.0,1160.0,60.0,60.0,""),
new SimpleChemical(0,0,new String[] {"Pi"},520.0,1010.0,60.0,60.0,""),
new SquareNode(0,540.0,1160.0,20.0,20.0,530.0,1170.0,570.0,1170.0,""),
new SimpleChemical(0,0,new String[] {"ADP"},450.0,1010.0,60.0,60.0,""),
new CircularNode(1,290.0,980.0,20.0,20.0,300.0,970.0,300.0,1010.0,""),
new Rectangle(4,0,0,0,new String[] {"actin"},470.0,910.0,120.0,60.0,""),
new SimpleChemical(0,0,new String[] {"ATP"},440.0,750.0,60.0,60.0,""),
new Rectangle(4,0,0,0,new String[] {"myosin"},290.0,830.0,120.0,60.0,""),
new CircularNode(0,540.0,850.0,20.0,20.0,530.0,860.0,570.0,860.0,""),
new Rectangle(5,0,0,0,new String[] {""},690.0,830.0,140.0,140.0,""),
new Rectangle(4,0,0,0,new String[] {"myosin"},700.0,840.0,120.0,60.0,""),
new SimpleChemical(0,0,new String[] {"ATP"},730.0,900.0,60.0,60.0,""),
new Rectangle(4,0,0,0,new String[] {"nAChR"},680.0,670.0,120.0,60.0,""),
new StateVariable(new String[] {"open"},714.5,716.0,51.0,28.0,""),
new SimpleChemical(0,0,new String[] {"choline"},260.0,510.0,60.0,60.0,""),
new SquareNode(0,280.0,310.0,20.0,20.0,290.0,300.0,290.0,340.0,""),
new SimpleChemical(0,0,new String[] {"choline"},260.0,220.0,60.0,60.0,""),
new SimpleChemical(0,0,new String[] {"acetyl\n","CoA"},260.0,140.0,60.0,60.0,""),
new SquareNode(0,430.0,240.0,20.0,20.0,420.0,250.0,460.0,250.0,""),
new SimpleChemical(0,0,new String[] {"Ca2+"},860.0,660.0,60.0,60.0,""),
new SquareNode(0,880.0,780.0,20.0,20.0,890.0,770.0,890.0,810.0,""),
new Rectangle(5,0,0,0,new String[] {""},170.0,1080.0,260.0,120.0,""),
new StateVariable(new String[] {"tense"},273.0,1186.0,54.0,28.0,""),
new Rectangle(4,0,0,0,new String[] {"actin"},180.0,1100.0,120.0,60.0,""),
new Rectangle(4,0,0,0,new String[] {"myosin"},300.0,1100.0,120.0,60.0,""),
new Phenotype(new String[] {"muscle\n","contraction"},150.0,1250.0,160.0,60.0,""),
new ArcShape(6,240.0,320.0,280.0,320.0, new float[] {}),
new ArcShape(0,320.0,250.0,420.0,250.0, new float[] {}),
new ArcShape(1,460.0,250.0,490.0,250.0, new float[] {}),
new ArcShape(0,550.0,250.0,580.0,250.0, new float[] {}),
new ArcShape(1,620.0,250.0,690.0,250.0, new float[] {}),
new ArcShape(6,600.0,160.0,600.0,240.0, new float[] {}),
new ArcShape(4,440.0,160.0,440.0,240.0, new float[] {}),
new ArcShape(4,450.0,455.0,450.0,530.0, new float[] {}),
new ArcShape(0,590.0,540.0,470.0,540.0, new float[] {}),
new ArcShape(1,430.0,540.0,320.0,540.0, new float[] {}),
new ArcShape(1,430.0,540.0,361.70065,455.71426, new float[] {}),
new ArcShape(6,906.1539,350.0,680.0,450.0, new float[] {860.0,450.0}),
new ArcShape(0,711.9707,278.90555,670.0,430.0, new float[] {}),
new ArcShape(1,670.0,470.0,634.5693,513.77527, new float[] {}),
new ArcShape(6,620.0,570.0,620.0,690.0, new float[] {}),
new ArcShape(0,470.0,700.0,600.0,700.0, new float[] {}),
new ArcShape(1,640.0,700.0,680.0,700.0, new float[] {}),
new ArcShape(1,890.0,810.0,890.0,860.0, new float[] {}),
new ArcShape(3,890.0,920.0,770.0,1020.0, new float[] {890.0,1020.0}),
new ArcShape(0,760.0,970.0,760.0,1000.0, new float[] {}),
new ArcShape(0,590.0,955.65216,760.0,1000.0, new float[] {}),
new ArcShape(1,760.0,1040.0,760.0,1080.0, new float[] {}),
new ArcShape(0,630.0,1166.8422,570.0,1170.0, new float[] {}),
new ArcShape(1,530.0,1170.0,430.0,1155.6, new float[] {}),
new ArcShape(1,530.0,1170.0,550.0,1070.0, new float[] {}),
new ArcShape(1,530.0,1170.0,494.223,1066.4142, new float[] {}),
new ArcShape(0,300.0,1080.0,300.0,1010.0, new float[] {}),
new ArcShape(1,300.0,970.0,338.46155,890.0, new float[] {}),
new ArcShape(1,300.0,970.0,470.0,953.04346, new float[] {}),
new ArcShape(0,488.0,804.0,530.0,860.0, new float[] {}),
new ArcShape(0,410.0,860.0,530.0,860.0, new float[] {}),
new ArcShape(1,570.0,860.0,690.0,886.6667, new float[] {}),
new ArcShape(6,740.0,742.0,880.0,790.0, new float[] {740.0,790.0}),
new ArcShape(0,290.0,510.0,290.0,340.0, new float[] {}),
new ArcShape(1,290.0,300.0,290.0,280.0, new float[] {}),
new ArcShape(0,315.54974,185.72292,420.0,250.0, new float[] {}),
new ArcShape(0,890.0,720.0,890.0,770.0, new float[] {}),
new ArcShape(3,235.0,1200.0,245.0,1250.0, new float[] {})
};

static int COUNT = 90;

static int WINDOW_WIDTH = 1100;
static int WINDOW_HEIGHT = 1380;