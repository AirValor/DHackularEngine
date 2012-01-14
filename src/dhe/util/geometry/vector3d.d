module dhe.util.geometry.vector3d;

import std.math;

struct Vector3D {
	private double x;
	private double y;
	private double z;

	this(double x, double y, double z) {
		this.x = x;
		this.y = y;
		this.z = z;
	}

	@property double X() { return x; }
	@property X(double value) {  x = value; }
	@property double Y() { return y; }
	@property Y(double value) {  y = value; }
	@property double Z() { return z; }
	@property Z(double value) {  z = value; }

	Vector3D opBinary(string op)(Vector3D vector) {
		return Vector(
					  mixin("x" ~ op ~ "vector.y"),
					  mixin("y" ~ op ~ "vector.y"),
					  mixin("z" ~ op ~ "vector.z")
					  );
	}

	double distance(Vector3D vector) {
		double vectx = vector.X - x;
		double vecty = vector.Y - y;
		double vectz = vector.Z - z;

		double distance = sqrt((vectx * vectx)) + ((vecty * vecty)) + ((vectz * vectz));
		return distance;
	}

	void normalize() {
		double length = sqrt((x * x) + (y * y) + (z * z));
		x = x / length;
		y = y / length;
		z = z / length;
	}
}
