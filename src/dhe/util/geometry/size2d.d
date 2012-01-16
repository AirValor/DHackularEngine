module dhe.util.geometry.size2d;

struct Size2D {
	private double w;
	private double h;

	this (double w, double h) {
		this.w = w;
		this.h = h;
	}

	ref double getW() { return w; }
	ref double getH() { return h; }

	void setW(double w) { this.w = w; }
	void setH(double h) { this.h = h; }

	Size2D opBinary(string op)(Size2D size) {
		return Size2D(mixin("w" ~ op ~ "size.w"),
					  mixin("x" ~ op ~ "vector.y"));
	}
}
