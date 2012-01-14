module dhe.util.geometry.size2d;

struct Size {
	private double w;
	private double h;

	this (double w, double h) {
		this.w = w;
		this.h = h;
	}
<<<<<<< HEAD:src/dhe/util/geometry/Size.d

	@property double W() { return w; }
	@property W(double value) {  w = value; }
	@property double H() { return h; }
	@property H(double value) {  h = value; }

	Size opBinary(string op)(Size size) {
		return Size(mixin("w" ~ op ~ "size.w"),
					mixin("x" ~ op ~ "vector.y"));
	}
}
=======
}
>>>>>>> b26c8e43a3542c2eeb4ed12ea1e21f3b93b13601:src/dhe/util/geometry/size2d.d
