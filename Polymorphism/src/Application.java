
public class Application {
	
	public static void main(String args[])
	{
		Shape tri = new Triangle();
		Shape sq = new Square();
		Factory fac = new Factory();
		sq.setBase(10);
		tri.setBase(10);
		tri.setHeight(10);
		//fac.setShape(tri);
		fac.setShape(sq);
		int a =fac.area();
		System.out.println("Area is: "+ a);
	}

}
