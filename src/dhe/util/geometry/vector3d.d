module dhe.util.geometry.vector3d;

import dhe.util.geometry.vector2d;

struct Point3D {
	private double z;
	private Point point = Point(0, 0);
	
	this(double x, double y, double z) {
		point = Point(x, y);
		this.z = z;
	}

	Point getPoint() {
		return point;
	}

	double getX() {
		return point.getX();
	}

	double getY() {
		return point.getY();
	}
	
	double getZ() {
		return z;
	}
}
