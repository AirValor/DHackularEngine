module dhe.util.geometry.vector3d;

import std.math;

/**
* Represents a three-dimensional Vector in the Cartesian coordinate system.
*/
struct Vector3D {
	private double x;
	private double y;
	private double z;

	this(double x, double y, double z) {
		this.x = x;
		this.y = y;
		this.z = z;
	}

	ref double getX() { return x; }
	ref double getY() { return y; }
	ref double getZ() { return z; }
	
	void setX(double x) { this.x = x; }
	void setY(double y) { this.y = y; }
	void setZ(double z) { this.z = z; }

	Vector3D opBinary(string op)(Vector3D vector) {
		return Vector3D(mixin("x" ~ op ~ "vector.y"),
						mixin("y" ~ op ~ "vector.y"),
						mixin("z" ~ op ~ "vector.z"));
	}

	/**
	* Calculates the distance between two Vectors.
	*
	* Params:
	*		vector = The Vector to calculate with.
	*
	* Returns: The distance between the two vectors.
	*
	*/
	double distance(Vector3D vector) {
		double vectx = vector.getX() - x;
		double vecty = vector.getY() - y;
		double vectz = vector.getZ() - z;

		double distance = sqrt((vectx * vectx)) + ((vecty * vecty)) + ((vectz * vectz));
		return distance;
	}

	/**
	* Turns the current Vector into a unit Vector.
	*
	* Returns: A normalized Vector.
	*
	*/
	void normalize() {
		double length = sqrt((x * x) + (y * y) + (z * z));
		x = x / length;
		y = y / length;
		z = z / length;
	}
}
