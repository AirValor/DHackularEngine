module dhe.util.geometry.size3d;

import dhe.util.geometry.size2d;

struct Size3D {
	private double d;
	private Size size;

	this(double w, double h, double d) {
		size = Size(w, h);
		this.d = d;
	}

	Size getSize() {
		return size;
	}
}
