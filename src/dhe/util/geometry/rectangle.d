module dhe.util.geometry.rectangle;

import dhe.util.geometry.vector2d;
import dhe.util.geometry.size2d;

struct Rectangle {
	private Vector2D position;
	private Size2D size;

	this(double x, double y, double w, double h)
	{
		this.position = Vector2D(x, y);
		this.size = Size2D(w, h);
	}

	ref double getX() {  return position.getX(); }
	ref double getY() {  return position.getY(); }
	ref double getW() { return size.getW(); }
	ref double getH() { return size.getH(); }

	void setX(double x) {  position.setX(x); }
	void setY(double y) {  position.setY(y); }
	void setW(double w) { size.setW(w); }
	void setH(double h) { size.setH(h); }

	Size2D opBinary(string op)(Size2D size) {
		return Size2D(mixin("w" ~ op ~ "size.w"),
					  mixin("x" ~ op ~ "vector.y"));
	}

	bool contains(Vector2D vector)
	{
		return (vector.getX() > position.getX() && vector.getX() < position.getX() + size.getW()
				&& vector.getY() > position.getY() && vector.getY() < position.getY() + size.getH());
	}

	bool intersects(Rectangle rect)
	{
		return !(rect.position.getX() > position.getX() + size.getW() || rect.position.getX() + size.getW() < position.getX()
				 || rect.position.getY() > position.getY() + size.getH() || rect.position.getY() + size.getH() < position.getY());
	}
}
