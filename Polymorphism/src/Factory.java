
public class Factory implements Shape {

	Shape shape;
	
	public void setShape(Shape shape)
	{
		this.shape = shape;
	}
	@Override
	public int area() {
		// TODO Auto-generated method stub
		System.out.println("Inside factory method");
		return this.shape.area();
	}
	@Override
	public void setBase(int base) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void setHeight(int height) {
		// TODO Auto-generated method stub
		
	}

}
