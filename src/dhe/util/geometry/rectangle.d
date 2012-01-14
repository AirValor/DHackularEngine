module dhe.util.geometry.rectangle;

import dhe.util.geometry.vector2d;
import dhe.util.geometry.size;

struct Rectangle {
	private Vector2D position;
	private Size size;

	this(double x, double y, double w, double h)
	{
		this.position = Vector2D(x, y);
		this.size = Size(w, h);
	}

	@property double X() { return position.X; }
	@property X(double value) {  position.X = value; }
	@property double Y() { return position.Y; }
	@property Y(double value) {  position.Y = value; }
	@property double W() { return size.W; }
	@property W(double value) {  size.W = value; }
	@property double H() { return size.H; }
	@property H(double value) {  size.H = value; }

	Size opBinary(string op)(Size size) {
		return Size(mixin("w" ~ op ~ "size.w"),
					mixin("x" ~ op ~ "vector.y"));
	}

	bool contains(Vector2D vector)
	{
		return (vector.X > position.X && vector.X < position.X + size.W
		   && vector.Y > position.Y && vector.Y < position.Y + size.H);
	}

	bool intersects(Rectangle rect)
	{
		return !(rect.position.X > position.X + size.W || rect.position.X + size.W < position.X
				 || rect.position.Y > position.Y + size.H || rect.position.Y + size.H < position.Y);
	}
}