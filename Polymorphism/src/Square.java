
public class Square implements Shape {
	
	int base;
	int height;

	@Override
	public int area() {
		// TODO Auto-generated method stub
		System.out.println("Inside square method");
		this.height = this.base;
		return (this.base * this.height);
		
	}

	@Override
	public void setBase(int base) {
		// TODO Auto-generated method stub
		this.base = base;
	}

	@Override
	public void setHeight(int height) {
		// TODO Auto-generated method stub
		this.height = height;
	}

}
