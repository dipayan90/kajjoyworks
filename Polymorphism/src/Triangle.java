
public class Triangle implements Shape {
	
	int base;
	int height;

	public void setBase(int base) {
		this.base = base;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	@Override
	public int area() {
		// TODO Auto-generated method stub
		System.out.println("Inside triangle method");
		return (int) (0.5 * this.base * this.height);
		
	}

}
