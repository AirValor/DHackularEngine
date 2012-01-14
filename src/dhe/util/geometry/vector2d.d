module dhe.util.geometry.vector2d;

import std.math;
import dhe.util.geometry.polar;
import dhe.util.geometry.vector3d;

struct Point {
	private double x;
	private double y;

	this(double x, double y) {
		this.x = x;
		this.y = y;		
	}

	Point opBinary(string op)(Point point) {
		return Point(
					  mixin("x" ~ op ~ "point.x"),
					  mixin("y" ~ op ~ "point.y")
					  );
	}

	/**
	 * Recalculate the coordinates of the Vector into the 
	 * Polar coordinate system.
	 *
	 * Returns: A new polar object
	 */
	Polar getPolarCoordinate() {
		Polar polar = Polar(distance(), atan(y/x));
		return polar;
	}


	Point3D getPoint3D() {
		Point3D point3d = Point3D(x, y, 0);
		return point3d;
	}

	double distance() {
		double distance = sqrt((pow(x, 2)) + (pow(y, 2)));
		return distance;
	}

	void setX(double x) {
		this.x = x;
	}

	void setY(double y) {
		this.y = y;
	}

	double getX() {
		return x;
	}

	double getY() {
		return y;
	}
}
